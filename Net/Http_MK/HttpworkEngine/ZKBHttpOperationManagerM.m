//
//  ZKBHttpOperationManagerM.m
//  UITest
//
//  Created by zkb on 15/2/11.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBHttpOperationManagerM.h"
#import "ZKBDefine.h"

#import "ZKBHttpReqArgsM.h"
#import "ZKBHttpRequestM.h"
#import "MKNetworkEngine+ZKBNetWorkEngine.h"
#import "ZKBHttpOperationManagerM+ZKBCategory.h"

#import <objc/runtime.h>
#import <objc/message.h>

@interface ZKBHttpOperationManagerM()
{
    MKNetworkEngine         *_httpRequestQueue;//http请求队列
    NSInteger               _iRequestTagCount;//http请求标识， 区分不同的http请求
    NSMutableDictionary     *_httpObserverDict;//http请求观察者字典
}
@end

@implementation ZKBHttpOperationManagerM

SYNTHESIZE_SINGLETON_FOR_CLASS(ZKBHttpOperationManagerM)

- (id)init
{
    self = [super init];
    if (self) {
        _httpObserverDict = [NSMutableDictionary new];
        _iRequestTagCount = 0;
        _httpRequestQueue = [[MKNetworkEngine alloc] init];
    }
    return self;
}


- (ZKBHttpRequestM *)createrRequest:(ZKBHttpReqArgsM *)httpReqArgs userInfo:(NSDictionary*)userInfo
{
    SEL action = NSSelectorFromString([NSString stringWithFormat:@"%@HttpRequest:paraDict:userInfo:", [httpReqArgs requestType]]);
    return objc_msgSend(self, action,httpReqArgs.requestUrl,httpReqArgs.requestArgs,userInfo);
}

- (ZKBHttpRequestM*)getHttpRequest:(NSString*)strUrl
                         paraDict:(NSDictionary*)paraDict
                         userInfo:(NSDictionary*)userInfo
{
    return nil;

}
- (ZKBHttpRequestM*)deleteHttpRequest:(NSString*)strUrl
                            paraDict:(NSDictionary*)paraDict
                            userInfo:(NSDictionary*)userInfo
{
    return nil;
}
- (ZKBHttpRequestM*)postHttpRequest:(NSString*)strUrl
                          paraDict:(NSDictionary*)paraDict
                          userInfo:(NSDictionary*)userInfo
{
    return nil;

}
- (ZKBHttpRequestM*)putHttpRequest:(NSString*)strUrl
                         paraDict:(NSDictionary*)paraDict
                         userInfo:(NSDictionary*)userInfo
{
    return nil;
    
}
- (ZKBHttpRequestM*)patchHttpRequest:(NSString*)strUrl
                           paraDict:(NSDictionary*)paraDict
                           userInfo:(NSDictionary*)userInfo
{
    return nil;
}




@end
