//
//  ZKBHttpRequestOperation+ZKBHttpObserver.m
//  UITest
//
//  Created by zkb on 15/2/10.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBHttpRequestOperation+ZKBHttpObserver.h"

@implementation ZKBHttpRequestOperation (ZKBHttpObserver)
-(void)addHttpObserver:(id)observer tag:(NSInteger)iRequestTag
{
    if (observer)
    {
        [_httpObserverDict setObject:observer
                              forKey:[NSNumber numberWithInteger:iRequestTag]];
    }
}

-(void)removeHttpObserver:(id)observer
{
    NSArray* keyArray = [_httpObserverDict allKeys];
    NSObject* key = nil;
    NSMutableArray* delKeyArray = [NSMutableArray array];
    for (int i = 0; i < [keyArray count]; ++i)
    {
        key = [keyArray objectAtIndex:i];
        if ([_httpObserverDict objectForKey:key] == observer)
        {
            [delKeyArray addObject:key];
        }
    }
    
    [_httpObserverDict removeObjectsForKeys:delKeyArray];
}

-(void)removeHttpObserver:(id)observer tag:(NSInteger)iRequestTag
{
    NSObject* key = [NSNumber numberWithInteger:iRequestTag];
    NSObject* value = [_httpObserverDict objectForKey:key];
    if (value == observer)
    {
        [_httpObserverDict removeObjectForKey:key];
    }
}

-(void)removerHttpObserverWithTag:(NSInteger)iRequestTag
{
    [_httpObserverDict removeObjectForKey:[NSNumber numberWithInteger:iRequestTag]];
}

@end
