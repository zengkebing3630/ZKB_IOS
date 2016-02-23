//
//  TGHttpRequestQueue.h
//  TGYWQ
//
//  Created by Demo Li on 15/2/7.
//  Copyright (c) 2015年 Demo Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ZKBHttpRequest.h"
@interface ZKBHttpOperationManager : NSObject

- (NSArray *)operations;

//添加请求到队列
-(void)addOperation:(NSOperation *)op;

//从队列中取消请求
-(void)cancelHttpRquestWithTag:(NSInteger)iRequestTag;

//取消所有请求
-(void)cancelAllRequest;
@end
