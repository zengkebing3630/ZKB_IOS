//
//  TGHttpRequestQueue.m
//  TGYWQ
//
//  Created by Demo Li on 15/2/7.
//  Copyright (c) 2015年 Demo Li. All rights reserved.
//

#import "ZKBHttpOperationManager.h"
#import "ZKBDefine.h"

#define MAX_COUNT 5

@implementation ZKBHttpOperationManager
{
    ASINetworkQueue         *_networkQueue;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        _networkQueue = [[ASINetworkQueue alloc]init];
        [_networkQueue setMaxConcurrentOperationCount:MAX_COUNT];
        [_networkQueue go];
    }
    
    return self;
}

-(void)dealloc
{
    [self cancelAllRequest];
}

- (NSArray *)operations
{
    return [_networkQueue operations];
}

-(void)addOperation:(NSOperation *)op
{
    [_networkQueue addOperation:op];
}

-(void)cancelHttpRquestWithTag:(NSInteger)iRequestTag
{
    for (ASIHTTPRequest *request in [_networkQueue operations])
    {
        if (request.tag == iRequestTag)
        {
            [request clearDelegatesAndCancel];
            break;
        }
    }
}

-(void)cancelAllRequest
{
    for (ASIHTTPRequest *request in [_networkQueue operations])
    {
        [request clearDelegatesAndCancel];
    }
    
    [_networkQueue cancelAllOperations];
}

@end
