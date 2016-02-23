//
//  ZKBNotRecognizeSelectorHandler.h
//  UITest
//
//  Created by zkb on 15/2/13.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZKBNotRecognizeSelectorDelegate <NSObject>
@required
- (void)handlerNotRecognizeSelector:(NSInvocation*)anInvocation;
@end
