//
//  TRDistributeIncident.m
//  PPAppPlatformKitDylib
//
//  Created by zkb on 15/3/3.
//  Copyright (c) 2015年 TR. All rights reserved.
//

#import "TRDistributeIncident.h"

static TRDistributeIncident *distributeIncident = nil;


@implementation TRDistributeIncident


+ (instancetype)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        distributeIncident = [[[self class] alloc] init];
    });
    return distributeIncident;
}


#pragma mark - 事件分发

//Niubility分发事件，多余参数只支持OC<NSCodeing>对象
+ (BOOL)distributeIncidentForNiubility:(NSString *)method,...NS_REQUIRES_NIL_TERMINATION
{
#if TR_SUPPORT_NIUBILITY
    if(!method){
        return NO;
    }
    NSMutableArray * vaList = [NSMutableArray new];
    va_list args;
    // 获取第一个可选参数的地址，此时参数列表指针指向函数参数列表中的第一个可选参数
    va_start(args, method);
    if(method)
    {
        // 遍历参数列表中的参数，并使参数列表指针指向参数列表中的下一个参数
        id nextArg = nil;
        while((nextArg = va_arg(args, id)))
        {
            if(nextArg){
                NSLog(@"nextArg :%@", nextArg);
                [vaList addObject:nextArg];
            }
        }
    }
    va_end(args);
    return  [TRDistributeIncident distributeIncident:TR_SDK_NIUBILITY_INTERFACE_NAME initMethod:TR_SDK_NIUBILITY_INIT_METHOD_NAME method:method args:vaList];
#else
    return NO;
#endif
}

//Niubility分发事件，多余参数只支持OC<NSCodeing>对象
+ (BOOL)distributeIncidentForNiubilityForClass:(NSString *)classMethod,...NS_REQUIRES_NIL_TERMINATION
{
#if TR_SUPPORT_NIUBILITY
    if(!classMethod){
        return NO;
    }
    NSMutableArray * vaList = [NSMutableArray new];
    va_list args;
    // 获取第一个可选参数的地址，此时参数列表指针指向函数参数列表中的第一个可选参数
    va_start(args, classMethod);
    if(classMethod)
    {
        // 遍历参数列表中的参数，并使参数列表指针指向参数列表中的下一个参数
        id nextArg = nil;
        while((nextArg = va_arg(args, id)))
        {
            if(nextArg){
                NSLog(@"nextArg :%@", nextArg);
                [vaList addObject:nextArg];
            }
        }
    }
    va_end(args);
    return  [TRDistributeIncident distributeIncident:TR_SDK_NIUBILITY_INTERFACE_NAME classMethod:classMethod args:vaList];
#else
    return NO;
#endif
}

//分发事件，多余参数只支持OC<NSCodeing>对象
+ (BOOL)distributeIncident:(NSString *)className initMethod:(NSString *)initMethod method:(NSString *)method args:(NSArray *)args
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
        for(int i = 0;i < args.count;i++){
            id argument = [args objectAtIndex:i];
            [invocation setArgument:&argument atIndex:(i + 2)];
        }
        [invocation invoke];
        return YES;
    }
    return NO;
}

////分发事件，多余参数只支持OC<NSCodeing>对象
//+ (BOOL)distributeIncident:(NSString *)className  classMethod:(NSString *)classMethod withObject:(id)object1 withObject:(id)object2
//{
//    if(!className || !classMethod){
//        return NO;
//    }
//    if (NSClassFromString(className)) {
//        SEL initSelector = NSSelectorFromString(classMethod);
//        [NSClassFromString(className) performSelector:initSelector withObject:(id)object1 withObject:(id)object2];
//        return YES;
//    }
//    return NO;
//}

//分发类函数，多余参数只支持OC<NSCodeing>对象
+ (BOOL)distributeIncident:(NSString *)className  classMethod:(NSString *)classMethod args:(NSArray *)args
{
    if(!className || !classMethod){
        return NO;
    }
    if (NSClassFromString(className)) {
        NSMutableString * objcTypes = [[NSMutableString alloc] initWithString:@"v"];
        for (int i = 0; i< args.count; i++) {
            [objcTypes appendFormat:@"@:"];
        }
        NSLog(@"objcTypes:%@",objcTypes);
        
        id target = NSClassFromString(className);
        NSMethodSignature *methodSig = [NSMethodSignature signatureWithObjCTypes:[objcTypes UTF8String]];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        invocation.selector = NSSelectorFromString(classMethod);
        invocation.target = target;
        
        for(int i = 0;i < args.count;i++){
            id argument = [args objectAtIndex:i];
            [invocation setArgument:&argument atIndex:(i + 2)];
        }
        
        [invocation invoke];
        return YES;
    }
    return NO;
}

@end
