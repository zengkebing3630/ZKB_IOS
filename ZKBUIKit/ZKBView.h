//
//  ZKBView.h
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKBDefine.h"
#import "ZKBMainViewDelegate.h"
#import "ZKBViewController.h"

@class ZKBViewController;
@protocol ZKBNavigationBarDelegate;

@interface ZKBView : UIView <ZKBMainViewDelegate>

@property (nonatomic, weak  ) id<ZKBNavigationBarDelegate> navDelegate;//控制栏回调
@property (nonatomic, strong) NSString                 *navTitle;//控制栏标题
@property (nonatomic, strong) UIImage                  *navBgImg;//控制栏背景图
@property (nonatomic, assign) ZKBNavigationItemType    navLeftItemType;//控制栏左边按钮类型
@property (nonatomic, assign) ZKBNavigationItemType    navRighItemType;//控制栏右边按钮类型
@property (nonatomic, assign) BOOL                     navigationBarHidden;//控制栏显示隐藏[默认：NO];

@property (nonatomic,assign ) ZKBViewController        *mainViewController;

@property (nonatomic,strong ) UIView                   *mainView;//主要添加视图
@property (nonatomic,assign ) BOOL                     isBelowTabBar;//是否在TabBar的上面
@end
