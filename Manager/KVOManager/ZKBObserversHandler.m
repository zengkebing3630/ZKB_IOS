//
//  ZKBObserversHandler.m
//  UITest
//
//  Created by zkb on 15/2/10.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBObserversHandler.h"
#import "ZKBKVOManager.h"
#import "ZKBKVOInfo.h"


@interface ZKBObserversHandler()
{
    NSMutableArray *_infos;
    NSLock *_lock;
}
@end
@implementation ZKBObserversHandler
- (id)init
{
    self = [super init];
    if (self) {
        _infos = [NSMutableArray new];
        _lock = [NSLock new];
    }
    return self;
}

#pragma mark - < API > -

- (void)observe:(id)object info:(ZKBKVOInfo *)info
{
    if (nil == info) {
        return;
    }
    
    [_lock lock];
    [_infos addObject:info];
    [_lock unlock];
    [object addObserver:self forKeyPath:info.keyPath options:info.options context:(void *)info];
}

- (void)unobserve:(id)object info:(ZKBKVOInfo *)info
{
    if (nil == info) {
        return;
    }
    [_lock lock];
    [_infos removeObject:info];
    [_lock unlock];
    
    [object removeObserver:self forKeyPath:info.keyPath context:(void *)info];
}

- (void)unobserve:(id)object infos:(NSSet *)infos
{
    if (0 == infos.count) {
        return;
    }
    
    [_lock lock];
    for (ZKBKVOInfo *info in infos) {
        [_infos removeObject:info];
    }
    [_lock unlock];
    
    for (ZKBKVOInfo *info in infos) {
        [object removeObserver:self forKeyPath:info.keyPath context:(void *)info];
    }
}

#pragma mark - < 分发事件 > -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSAssert(context, @"missing context keyPath:%@ object:%@ change:%@", keyPath, object, change);
    __block ZKBKVOInfo *info = nil;
    [_lock lock];
    [_infos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(ZKBKVOInfo *)obj isEqual:(__bridge ZKBKVOInfo *)context]) {
            info = (ZKBKVOInfo *)obj;
            *stop = YES;
        }
    }];
    [_lock unlock];
    
    if (nil != info) {
        id observer = info.observer;
        if (nil != observer) {
            if (info.block) {
                info.block(observer,object,change);
            }else if (info.action){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                if ([observer respondsToSelector:info.action]) {
                    [observer performSelector:info.action withObject:change withObject:object];
                }
#pragma clang diagnostic pop
            }else{
                if ([observer respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)]) {
                    [observer observeValueForKeyPath:keyPath ofObject:object change:change context:info.context];
                }
            }
        }
    }
}

#pragma mark - < 工具方法 > -

- (NSString *)debugDescription
{
    NSMutableString *s = [NSMutableString stringWithFormat:@"<%@:%p", NSStringFromClass([self class]), self];
    
    // lock
    [_lock lock];
    
    NSMutableArray *infoDescriptions = [NSMutableArray arrayWithCapacity:_infos.count];
    for (ZKBKVOInfo *info in _infos) {
        [infoDescriptions addObject:info.debugDescription];
    }
    
    [s appendFormat:@" contexts:%@", infoDescriptions];
    
    // unlock
    [_lock unlock];
    
    [s appendString:@">"];
    return s;
}
@end
