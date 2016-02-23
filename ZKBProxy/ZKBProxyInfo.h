//
//  ZKBProxyInfo.h
//  Funaction
//
//  Created by zkb on 15/2/12.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - < 注入方法类型 > -
typedef NS_ENUM(NSUInteger, ZKBProxyInjectSelectorType){
    ZKBProxyInjectSelectorTypeStart,
    ZKBProxyInjectSelectorTypeEnd,
    ZKBProxyInjectSelectorTypeNone

};

typedef void(^ZKBProxyCallBack)(NSInvocation*inv,ZKBProxyInjectSelectorType type);

@interface ZKBProxyInfo : NSObject
@property (nonatomic,copy             ) ZKBProxyCallBack           block;

@property (nonatomic,unsafe_unretained) id                         target;
@property (nonatomic,assign           ) SEL                        selector;//原始方法
@property (nonatomic,assign           ) ZKBProxyInjectSelectorType type;
@property (nonatomic,assign           ) SEL                        injectSelector;//注入方法

/**
 *  初始化代理信息
 *
 *  @param target          收件人
 *  @param aSelector       原始方法
 *  @param aInjectSelector 注入方法
 *  @param type            注入方法类型
 *  @param block           回调
 *
 *  @return ZKBProxyInfo对象
 */
+ (instancetype)initProxyInfofor:(id)target
                        selector:(SEL)aSelector
                  injectSelector:(SEL)aInjectSelector
              injectSelectorType:(ZKBProxyInjectSelectorType)type
                           block:(ZKBProxyCallBack)block;

@end
