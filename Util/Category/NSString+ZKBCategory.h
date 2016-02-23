//
//  NSString+TCategory.h
//  WenDa
//
//  Created by keven on 14-11-23.
//  Copyright (c) 2014年 天工网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ZKBCategory)
- (CGSize)sizeCustomWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
/**
 *  格式化成日期
 *
 *  @param dateString 日期格式，etg：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 日期
 */
- (NSDate *)formatToDate:(NSString *)dateFormat;

/**
 *  确定是否有换行符
 *
 *  @param  字符串
 *
 *  @return 字符串
 */
- (BOOL)isHavedWrap;

#pragma mark - < JSON Method > -

- (id)jsonValue;
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;
+ (NSString *)jsonStringWithArray:(NSArray *)array;
+ (NSString *)jsonStringWithString:(NSString *)string;
+ (NSString *)jsonStringWithObject:(id) object;
@end
