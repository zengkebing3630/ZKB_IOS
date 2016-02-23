//
//  ZKBKVOInfo.h
//  UITest
//
//  Created by zkb on 15/2/10.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ZKBKVOCallBackBlock)(id observer, id object, NSDictionary *change);

@class ZKBKVOManager;
@interface ZKBKVOInfo : NSObject 
@property (nonatomic,assign) ZKBKVOManager              *KVOManager;
@property (nonatomic,copy  ) NSString                   *keyPath;
@property (nonatomic,assign) NSKeyValueObservingOptions options;
@property (nonatomic,assign) SEL                        action;
@property (nonatomic,copy  ) ZKBKVOCallBackBlock        block;
@property (nonatomic       ) void                       *context;
@property (nonatomic       ) id                         observer;

- (instancetype)initWithController:(id)observer keyPath:(NSString *)keyPath;
- (instancetype)initWithController:(id)observer keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options;
- (instancetype)initWithController:(id)observer keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options action:(SEL)action;
- (instancetype)initWithController:(id)observer keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
- (instancetype)initWithController:(id)observer keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(ZKBKVOCallBackBlock)block;
@end
