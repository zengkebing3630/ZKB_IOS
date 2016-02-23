//
//  ZKBHttpReqArgsM.h
//  UITest
//
//  Created by zkb on 15/2/11.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKBHttpReqArgsM : NSObject

/**
 *  得到组装后字典数据
 *
 *  @return 组装后字典数据
 */
- (NSDictionary*)requestArgs;



#pragma mark - < 子类继承 > -


/**
 *  得到请求类型-[子类实现][默认：POST]
 *
 *  @return 请求类型
 */
- (NSString *)requestType;

/**
 *  得到组装后完整地址-[子类实现]
 *
 *  @return 组装后完整地址
 */
- (NSString*)requestUrl;

/**
 *  得到组装数据-[子类实现]
 */
- (void)assembleArgs:(NSMutableDictionary *)argsDict;
@end
