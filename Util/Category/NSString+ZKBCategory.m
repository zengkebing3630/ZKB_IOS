//
//  NSString+TCategory.m
//  WenDa
//
//  Created by keven on 14-11-23.
//  Copyright (c) 2014年 天工网络科技有限公司. All rights reserved.
//

#import "NSString+ZKBCategory.h"
#import "ZKBDefine.h"

@implementation NSString (ZKBCategory)
- (CGSize)sizeCustomWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize;
    if([self respondsToSelector:@selector(sizeWithAttributes:)]){
        NSDictionary *attributes = @{NSFontAttributeName: font};
        CGRect rect = [self boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil];
        resultSize.width = ceilf(rect.size.width);
        resultSize.height = ceilf(rect.size.height);
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
    }
    return resultSize;
}


/**
 *  格式化成日期
 *
 *  @param dateString 日期格式，etg：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 日期
 */
- (NSDate *)formatToDate:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSDate *returnDate= [formatter dateFromString:self];
    ARC_RELEASE(dateFormatter);
    return returnDate;
}


/**
 *  确定是否有换行符
 *
 *  @param  字符串
 *
 *  @return 字符串
 */
- (BOOL)isHavedWrap
{
    const char * cStr = [self  UTF8String];
    BOOL flag = NO;
    for (int i = 0; i < strlen(cStr); i++) {
        if (cStr[i] =='\n' ||cStr[i] == '\x0a' || cStr[i] == '\r'||cStr[i] == '\x0d') {
            flag = YES;
            break;
        }
    }
    return flag;
}


#pragma mark - < JSON Method > -

- (id)jsonValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error != nil)
    {
        return nil;
    }
    
    return result;
}

+ (NSString *)jsonStringWithString:(NSString *) string{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+ (NSString *)jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+ (NSString *)jsonStringWithObject:(id) object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }
    return value;
}

@end
