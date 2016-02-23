//
//  ZKBHttpRequestOperation+ZKBHttpObserver.h
//  UITest
//
//  Created by zkb on 15/2/10.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBHttpRequestOperation.h"

@interface ZKBHttpRequestOperation (ZKBHttpObserver)

-(void)removeHttpObserver:(id)observer;
-(void)removerHttpObserverWithTag:(NSInteger)iRequestTag;
-(void)removeHttpObserver:(id)observer tag:(NSInteger)iRequestTag;

-(void)addHttpObserver:(id)observer tag:(NSInteger)iRequestTag;

@end
