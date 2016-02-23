//
//  KTTools.m
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBTools.h"
#import "ZKBDefine.h"
@implementation ZKBTools

/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “987567”
 *
 *  @return UIColor*
 */
+ (UIColor *)TColor:(NSString *)hexColor
{
    return [ZKBTools TColor:hexColor colorAlpha:Alpha10];
}

/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “987567”
 *  @param alpha    0 ~ 1
 *
 *  @return UIColor
 */
+ (UIColor *)TColor:(NSString *)hexColor colorAlpha:(CGFloat)alpha
{
    NSAssert(hexColor, @"获取到颜色UICOLOR -->hexColor not be nil");
    
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]){
        cString = [cString substringFromIndex:2];
    }else if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }else if ([cString length] != 6){
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

/**
 *  当然线程是否是主线程
 *
 *  @return YES主线程 | NO 子线程
 */
+ (BOOL)cureentThreadIsMain
{
    return [[NSThread currentThread] isMainThread];
}

/**
 *  十六进制字符串转换为数值
 *
 *  @param hexString 十六进制字符串
 *
 *  @return 对于的数值
 */
+ (unsigned long)longNumberFromHexString:(NSString *)hexString
{
    NSAssert(hexString, @"longNumberFromHexString -> hexString not be nil");
//   strtoul(const char *nptr,char **endptr,int base);会将参数nptr字符串根据参数base来转换成无符号的长整型数。
    return strtoul([hexString UTF8String],0,0);
}


/**
 *  十六进制转换为普通字符串
 *
 *  @param hexString 十六进制字符串
 *
 *  @return 普通字符串
 */
+ (NSString *)stringFromHexString:(NSString *)hexString
{
    NSAssert(hexString, @"stringFromHexString -> hexString not be nil");
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i< [hexString length] - 1; i += 2) {
        @autoreleasepool {
            unsigned int anInt;
            NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
            NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
            [scanner scanHexInt:&anInt];
            myBuffer[i / 2] = (char)anInt;
        }
    }
   return [NSString stringWithCString:myBuffer encoding:NSUTF8StringEncoding];
}

/**
 *  普通字符串成转换为十六进制字符串
 *
 *  @param hexString 普通字符串
 *
 *  @return 十六进制字符串
 */
+ (NSString *)hexStringFromString:(NSString *)string
{
    NSAssert(string, @"hexStringFromString -> string not be nil");
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    NSString *hexStr = nil;
    for(int i=0;i<[myD length];i++)  {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];//16进制数
        if([newHexStr length] == 1){
           hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        } else{
           hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr;
}

//data 转int
+ (int)intNumberFromData:(NSData *)data
{
    NSAssert(data, @"intNumberFromData -> data not be nil");
    int i = -1;
    [data getBytes:&i length:sizeof(i)];
    return i;
}

//int 转data
+ (NSData *)dataFromInt:(int)aNumber
{
    return [NSData dataWithBytes:&aNumber length:sizeof(aNumber)];
}


//是否包含表情字符
+ (BOOL)isContainsEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}


/**
 *  计算指定时间与当前的时间差
 *
 *  @param compareDateString  时间字符串(格式:2013-3-2 8:28:53)
 *
 *  @return (比如，3分钟前，1个小时前，2015年1月10日)
 *
 *  ADD BY ZHANGZH
 */
+ (NSString *)compareCurrentTime:(NSString *)compareDateString
{
    //把时间字符串转化为NSDate
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *compareDate = [formatter dateFromString:compareDateString];
    
    NSTimeInterval timeInterval=[compareDate timeIntervalSinceNow];
    timeInterval=-timeInterval;
    long temp=0;
    NSString *compareResult;
    if(timeInterval<60)
    {
        compareResult=[NSString stringWithFormat:@"[%f秒前]",timeInterval];
    }
    else if((temp=timeInterval/60)<60)
    {
         compareResult=[NSString stringWithFormat:@"[%ld分钟前]",temp];
    }
    else if((temp=temp/60)<24)
    {
        compareResult=[NSString stringWithFormat:@"[%ld小时前]",temp];
    }
    else if((temp=temp/24)<30)
    {
        compareResult=[NSString stringWithFormat:@"[%ld天前]",temp];
    }
    else if((temp=temp/30)<12)
    {
        compareResult=[NSString stringWithFormat:@"[%ld个月前]",temp];
    }
    else
    {
        temp=temp/12;
        compareResult=[NSString stringWithFormat:@"[%ld年前]",temp];
    }
    return compareResult;
}


//分发事件，多余参数只支持OC<NSCodeing>对象
+ (BOOL)distributeIncident:(NSString *)className initMethod:(NSString *)initMethod method:(NSString *)method,...NS_REQUIRES_NIL_TERMINATION
{
    if(!className || !method || !initMethod){
        return NO;
    }
    if (NSClassFromString(className)) {
        SEL initSelector = NSSelectorFromString(initMethod);
        id target = [NSClassFromString(className) performSelector:initSelector];
        NSMethodSignature *methodSig = [target methodSignatureForSelector:NSSelectorFromString(method)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        invocation.selector = NSSelectorFromString(method);
        invocation.target = target;
        va_list args;
        // 获取第一个可选参数的地址，此时参数列表指针指向函数参数列表中的第一个可选参数
        va_start(args, method);
        int index = 2;
        if(method)
        {
            // 遍历参数列表中的参数，并使参数列表指针指向参数列表中的下一个参数
            id nextArg = nil;
            while((nextArg = va_arg(args, id)))
            {
                if(nextArg){
                    NSLog(@"nextArg :%@", nextArg);
                    [invocation setArgument:&nextArg atIndex:index];
                    index++;
                }
            }
        }
        // 结束可变参数的获取(清空参数列表)
        va_end(args);
        [invocation invoke];
        return YES;
    }
    return NO;
}

//分发事件，多余参数只支持OC<NSCodeing>对象
+ (BOOL)distributeIncident:(NSString *)className  classMethod:(NSString *)classMethod withObject:(id)object1 withObject:(id)object2
{
    if(!className || !classMethod){
        return NO;
    }
    if (NSClassFromString(className)) {
        SEL initSelector = NSSelectorFromString(classMethod);
        [NSClassFromString(className) performSelector:initSelector withObject:(id)object1 withObject:(id)object2];
        return YES;
    }
    return NO;
}

//分发类函数
+ (BOOL)distributeIncident:(NSString *)className  classMethod:(NSString *)classMethod,...NS_REQUIRES_NIL_TERMINATION
{
    if(!className || !classMethod){
        return NO;
    }
    if (NSClassFromString(className)) {
        id target = NSClassFromString(className);
        NSMethodSignature *methodSig = [target methodSignatureForSelector:NSSelectorFromString(classMethod)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        invocation.selector = NSSelectorFromString(classMethod);
        invocation.target = target;
        va_list args;
        // 获取第一个可选参数的地址，此时参数列表指针指向函数参数列表中的第一个可选参数
        va_start(args, classMethod);
        int index = 2;
        if(classMethod)
        {
            // 遍历参数列表中的参数，并使参数列表指针指向参数列表中的下一个参数
            id nextArg = nil;
            while((nextArg = va_arg(args, id)))
            {
                if(nextArg){
                    NSLog(@"nextArg :%@", nextArg);
                    [invocation setArgument:&nextArg atIndex:index];
                    index++;
                }
            }
        }
        // 结束可变参数的获取(清空参数列表)
        va_end(args);
        [invocation invoke];
        return YES;
    }
    return NO;
}
@end
