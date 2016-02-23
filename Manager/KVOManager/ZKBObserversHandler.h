//
//  ZKBObserversHandler.h
//  UITest
//
//  Created by zkb on 15/2/10.
//  Copyright (c) 2015年 zkb. All rights reserved.
//
/*
    添加监听事件 + 事件分发
 */

#import <Foundation/Foundation.h>

@class ZKBKVOManager,ZKBKVOInfo;
@interface ZKBObserversHandler : NSObject
@property (nonatomic,assign) ZKBKVOManager  *KVOManager;
- (void)observe:(id)object info:(ZKBKVOInfo *)info;
- (void)unobserve:(id)object info:(ZKBKVOInfo *)info;
- (void)unobserve:(id)object infos:(NSSet *)infos;
@end
