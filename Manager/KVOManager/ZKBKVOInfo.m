//
//  ZKBKVOInfo.m
//  UITest
//
//  Created by zkb on 15/2/10.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBKVOInfo.h"
#import "ZKBKVOManager.h"

@implementation ZKBKVOInfo

- (instancetype)initWithController:(id)observer
                           keyPath:(NSString *)keyPath
                           options:(NSKeyValueObservingOptions)options
                             block:(ZKBKVOCallBackBlock)block
                            action:(SEL)action
                           context:(void *)context
{
    self = [super init];
    if (nil != self) {
        _observer = observer;
        _block = [block copy];
        _keyPath = [keyPath copy];
        _options = options;
        _action = action;
        _context = context;
    }
    return self;
}

- (instancetype)initWithController:(id)observer keyPath:(NSString *)keyPath
{
    return [self initWithController:observer keyPath:keyPath options:0 block:NULL action:NULL context:NULL];
}

- (instancetype)initWithController:(id)observer keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options
{
    return [self initWithController:observer keyPath:keyPath options:options block:NULL action:NULL context:NULL];
}

- (instancetype)initWithController:(id)observer keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(ZKBKVOCallBackBlock)block
{
    return [self initWithController:observer keyPath:keyPath options:options block:block action:NULL context:NULL];
}

- (instancetype)initWithController:(id)observer keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options action:(SEL)action
{
    return [self initWithController:observer keyPath:keyPath options:options block:NULL action:action context:NULL];
}

- (instancetype)initWithController:(id)observer keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    return [self initWithController:observer keyPath:keyPath options:options block:NULL action:NULL context:context];
}

#pragma mark - < 工具方法 > -

- (NSUInteger)hash
{
    return [_keyPath hash];
}

- (BOOL)isEqual:(id)object
{
    if (nil == object) {
        return NO;
    }
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [_keyPath isEqualToString:((ZKBKVOInfo *)object)->_keyPath];
}

- (NSString *)debugDescription
{
    NSMutableString *s = [NSMutableString stringWithFormat:@"<%@:%p keyPath:%@", NSStringFromClass([self class]), self, _keyPath];
    if (nil != _observer) {
        [s appendFormat:@" observer:<%@:%p>", NSStringFromClass([_observer class]), _observer];
    }
    if (0 != _options) {
        [s appendFormat:@" options:%@", describe_options(_options)];
    }
    if (NULL != _action) {
        [s appendFormat:@" action:%@", NSStringFromSelector(_action)];
    }
    if (NULL != _context) {
        [s appendFormat:@" context:%p", _context];
    }
    if (NULL != _block) {
        [s appendFormat:@" block:%p", _block];
    }
    [s appendString:@">"];
    return s;
}

@end
