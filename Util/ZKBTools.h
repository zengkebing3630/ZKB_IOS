//
//  KTTools.h
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

/**
 *  工具类，只管理类方法，
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZKBTools : NSObject

/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “987567”
 *
 *  @return UIColor*
 */
+ (UIColor *)TColor:(NSString *)hexColor;

/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “987567”
 *  @param alpha    0 ~ 1
 *
 *  @return UIColor
 */
+ (UIColor *)TColor:(NSString *)hexColor colorAlpha:(CGFloat)alpha;

/**
 *  当然线程是否是主线程
 *
 *  @return YES主线程 | NO 子线程
 */
+ (BOOL)cureentThreadIsMain;

/**
 *  十六进制字符串转换为数值
 *
 *  @param hexString 十六进制字符串
 *
 *  @return 对于的数值
 */
+ (unsigned long)longNumberFromHexString:(NSString *)hexString;

/**
 *  十六进制转换为普通字符串
 *
 *  @param hexString 十六进制字符串
 *
 *  @return 普通字符串
 */
+ (NSString *)stringFromHexString:(NSString *)hexString;

/**
 *  普通字符串成转换为十六进制字符串
 *
 *  @param hexString 普通字符串
 *
 *  @return 十六进制字符串
 */
+ (NSString *)hexStringFromString:(NSString *)string;

/**
 *  NSData类型转Int
 *
 *  @param aNumber NSData 二进制数据
 *
 *  @return int类型数字
 */
+ (int)intNumberFromData:(NSData *)data;

/**
 *  Int类型转NSData
 *
 *  @param aNumber int类型数字
 *
 *  @return NSData 二进制数据
 */
+ (NSData *)dataFromInt:(int)aNumber;


/**
 *  是否包含表情字符
 *
 *  @param string 字符串
 *
 *  @return 有：YES || 没有：NO
 */
+ (BOOL)isContainsEmoji:(NSString *)string;

/**
 *  计算指定时间与当前的时间差
 *
 *  @param compareDateString  时间字符串(格式:2013-3-2 8:28:53)
 *
 *  @return (比如，3分钟前，1个小时前，2015年1月10日)
 *
 *  ADD BY ZHANGZH
 */
+ (NSString *)compareCurrentTime:(NSString *)compareDateString;

//分发事件，多余参数只支持OC<NSCodeing>对象
+ (BOOL)distributeIncident:(NSString *)className initMethod:(NSString *)initMethod method:(NSString *)method,...NS_REQUIRES_NIL_TERMINATION;
//分发事件，多余参数只支持OC<NSCodeing>对象
+ (BOOL)distributeIncident:(NSString *)className  classMethod:(NSString *)classMethod withObject:(id)object1 withObject:(id)object2;

+ (BOOL)distributeIncident:(NSString *)className  classMethod:(NSString *)classMethod,...NS_REQUIRES_NIL_TERMINATION;

@end
