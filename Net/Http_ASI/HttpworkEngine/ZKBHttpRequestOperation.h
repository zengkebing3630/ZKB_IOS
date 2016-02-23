//
//  TGFacade.h
//  TGYWQDemo
//
//  Created by Demo Li on 15/2/6.
//  Copyright (c) 2015年 Demo Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKBHttpRequestDelegate.h"

typedef void (^ZKBHttpFailerCallBack)(NSDictionary *response,NSDictionary * userInfo);
typedef void (^ZKBHttpSuccessCallBack)(NSDictionary *dataDict,NSDictionary * userInfo);

#define ZKB_HTTP_REQUEST_TIME_OUT 10 

@class ZKBHttpReqArgs,ZKBHttpOperationManager,ZKBHttpRequest;
@interface ZKBHttpRequestOperation : NSObject
{
    ZKBHttpOperationManager *_httpRequestQueue;//http请求队列
    NSInteger               _iRequestTagCount;//http请求标识， 区分不同的http请求
    NSMutableDictionary     *_httpObserverDict;//http请求观察者字典
}

+ (ZKBHttpRequestOperation*)share;

#pragma mark - < Request > -

- (void)startHttpRequest:(ZKBHttpReqArgs*)httpReqArgs
                observer:(id)observer
                userInfo:(NSDictionary*)userInfo;

- (void)startHttpRequest:(ZKBHttpReqArgs*)httpReqArgs
          failerCallBack:(ZKBHttpFailerCallBack)failerBlock
         successCallBack:(ZKBHttpSuccessCallBack)successBlock
                userInfo:(NSDictionary*)userInfo;

- (ZKBHttpRequest *)createrRequest:(ZKBHttpReqArgs *)httpReqArgs userInfo:(NSDictionary*)userInfo;

- (void)cancelHttpRequestWithTag:(NSInteger)iRequestTag;
- (void)cancelHttpRequestWithObserver:(NSObject*)observer;
- (void)cancelAllRequest;

@end
