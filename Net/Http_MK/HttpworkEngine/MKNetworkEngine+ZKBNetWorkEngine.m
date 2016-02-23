//
//  MKNetworkEngine+ZKBNetWorkEngine.m
//  UITest
//
//  Created by zkb on 15/2/11.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "MKNetworkEngine+ZKBNetWorkEngine.h"

@implementation MKNetworkEngine (ZKBNetWorkEngine)
- (MKNetworkOperation*)operationWithGetURLString:(NSString *)getURLString
{
    MKNetworkOperation *operation = [[MKNetworkOperation alloc] initWithURLString:getURLString
                                                                           params:nil
                                                                       httpMethod:@"GET"];
    operation.shouldSendAcceptLanguageHeader = self.shouldSendAcceptLanguageHeader;
    
    [self prepareHeaders:operation];
    return operation;
}

- (MKNetworkOperation*)operationWithDeleteURLString:(NSString *)deleteURLString
{
    MKNetworkOperation *operation = [[MKNetworkOperation alloc] initWithURLString:deleteURLString
                                                                           params:nil
                                                                       httpMethod:@"DELETE"];
    operation.shouldSendAcceptLanguageHeader = self.shouldSendAcceptLanguageHeader;
    
    [self prepareHeaders:operation];
    return operation;
}

- (MKNetworkOperation*)operationWithPostURLString:(NSString *)postURLString params:(NSDictionary*)body
{
    MKNetworkOperation *operation = [[MKNetworkOperation alloc] initWithURLString:postURLString
                                                                           params:body
                                                                       httpMethod:@"POST"];
    operation.shouldSendAcceptLanguageHeader = self.shouldSendAcceptLanguageHeader;
    
    [self prepareHeaders:operation];
    return operation;
}

- (MKNetworkOperation*)operationWithPutURLString:(NSString *)putURLString params:(NSDictionary*) body
{
    MKNetworkOperation *operation = [[MKNetworkOperation alloc] initWithURLString:putURLString
                                                                           params:body
                                                                       httpMethod:@"PUT"];
    operation.shouldSendAcceptLanguageHeader = self.shouldSendAcceptLanguageHeader;
    
    [self prepareHeaders:operation];
    return operation;
}

- (MKNetworkOperation*)operationWithPatchURLString:(NSString *)patchURLString params:(NSDictionary*) body
{
    MKNetworkOperation *operation = [[MKNetworkOperation alloc] initWithURLString:patchURLString
                                                                           params:body
                                                                       httpMethod:@"PATCH"];
    operation.shouldSendAcceptLanguageHeader = self.shouldSendAcceptLanguageHeader;
    
    [self prepareHeaders:operation];
    return operation;
}
@end
