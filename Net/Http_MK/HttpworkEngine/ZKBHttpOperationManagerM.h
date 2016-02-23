//
//  ZKBHttpOperationManagerM.h
//  UITest
//
//  Created by zkb on 15/2/11.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ZKBMHttpFailerCallBack)(NSDictionary *response,NSDictionary * userInfo);
typedef void (^ZKBMHttpSuccessCallBack)(NSDictionary *dataDict,NSDictionary * userInfo);

@class ZKBHttpReqArgsM,ZKBHttpRequestM;
@interface ZKBHttpOperationManagerM : NSObject

+ (ZKBHttpOperationManagerM *)share;

- (void)startHttpRequest:(ZKBHttpReqArgsM*)httpReqArgs
                observer:(id)observer
                userInfo:(NSDictionary*)userInfo;

- (void)startHttpRequest:(ZKBHttpReqArgsM*)httpReqArgs
          failerCallBack:(ZKBMHttpFailerCallBack)failerBlock
         successCallBack:(ZKBMHttpSuccessCallBack)successBlock
                userInfo:(NSDictionary*)userInfo;

- (ZKBHttpRequestM *)createrRequest:(ZKBHttpReqArgsM *)httpReqArgs
                           userInfo:(NSDictionary*)userInfo;

- (void)cancelHttpRequestWithTag:(NSInteger)iRequestTag;
- (void)cancelHttpRequestWithObserver:(NSObject*)observer;
- (void)cancelAllRequest;
@end
