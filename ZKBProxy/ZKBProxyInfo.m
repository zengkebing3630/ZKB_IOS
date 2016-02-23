//
//  ZKBProxyInfo.m
//  Funaction
//
//  Created by zkb on 15/2/12.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBProxyInfo.h"

@implementation ZKBProxyInfo
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
                           block:(ZKBProxyCallBack)block
{
    ZKBProxyInfo * proxyInfo = [ZKBProxyInfo new];
    proxyInfo.type  = type;
    proxyInfo.block = block;
    proxyInfo.target = target;
    proxyInfo.selector = aSelector;
    proxyInfo.injectSelector = aInjectSelector;
    return proxyInfo;
}
@end
