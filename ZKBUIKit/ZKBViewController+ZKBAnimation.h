//
//  ZKBViewController+ZKBAnimation.h
//  UITest
//
//  Created by keven on 15/2/7.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBViewController.h"
#import "ZKBDefine.h"
@class ZKBView;

@interface ZKBViewController (ZKBAnimation)

+ (void)pushView:(ZKBView *)pushView  pushModel:(ZKBAnimationPushModel)model animantion:(BOOL)animation  callBack:(ZKBCallBack)block;
+ (void)popView:(ZKBView *)popView  popModel:(ZKBAnimationPopModel)model animation:(BOOL)animation callBack:(ZKBCallBack)block;

@end
