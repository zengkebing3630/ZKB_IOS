//
//  ZKBProxy.m
//  Funaction
//
//  Created by zkb on 15/2/12.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBProxy.h"

@interface ZKBProxy (/*pravite*/)
{
    NSMutableArray *_proxyInfos;
}
@end

@implementation ZKBProxy

- (void)forwardInvocation:(NSInvocation *)invocation
{
    SEL aSel = invocation.selector;
    if (!_proxiedObject || ![_proxyInfos respondsToSelector:aSel]) {
        if (!_notRecognizeSelectorHandler) {
            return;
        }
        NSMethodSignature * signature = [(NSObject *)_notRecognizeSelectorHandler methodSignatureForSelector:@selector(handlerNotRecognizeSelector:)];
        NSInvocation * handlerInvocation = [NSInvocation invocationWithMethodSignature:signature];
        [handlerInvocation setArgument:&invocation atIndex:2];
        invocation = handlerInvocation; //把事件分发给 notRecognizeSelectorClassHandler 这个类
    }else{
        invocation.target = _proxiedObject; //最终的收件人还是被代理人
    }
    
    
    void (^invokeSelectors)(NSArray*) = ^(NSArray*interceptors){
        @autoreleasepool {
            [interceptors enumerateObjectsUsingBlock:^(ZKBProxyInfo *oneInfo, NSUInteger idx, BOOL *stop) {
                if (oneInfo.block) {
                    return oneInfo.block(invocation,oneInfo.type);
                }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                if (oneInfo.target && oneInfo.injectSelector) {
                    [oneInfo.target performSelector:oneInfo.injectSelector withObject:invocation];
                }
#pragma clang diagnostic pop
            }];
        }
    };
    
    NSPredicate * samePredicate = [NSPredicate predicateWithBlock:^BOOL(ZKBProxyInfo*info, NSDictionary *x) {
        return info.selector == aSel;
    }];
    NSArray *sameSelectors =  [_proxyInfos filteredArrayUsingPredicate:samePredicate];
    
    
    NSPredicate * startPredicate = [NSPredicate predicateWithBlock:^BOOL(ZKBProxyInfo*info, NSDictionary *x) {
        return info.type == ZKBProxyInjectSelectorTypeStart;
    }];
    NSArray * startSelectors = [sameSelectors filteredArrayUsingPredicate:startPredicate];
    invokeSelectors(startSelectors);//分发事件给被注入前方法
    
    [self invokeOriginalMethod:invocation];//分发事件给被注入对象

    NSPredicate * endPredicate = [NSPredicate predicateWithBlock:^BOOL(ZKBProxyInfo*info, NSDictionary *x) {
        return info.type == ZKBProxyInjectSelectorTypeEnd;
    }];
    NSArray * endSelectors = [sameSelectors filteredArrayUsingPredicate:endPredicate];
    invokeSelectors(endSelectors);//分发事件给被注入后方法
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature * sig = [_proxiedObject methodSignatureForSelector:sel];
    if (sig) {
        return sig;
    }
    if (_notRecognizeSelectorHandler) {
        if ([_notRecognizeSelectorHandler respondsToSelector:@selector(handlerNotRecognizeSelector:)]) {
            return [(NSObject *)_notRecognizeSelectorHandler methodSignatureForSelector:@selector(handlerNotRecognizeSelector:)];
        }
    }
    return nil;
}

//分发事件
- (void)invokeOriginalMethod:(NSInvocation*)inv
{
    if ([inv.target respondsToSelector:inv.selector]) {
        [inv invoke];
    }
}


#pragma mark - < 工具方法 > -

- (BOOL)isKindOfClass:(Class)cls;
{
    return [_proxiedObject isKindOfClass:cls];
}

- (BOOL)conformsToProtocol:(Protocol*)prt
{
    return [_proxiedObject conformsToProtocol:prt];
}

- (BOOL)respondsToSelector:(SEL)sel
{
    return [_proxiedObject respondsToSelector:sel];
}


#pragma mark - < 初始化方法 > -

- (id)initWithProxiedObject:(id)aProxiedObject
{
    _proxiedObject = aProxiedObject;
    _proxyInfos = [NSMutableArray new];
    return self ?: nil;
}

+ (instancetype)setupWithProxiedObject:(id)aProxiedObject
{
    if (!aProxiedObject) {
        return nil;
    }
    return [self.class.alloc initWithProxiedObject:aProxiedObject];
}

+ (instancetype)setupWithProxiedObjectClass:(Class)aClass
{
    if (!aClass) {
        return nil;
    }
    
    return [self.class.alloc initWithProxiedObject:[aClass new]];
}

+ (instancetype)setupWithProxiedObjectClassString:(NSString *)aClassStr
{
    if (!aClassStr) {
        return nil;
    }
    Class aClass = NSClassFromString(aClassStr);
    return [ZKBProxy setupWithProxiedObjectClass:aClass];
}

#pragma mark - < 注入方法 > -

/**
 *  设置代理信息
 *
 *  @param aSelector       原始方法
 *  @param block           回调
 */
- (void)setupProxy:(SEL)aSelector
             block:(ZKBProxyCallBack)block
{
    if (block == NULL) {
        return;
    }
    [self setupProxy:nil
            selector:nil
      injectSelector:nil
  injectSelectorType:ZKBProxyInjectSelectorTypeNone
               block:block];
}


/**
 *  设置代理信息
 *
 *  @param target          收件人
 *  @param aSelector       原始方法
 *  @param aInjectSelector 运行原始方法前注入方法
 */
- (void)setupProxy:(id)target
          selector:(SEL)aSelector
startInjectSelector:(SEL)aStartInjectSelector
{
    if (!target) {
        return;
    }
    [self setupProxy:target
            selector:aSelector
      injectSelector:aStartInjectSelector
  injectSelectorType:ZKBProxyInjectSelectorTypeStart
               block:nil];
}

/**
 *  设置代理信息
 *
 *  @param target          收件人
 *  @param aSelector       原始方法
 *  @param aInjectSelector 运行原始方法后注入方法
 */
- (void)setupProxyBy:(id)target
            selector:(SEL)aSelector
   endInjectSelector:(SEL)aEndInjectSelector
{
    if (!target) {
        return;
    }
    [self setupProxy:target
            selector:aSelector
      injectSelector:aEndInjectSelector
  injectSelectorType:ZKBProxyInjectSelectorTypeEnd
               block:nil];
}


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
injectSelectorType:(ZKBProxyInjectSelectorType)type
{
    if (!target) {
        return;
    }
    [self setupProxy:target
            selector:aSelector
      injectSelector:aInjectSelector
  injectSelectorType:type
               block:nil];
}

/**
 *  设置代理信息
 *
 *  @param target          收件人
 *  @param aSelector       原始方法
 *  @param aInjectSelector 注入方法
 *  @param type            注入方法类型
 *  @param block           回调
 */
- (void)setupProxy:(id)target
          selector:(SEL)aSelector
    injectSelector:(SEL)aInjectSelector
injectSelectorType:(ZKBProxyInjectSelectorType)type
             block:(ZKBProxyCallBack)block
{
    if (!target && block == NULL) {
        return;
    }
    ZKBProxyInfo * info = [ZKBProxyInfo initProxyInfofor:target
                                                selector:aSelector
                                          injectSelector:aInjectSelector
                                      injectSelectorType:type
                                                   block:block];
    [_proxyInfos addObject:info];
}
@end
