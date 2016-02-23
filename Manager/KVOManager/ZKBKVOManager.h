//
//  ZKBKVOManager.h
//  UITest
//
//  Created by zkb on 15/2/10.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKBKVOInfo.h"
static NSString *describe_option(NSKeyValueObservingOptions option)
{
    switch (option) {
        case NSKeyValueObservingOptionNew:
            return @"NSKeyValueObservingOptionNew";
            break;
        case NSKeyValueObservingOptionOld:
            return @"NSKeyValueObservingOptionOld";
            break;
        case NSKeyValueObservingOptionInitial:
            return @"NSKeyValueObservingOptionInitial";
            break;
        case NSKeyValueObservingOptionPrior:
            return @"NSKeyValueObservingOptionPrior";
            break;
        default:
            NSCAssert(NO, @"unexpected option %tu", option);
            break;
    }
    return nil;
}

static void append_option_description(NSMutableString *s, NSUInteger option)
{
    if (0 == s.length) {
        [s appendString:describe_option(option)];
    } else {
        [s appendString:@"|"];
        [s appendString:describe_option(option)];
    }
}

static NSUInteger enumerate_flags(NSUInteger *ptrFlags)
{
    NSCAssert(ptrFlags, @"expected ptrFlags");
    if (!ptrFlags) {
        return 0;
    }
    
    NSUInteger flags = *ptrFlags;
    if (!flags) {
        return 0;
    }
    
    NSUInteger flag = 1 << __builtin_ctzl(flags);
    flags &= ~flag;
    *ptrFlags = flags;
    return flag;
}


static NSString *describe_options(NSKeyValueObservingOptions options)
{
    NSMutableString *s = [NSMutableString string];
    NSUInteger option;
    while (0 != (option = enumerate_flags(&options))) {
        append_option_description(s, option);
    }
    return s;
}


@interface ZKBKVOManager : NSObject

+ (ZKBKVOManager *)share;

- (void)observe:(id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options;
- (void)observe:(id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(ZKBKVOCallBackBlock)block;
- (void)observe:(id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options action:(SEL)action;
- (void)observe:(id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

- (void)observe:(id)object keyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options block:(ZKBKVOCallBackBlock)block;
- (void)observe:(id)object keyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options action:(SEL)action;
- (void)observe:(id)object keyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options context:(void *)context;

- (void)unobserve:(id)object keyPath:(NSString *)keyPath;
- (void)unobserve:(id)object;
- (void)unobserveAll;

- (void)logout;

@end
