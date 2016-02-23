//
//  ZKBObject.h
//  UITest
//
//  Created by zkb on 15/2/13.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKBObject : NSObject
/**
 *  开启NotRecognizeSelector 容错处理
 *
 *  @param isOpen 开启：YES  | 关闭 ： NO
 */
- (void)openNotRecognizeSelectorHandler:(BOOL)isOpen;
@end
