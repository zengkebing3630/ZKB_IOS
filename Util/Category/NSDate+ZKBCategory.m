//
//  NSDate+ZKBCategory.m
//  UITest
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "NSDate+ZKBCategory.h"
#import "ZKBDefine.h"

@implementation NSDate (ZKBCategory)
/**
 *  格式化日期
 *
 *  @param dateFormat 日期格式，etg：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 字符串
 */
- (NSString *)formatToString:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString *returnString = [formatter stringFromDate:self];
    ARC_RELEASE(dateFormatter);
    return returnString;
}
@end
