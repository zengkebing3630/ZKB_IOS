//
//  ZKBNewClass.h
//  UITest
//
//  Created by zkb on 15/2/11.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKBNewClass : NSObject
+ (ZKBNewClass *)share;


#pragma mark - < 工具方法 > -
//注册新类
+ (BOOL)registerNewClass:(NSString *)aClassStr;
+ (BOOL)registerNewClass:(NSString *)aClassStr superObject:(id)superObject;
+ (BOOL)registerNewClass:(NSString *)aClassStr superclass:(Class)superclass;

//删除类
+ (BOOL)removeClass:(Class)aClass;
+ (BOOL)removeClassByObject:(id)aObject;



//实例化对象
+ (id)initInstanceWithClass:(Class)aClass;
+ (id)initInstanceWithClassString:(NSString *)aClassStr;

//摧毁实例化对象
+ (BOOL)removeInstance:(id)objc;








@end
