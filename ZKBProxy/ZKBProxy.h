//
//  ZKBProxy.h
//  Funaction
//
//  Created by zkb on 15/2/12.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

/*
    NSProxy类以及子类不能用 alloc，init初始化，初始化方法需要自己写
 */
#import <Foundation/Foundation.h>
#import "ZKBProxyInfo.h"
#import "ZKBNotRecognizeSelectorDelegate.h"

@interface ZKBProxy : NSProxy

@property (nonatomic,strong)id <ZKBNotRecognizeSelectorDelegate> notRecognizeSelectorHandler;

//被注入代码的实例对象
@property (nonatomic,readonly) id proxiedObject;

#pragma mark - <把事件重新分发给proxiedObject> -

//可以Override得到具体分发事件
- (void) invokeOriginalMethod:(NSInvocation*)anInvocation;

#pragma mark - < 工具方法 > -

- (BOOL)isKindOfClass:(Class)cls;
- (BOOL)conformsToProtocol:(Protocol*)prt;
- (BOOL)respondsToSelector:(SEL)sel;

#pragma mark - < 初始化方法 > -

- (id)initWithProxiedObject:(id)aProxiedObject;
+ (instancetype)setupWithProxiedObject:(id)aProxiedObject;
+ (instancetype)setupWithProxiedObjectClass:(Class)aClass;
+ (instancetype)setupWithProxiedObjectClassString:(NSString *)aClassStr;



#pragma mark - < 注入方法 > -

/**
 *  设置代理信息
 *
 *  @param aSelector       原始方法
 *  @param block           回调
 */
- (void)setupProxy:(SEL)aSelector
             block:(ZKBProxyCallBack)block;


/**
 *  设置代理信息
 *
 *  @param target          收件人
 *  @param aSelector       原始方法
 *  @param aInjectSelector 运行原始方法前注入方法
 */
- (void)setupProxy:(id)target
          selector:(SEL)aSelector
startInjectSelector:(SEL)aStartInjectSelector;
/**
 *  设置代理信息
 *
 *  @param target          收件人
 *  @param aSelector       原始方法
 *  @param aInjectSelector 运行原始方法后注入方法
 */
- (void)setupProxyBy:(id)target
            selector:(SEL)aSelector
   endInjectSelector:(SEL)aEndInjectSelector;


/**
 *  设置代理信息
 *
 *  @param target          收件人
 *  @param aSelector       原始方法
 *  @param aInjectSelector 注入方法
 *  @param type            注入方法类型
 */
- (void)setupProxy:(id)target
          selector:(SEL)aSelector
    injectSelector:(SEL)aInjectSelector
injectSelectorType:(ZKBProxyInjectSelectorType)type;

@end
