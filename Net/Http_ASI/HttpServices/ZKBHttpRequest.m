//
//  TGHttpRequest.m
//  TGYWQ
//
//  Created by Demo Li on 15/2/7.
//  Copyright (c) 2015年 Demo Li. All rights reserved.
//

#import "ZKBHttpRequest.h"
#import "NSString+ZKBCategory.h"

@implementation ZKBHttpRequest
- (id)responseJsonValue
{
    NSString* strResponse = [self responseString];
    id response = [strResponse jsonValue];
    return response;
}

@end
