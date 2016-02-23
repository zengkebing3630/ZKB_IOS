//
//  TRDistributeIncident.h
//  PPAppPlatformKitDylib
//
//  Created by zkb on 15/3/3.
//  Copyright (c) 2015年 TR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRAddModuleDefine.h"

@interface TRDistributeIncident : NSObject

+(instancetype)getInstance;

#pragma mark - 事件分发
//分发事件，多余参数只支持OC<NSCodeing>对象
//+ (BOOL)distributeIncident:(NSString *)className  classMethod:(NSString *)classMethod withObject:(id)object1 withObject:(id)object2;

#pragma mark - Niubility分发事件方法

//Niubility分发事件，多余参数只支持OC<NSCodeing>对象，分发实例函数
+ (BOOL)distributeIncidentForNiubility:(NSString *)method,...NS_REQUIRES_NIL_TERMINATION;
//Niubility分发事件，多余参数只支持OC<NSCodeing>对象，分发类函数
+ (BOOL)distributeIncidentForNiubilityForClass:(NSString *)classMethod,...NS_REQUIRES_NIL_TERMINATION;

#pragma mark - 分发事件工具方法
//分发事件，多余参数只支持OC<NSCodeing>对象，分发实例函数
+ (BOOL)distributeIncident:(NSString *)className initMethod:(NSString *)initMethod method:(NSString *)method args:(NSArray *)args;
//分发事件，多余参数只支持OC<NSCodeing>对象,分发类函数
+ (BOOL)distributeIncident:(NSString *)className  classMethod:(NSString *)classMethod args:(NSArray *)args;
@end
