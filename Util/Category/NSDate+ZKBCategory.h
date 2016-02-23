//
//  NSDate+ZKBCategory.h
//  UITest
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZKBCategory)
/**
 *  格式化日期
 *
 *  @param dateFormat 日期格式，etg：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 字符串
 */
- (NSString *)formatToString:(NSString *)dateFormat;
@end
