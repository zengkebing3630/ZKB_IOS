//
//  ZKBHttpReqArgsM.m
//  UITest
//
//  Created by zkb on 15/2/11.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBHttpReqArgsM.h"

static NSString * ZKBHttpRequestMTypeGet    = @"get";
static NSString * ZKBHttpRequestMTypeDelete = @"delete";
static NSString * ZKBHttpRequestMTypePost   = @"post";
static NSString * ZKBHttpRequestMTypePut    = @"put";
static NSString * ZKBHttpRequestMTypePatch  = @"patch";

@interface ZKBHttpReqArgsM()
{
    NSMutableDictionary *_requestArgs;
}
@end

@implementation ZKBHttpReqArgsM

- (NSMutableDictionary *)requestArgs
{
    if (!_requestArgs) {
        _requestArgs = [[NSMutableDictionary alloc] init];
    }
    [self assembleArgs:_requestArgs];
    return _requestArgs;
}


#pragma mark - < 子类继承 > -

/**
 *  得到请求类型-[子类实现][默认：POST]
 *
 *  @return 请求类型
 */
- (NSString *)requestType{
    NSLog(@"[Class:%@][Method:%@],子类实现此方法",[self class],NSStringFromSelector(_cmd));
    return ZKBHttpRequestMTypePost;
}

/**
 *  得到组装后完整地址-[子类实现]
 *
 *  @return 组装后完整地址
 */
- (NSString*)requestUrl
{
    NSLog(@"[Class:%@][Method:%@],子类实现此方法",[self class],NSStringFromSelector(_cmd));
    return nil;
}

/**
 *  得到组装数据-[子类实现]
 */
- (void)assembleArgs:(NSMutableDictionary *)argsDict;
{
    NSLog(@"[Class:%@][Method:%@],[argsDict:%@],子类实现此方法",[self class],NSStringFromSelector(_cmd),[argsDict description]);
}
@end
