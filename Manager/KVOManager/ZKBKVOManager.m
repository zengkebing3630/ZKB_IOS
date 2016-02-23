//
//  ZKBKVOManager.m
//  UITest
//
//  Created by zkb on 15/2/10.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBKVOManager.h"
#import "ZKBDefine.h"
#import "ZKBObserversHandler.h"

@interface ZKBKVOManager()
{
    NSMutableDictionary * _objectInfosMap;
    NSLock *_lock;
    ZKBObserversHandler * _observerHandler;
}
@end
@implementation ZKBKVOManager

SYNTHESIZE_SINGLETON_FOR_CLASS (ZKBKVOManager)

- (id)init
{
    self = [super init];
    if (self) {
        _observerHandler = [[ZKBObserversHandler alloc] init];
        _observerHandler.KVOManager = self;
        
        _objectInfosMap = [NSMutableDictionary new];
        _lock = [NSLock new];
    }
    return self;
}

- (void)logout
{
    [self unobserveAll];
}


#pragma mark Utilities -

- (void)_observe:(id)object info:(ZKBKVOInfo *)info
{
    [_lock lock];
    NSMutableSet *infos = [_objectInfosMap objectForKey:object];
    ZKBKVOInfo *existingInfo = [infos member:info];
    if (nil != existingInfo) {
        NSLog(@"observation info already exists %@", existingInfo);
        
        // unlock and return
        [_lock unlock];
        return;
    }
    
    // lazilly create set of infos
    if (nil == infos) {
        infos = [NSMutableSet set];
        [_objectInfosMap setObject:infos forKey:object];
    }
    
    // add info and oberve
    [infos addObject:info];
    
    [_lock unlock];
    
    [_observerHandler observe:object info:info];
}

- (void)_unobserve:(id)object info:(ZKBKVOInfo *)info
{
    [_lock lock];
    // get observation infos
    NSMutableSet *infos = [_objectInfosMap objectForKey:object];
    // lookup registered info instance
    ZKBKVOInfo *registeredInfo = [infos member:info];
    
    if (nil != registeredInfo) {
        [infos removeObject:registeredInfo];
        
        // remove no longer used infos
        if (0 == infos.count) {
            [_objectInfosMap removeObjectForKey:object];
        }
    }
    
    [_lock unlock];

    [_observerHandler unobserve:object info:registeredInfo];

}

- (void)_unobserve:(id)object
{
    [_lock lock];
    NSMutableSet *infos = [_objectInfosMap objectForKey:object];
    // remove infos
    [_objectInfosMap removeObjectForKey:object];
    [_lock unlock];

    // unobserve
    [_observerHandler unobserve:object infos:infos];
}

- (void)_unobserveAll
{
    // lock
    [_lock lock];
    
    NSMutableDictionary *objectInfoMaps = [_objectInfosMap copy];
    
    // clear table and map
    [_objectInfosMap removeAllObjects];
    
    // unlock
    [_lock unlock];
    
    
    for (id object in objectInfoMaps.allKeys) {
        // unobserve each registered object and infos
        NSSet *infos = [objectInfoMaps objectForKey:object];
        [_observerHandler unobserve:object infos:infos];
    }
}

#pragma mark - < API >-

- (void)observe:(id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options
{
    NSAssert(0 != keyPath.length, @"missing required parameters observe:%@ keyPath:%@", object, keyPath);
    if (nil == object || 0 == keyPath.length) {
        return;
    }
    
    ZKBKVOInfo *info = [[ZKBKVOInfo alloc] initWithController:self keyPath:keyPath options:options];
    info.KVOManager = self;

    [self _observe:object info:info];
}

- (void)observe:(id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(ZKBKVOCallBackBlock)block
{
    NSAssert(0 != keyPath.length && NULL != block, @"missing required parameters observe:%@ keyPath:%@ block:%p", object, keyPath, block);
    if (nil == object || 0 == keyPath.length || NULL == block) {
        return;
    }
    
    // create info
    ZKBKVOInfo *info = [[ZKBKVOInfo alloc] initWithController:self keyPath:keyPath options:options block:block];
    info.KVOManager = self;

    // observe object with info
    [self _observe:object info:info];
}

- (void)observe:(id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options action:(SEL)action
{
    NSAssert(0 != keyPath.length && NULL != action, @"missing required parameters observe:%@ keyPath:%@ action:%@", object, keyPath, NSStringFromSelector(action));
    if (nil == object || 0 == keyPath.length || NULL == action) {
        return;
    }
    
    // create info
    ZKBKVOInfo *info = [[ZKBKVOInfo alloc] initWithController:self keyPath:keyPath options:options action:action];
    info.KVOManager = self;

    // observe object with info
    [self _observe:object info:info];
}

- (void)observe:(id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    NSAssert(0 != keyPath.length, @"missing required parameters observe:%@ keyPath:%@", object, keyPath);
    if (nil == object || 0 == keyPath.length) {
        return;
    }
    
    // create info
    ZKBKVOInfo *info = [[ZKBKVOInfo alloc] initWithController:self keyPath:keyPath options:options context:context];
    info.KVOManager = self;
    // observe object with info
    [self _observe:object info:info];
}



- (void)observe:(id)object keyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options block:(ZKBKVOCallBackBlock)block
{
    NSAssert(0 != keyPaths.count && NULL != block, @"missing required parameters observe:%@ keyPath:%@ block:%p", object, keyPaths, block);
    if (nil == object || 0 == keyPaths.count || NULL == block) {
        return;
    }
    
    for (NSString *keyPath in keyPaths)
    {
        [self observe:object keyPath:keyPath options:options block:block];
    }
}

- (void)observe:(id)object keyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options action:(SEL)action
{
    NSAssert(0 != keyPaths.count && NULL != action, @"missing required parameters observe:%@ keyPath:%@ action:%@", object, keyPaths, NSStringFromSelector(action));
    if (nil == object || 0 == keyPaths.count || NULL == action) {
        return;
    }
    
    for (NSString *keyPath in keyPaths)
    {
        [self observe:object keyPath:keyPath options:options action:action];
    }
}


- (void)observe:(id)object keyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options context:(void *)context
{
    NSAssert(0 != keyPaths.count, @"missing required parameters observe:%@ keyPath:%@", object, keyPaths);
    if (nil == object || 0 == keyPaths.count) {
        return;
    }
    
    for (NSString *keyPath in keyPaths)
    {
        [self observe:object keyPath:keyPath options:options context:context];
    }
}


- (void)unobserve:(id)object keyPath:(NSString *)keyPath
{
    // create representative info
    ZKBKVOInfo *info = [[ZKBKVOInfo alloc] initWithController:self keyPath:keyPath];
    
    // unobserve object property
    [self _unobserve:object info:info];
}


- (void)unobserve:(id)object
{
    if (nil == object) {
        return;
    }
    
    [self _unobserve:object];
}
- (void)unobserveAll
{
    [self _unobserveAll];
}

#pragma mark - < 工具方法 > -

- (NSString *)debugDescription
{
    NSMutableString *s = [NSMutableString stringWithFormat:@"<%@:%p", NSStringFromClass([self class]), self];
    
    // lock
    [_lock lock];
    
    if (0 != _objectInfosMap.count) {
        [s appendString:@"\n  "];
    }
    
    for (id object in _objectInfosMap) {
        NSMutableSet *infos = [_objectInfosMap objectForKey:object];
        NSMutableArray *infoDescriptions = [NSMutableArray arrayWithCapacity:infos.count];
        [infos enumerateObjectsUsingBlock:^(ZKBKVOInfo *info, BOOL *stop) {
            [infoDescriptions addObject:info.debugDescription];
        }];
        [s appendFormat:@"%@ -> %@", object, infoDescriptions];
    }
    
    // unlock
    [_lock unlock];
    
    [s appendString:@">"];
    return s;
}
@end
