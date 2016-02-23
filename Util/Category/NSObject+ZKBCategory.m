//
//  NSObject+TCategory.m
//  Function
//
//  Created by keven on 14-11-21.
//  Copyright (c) 2014年 无线网络科技有限公司. All rights reserved.
//

#import "NSObject+ZKBCategory.h"
#import <objc/message.h>
#import "ZKBDefine.h"



@implementation NSObject (ZKBCategory)

#pragma mark - < 打印 > -

/**
 *   属性列表转换成数组 @[@{property:propertyValue}，@{}] -->IOS反射
 *
 *  @return 属性数组
 */
- (NSMutableArray *)TpropertyList
{    
    NSAssert(![self isKindOfClass:[NSObject class]], @"此方法不能使用NSObeject实例对象");
    NSMutableArray * propertyList = [NSMutableArray new];
    unsigned int outCount, i;
    objc_property_t *propertys = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++) {
        @autoreleasepool {
            objc_property_t property = propertys[i];
            NSString *key = [NSString stringWithUTF8String:property_getName(property)];
            id value = [self valueForKey:key];
            NSDictionary * propertyDict = [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
            [propertyList addObject:propertyDict];
        }
    }
    return ARC_AUTORELEASE(propertyList);
}
@end
