//
//  ZKBNewClass.m
//  UITest
//
//  Created by zkb on 15/2/11.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBNewClass.h"
#import <objc/runtime.h>

@interface ZKBNewClass ()
{
    NSMutableArray * _classPairs;
}
@end

@implementation ZKBNewClass

+ (ZKBNewClass *)share
{
    return nil;
}


- (id)init
{
    self = [super init];
    if (self) {
        _classPairs = [NSMutableArray new];
    }
    return self;
}

- (BOOL)isExistClass:(NSString *)aClassStr
{
    __block BOOL flag = NO;
    if (!aClassStr) {
        return flag;
    }
    
    if (_classPairs.count > 0) {
        [_classPairs enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
            if ([obj isEqualToString:aClassStr]) {
                flag = YES;
                *stop = YES;
            }
        }];
    }
    return flag;
}

- (void)addRegisterClassString:(NSString *)aClassStr
{
    if (!aClassStr) {
        return;
    }
    [_classPairs addObject:aClassStr];
}

#pragma mark - < 工具方法 > -

//注册新类
+ (BOOL)registerNewClass:(NSString *)aClassStr
{
    return [ZKBNewClass registerNewClass:aClassStr superclass:[NSObject class]];
}

+ (BOOL)registerNewClass:(NSString *)aClassStr superObject:(id)superObject
{
    if (!superObject) {
        NSLog(@"superObject not be nil");
        return NO;
    }
    return [ZKBNewClass registerNewClass:aClassStr superclass:[superObject class]];
}

+ (BOOL)registerNewClass:(NSString *)aClassStr superclass:(Class)superclass
{
    if (!aClassStr) {
        return NO;
    }
    
    if (superclass == nil) {
        NSLog(@"superclass not be nil");
        return NO;
    }
    
    if (![[ZKBNewClass share] isExistClass:aClassStr]) {
        Class aClass = objc_allocateClassPair(superclass, [aClassStr UTF8String], 0);
        if (aClass == nil) {
            return NO;
        }
        objc_registerClassPair(aClass);
        [[ZKBNewClass share] addRegisterClassString:aClassStr];
    }
    return YES;
}




//删除类
+ (BOOL)removeClass:(Class)aClass
{
    if (aClass == nil) {
        return NO;
    }
    if (aClass == [NSObject class]) {
        return NO;
    }
    objc_disposeClassPair(aClass);
    return YES;
}
+ (BOOL)removeClassByObject:(id)aObject
{
    if (!aObject) {
        return NO;
    }
    return [ZKBNewClass removeClass:[aObject class]];
}





//实例化对象
+ (id)initInstanceWithClass:(Class)aClass
{
    if (!aClass) {
        return nil;
    }
    return  class_createInstance(aClass, 0);
}

+ (id)initInstanceWithClassString:(NSString *)aClassStr
{
    if (!aClassStr) {
        return nil;
    }
    Class aClass = NSClassFromString(aClassStr);
    if (!aClass) {
        if ([ZKBNewClass registerNewClass:aClassStr]) {
            aClass = NSClassFromString(aClassStr);
        }
    }
    return [ZKBNewClass initInstanceWithClass:aClass];
}



//摧毁实例化对象
+ (BOOL)removeInstance:(id)objc
{
    if (!objc) {
        return NO;
    }
    if (!objc_destructInstance(objc)) {
        return NO;
    }
    return YES;
}

@end
