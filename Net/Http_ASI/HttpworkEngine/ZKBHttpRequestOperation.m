//
//  TGFacade.m
//  TGYWQDemo
//
//  Created by Demo Li on 15/2/6.
//  Copyright (c) 2015年 Demo Li. All rights reserved.
//

#import "ZKBHttpRequestOperation.h"
#import "ZKBDefine.h"
#import "ZKBHttpReqArgs.h"
#import "ZKBHttpRequest.h"
#import "ZKBHttpOperationManager.h"
#import "ZKBHttpRequestOperation+ZKBHttpObserver.h"

#import <objc/runtime.h>
#import <objc/message.h>

@implementation ZKBHttpRequestOperation


SYNTHESIZE_SINGLETON_FOR_CLASS(ZKBHttpRequestOperation)

-(id)init
{
    self = [super init];
    if (self)
    {
        _iRequestTagCount = 0;
        _httpRequestQueue = [[ZKBHttpOperationManager alloc]init];
        _httpObserverDict = [[NSMutableDictionary alloc]init];
    }
    
    return self;
}

#pragma mark - < Create Request > -

- (void)startHttpRequest:(ZKBHttpReqArgs*)httpReqArgs observer:(id)observer userInfo:(NSDictionary*)userInfo
{
    ZKBHttpRequest * request = [self createrRequest:httpReqArgs userInfo:userInfo];
    __block ZKBHttpRequest* safeRequest = request;
    
    [request setCompletionBlock:^{
        id response = [safeRequest responseJsonValue];
        NSLog(@"REQUEST success DataDict:%@", response);
        
        if ([ZKBHttpRequestOperation requestSuccess:response]) {
            [self dealRequestSuccess:safeRequest];

        } else {
            [self dealRequestFail:response request:safeRequest];
        }
        
        //移除观察者
        [self removerHttpObserverWithTag:safeRequest.tag];
    }];
    
    [_httpRequestQueue addOperation:request]; // 加入队列
    [self addHttpObserver:observer tag:request.tag];//添加观察者
}

- (void)startHttpRequest:(ZKBHttpReqArgs*)httpReqArgs
          failerCallBack:(ZKBHttpFailerCallBack)failerBlock
         successCallBack:(ZKBHttpSuccessCallBack)successBlock
                userInfo:(NSDictionary*)userInfo
{
    ZKBHttpRequest * request = [self createrRequest:httpReqArgs userInfo:userInfo];
    __block ZKBHttpRequest* safeRequest = request;
    [request setCompletionBlock:^{
        id response = [safeRequest responseJsonValue];
        NSLog(@"REQUEST success DataDict:%@", response);

        if ([ZKBHttpRequestOperation requestSuccess:response]) {
            if (successBlock) {
                successBlock(response,safeRequest.userInfo);
            }
        } else {
            if (failerBlock) {
                failerBlock(response,safeRequest.userInfo);
            }
        }
    }];
    
    [_httpRequestQueue addOperation:request]; // 加入队列
}

- (ZKBHttpRequest *)createrRequest:(ZKBHttpReqArgs *)httpReqArgs userInfo:(NSDictionary*)userInfo

{
    SEL action = NSSelectorFromString([NSString stringWithFormat:@"%@HttpRequest:paraDict:userInfo:", [httpReqArgs requestType]]);
    return objc_msgSend(self, action,httpReqArgs.requestUrl,httpReqArgs.requestArgs,userInfo);
}

- (ZKBHttpRequest*)getHttpRequest:(NSString*)strUrl
                         paraDict:(NSDictionary*)paraDict
                         userInfo:(NSDictionary*)userInfo
{
    if (strUrl == nil){
        return nil;
    }
    NSLog(@"REQUEST data:%@---%@", strUrl, paraDict);

    
    NSURL * url = [ZKBHttpRequestOperation assembleGetURL:strUrl paraDict:paraDict];
    ZKBHttpRequest* request = [[ZKBHttpRequest alloc] initWithURL:url];
    [request setShouldAttemptPersistentConnection:NO];
    [request setTimeOutSeconds:ZKB_HTTP_REQUEST_TIME_OUT];
    [request setUserInfo:userInfo];
    [request setRequestMethod:@"GET"];
    request.tag = ++_iRequestTagCount;
    return request;
}

- (ZKBHttpRequest*)deleteHttpRequest:(NSString*)strUrl
                            paraDict:(NSDictionary*)paraDict
                            userInfo:(NSDictionary*)userInfo
{
    return nil;
}

- (ZKBHttpRequest*)postHttpRequest:(NSString*)strUrl
                          paraDict:(NSDictionary*)paraDict
                          userInfo:(NSDictionary*)userInfo
{
    if (strUrl == nil){
        return nil;
    }
    NSLog(@"REQUEST data:%@---%@", strUrl, paraDict);
    NSURL * url = [NSURL URLWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ZKBHttpRequest* request = [[ZKBHttpRequest alloc] initWithURL:url];
    [request setShouldAttemptPersistentConnection:NO];
    [request setTimeOutSeconds:ZKB_HTTP_REQUEST_TIME_OUT];
    [request setUserInfo:userInfo];
    request.tag = ++_iRequestTagCount;
    [ZKBHttpRequestOperation addPostValue:request paraDict:paraDict];
    return request;
}

- (ZKBHttpRequest*)putHttpRequest:(NSString*)strUrl
                         paraDict:(NSDictionary*)paraDict
                         userInfo:(NSDictionary*)userInfo
{
    return nil;

}





- (ZKBHttpRequest*)patchHttpRequest:(NSString*)strUrl
                           paraDict:(NSDictionary*)paraDict
                           userInfo:(NSDictionary*)userInfo
{
    return nil;
}


#pragma mark - < Cancel Request > -

- (void)cancelHttpRequestWithTag:(NSInteger)iRequestTag
{
    [_httpRequestQueue cancelHttpRquestWithTag:iRequestTag];
    //移除观察者
    [self removerHttpObserverWithTag:iRequestTag];
}

- (void)cancelHttpRequestWithObserver:(NSObject*)observer
{
    NSArray* keyArray = [_httpObserverDict allKeys];
    NSNumber* key = nil;
    NSMutableArray* delKeyArray = [NSMutableArray array];
    for (int i = 0; i < [keyArray count]; ++i)
    {
        key = [keyArray objectAtIndex:i];
        if ([_httpObserverDict objectForKey:key] == observer)
        {
            [_httpRequestQueue cancelHttpRquestWithTag:[key integerValue]];
            
            [delKeyArray addObject:key];
        }
    }
    
    [_httpObserverDict removeObjectsForKeys:delKeyArray];
}

-(void)cancelAllRequest
{
    //取消HTTP请求
    [_httpRequestQueue cancelAllRequest];
    
    //清空观察者
    [_httpObserverDict removeAllObjects];
    
    _iRequestTagCount = 0;
}


#pragma mark - < 分发事件 > -

//请求失败处理
- (void)dealRequestFail:(id)response request:(ZKBHttpRequest*)request
{
    [self callHttpObserver:request success:NO];
}

//请求成功处理
- (void)dealRequestSuccess:(ZKBHttpRequest*)request
{
    [self callHttpObserver:request success:YES];
}

- (void)callHttpObserver:(ZKBHttpRequest *)request success:(BOOL)isSuccess
{
    NSObject* observer = [_httpObserverDict objectForKey:[NSNumber numberWithInteger:request.tag]];
    if (observer)
    {
        if ([observer respondsToSelector:@selector(requestCallBack:response:tag:userInfo:data:)])
        {
            [(id)observer requestCallBack:isSuccess
                                 response:request.responseJsonValue
                                      tag:request.tag
                                 userInfo:request.userInfo
                                     data:request.responseData];
        }
    }
}

#pragma mark - < 工具方法 > -

//判断请求是否成功
+ (BOOL)requestSuccess:(NSDictionary*)response
{
    BOOL bSuccess = NO;
    if ([response isKindOfClass:[NSDictionary class]])
    {
        id value = [response objectForKey:@"status"];
        if ([value isKindOfClass:[NSNumber class]]
            || [value isKindOfClass:[NSString class]])
        {
            bSuccess = [value integerValue] == 200;
        }
    }
    
    return bSuccess;
}

+ (NSURL *)assembleGetURL:(NSString *)urlStr paraDict:(NSDictionary*)paraDict
{
    if (!urlStr) {
        return nil;
    }
    
    if (!paraDict || paraDict.allKeys.count < 1) {
        return [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSMutableString * overUrlStr = [NSMutableString stringWithString:urlStr];
    NSArray* keyArray = [paraDict allKeys];
    [overUrlStr appendString:@"?"];
    for (int i = 0; i < [keyArray count]; ++i)
    {
        @autoreleasepool {
            NSString*strKey = [keyArray objectAtIndex:i];
            NSString*strVal = [paraDict objectForKey:strKey];
            [overUrlStr appendFormat:@"%@=%@&", strKey, strVal];
        }
    }
    return [NSURL URLWithString:[overUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}


+ (BOOL)addBodyData:(ZKBHttpRequest*)request paraDict:(NSDictionary *)paraDict
{
    if (!request) {
        return NO;
    }
    if (!paraDict || !paraDict.allKeys.count < 1) {
        return YES;
    }
    NSError * error = nil;
    NSData * bodyData = [NSJSONSerialization dataWithJSONObject:paraDict options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!bodyData || error!=nil) {
        return NO;
    }
    [request appendPostData:bodyData];
    return YES;
}

+ (BOOL)addPostValue:(ZKBHttpRequest*)request paraDict:(NSDictionary *)paraDict
{
    if (!request) {
        return NO;
    }
    
    if (!paraDict || !paraDict.allKeys.count < 1) {
        return YES;
    }
    
    //添加请求参数
    NSArray* keyArray = [paraDict allKeys];
    for (int i = 0; i < [keyArray count]; ++i)
    {
        @autoreleasepool {
            NSString* strKey = [keyArray objectAtIndex:i];
            NSString* strVal = [paraDict objectForKey:strKey];
            [request setPostValue:strVal forKey:strKey];
        }
    }
    return YES;
}
@end
