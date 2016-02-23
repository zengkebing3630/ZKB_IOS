//
//  TGHttpReqArgs.m
//  TGYWQ
//
//  Created by Demo Li on 15/2/7.
//  Copyright (c) 2015年 Demo Li. All rights reserved.
//

#import "ZKBHttpReqArgs.h"
#import "ZKBHttpRequestOperation.h"
#import "NSDictionary+ZKBCategory.h"


 static NSString * ZKBHttpRequestTypeGet    = @"get";
 static NSString * ZKBHttpRequestTypeDelete = @"delete";
 static NSString * ZKBHttpRequestTypePost   = @"post";
 static NSString * ZKBHttpRequestTypePut    = @"put";
 static NSString * ZKBHttpRequestTypePatch  = @"patch";

@interface ZKBHttpReqArgs()
{
    NSMutableDictionary *_requestArgs;
}
@end

@implementation ZKBHttpReqArgs

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
- (NSString *)requestType
{
    NSLog(@"[Class:%@][Method:%@],子类实现此方法",[self class],NSStringFromSelector(_cmd));
    return ZKBHttpRequestTypePost;
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
