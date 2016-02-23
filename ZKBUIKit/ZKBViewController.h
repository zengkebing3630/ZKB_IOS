//
//  ZKBViewController.h
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKBDefine.h"
@class ZKBView,ZKBTabBar,ZKBNavigationBar,ZKBTabBarItem,ZKBNavigationItem;
@protocol ZKBTabBarDelegate,ZKBNavigationBarDelegate,ZKBMainViewDelegate;
@interface ZKBViewController : UIViewController  <ZKBTabBarDelegate,ZKBNavigationBarDelegate>
@property (nonatomic,assign         ) id<ZKBMainViewDelegate> delegate;
@property (nonatomic,strong,readonly) ZKBTabBar           *tTabBar;
@property (nonatomic,assign         ) BOOL                tabBarHidden;//[默认：YES]
@property (nonatomic,strong         ) NSArray             *tabBarItems;
@property (nonatomic,strong         ) NSArray             *tabBarViews;


@property (nonatomic,assign         ) ZKBNavigationBar    *tNavigationBar;

- (void)setRootMainView:(ZKBView *)rootMainView;
- (void)setRootMainView:(ZKBView *)rootMainView  animation:(BOOL)animation;
- (void)setRootMainView:(ZKBView *)rootMainView  isBelowTabBar:(BOOL)isBelowTabBar;
- (void)setRootMainView:(ZKBView *)rootMainView  animation:(BOOL)animation isBelowTabBar:(BOOL)isBelowTabBar ;
- (void)setRootMainView:(ZKBView *)rootMainView  animation:(BOOL)animation isBelowTabBar:(BOOL)isBelowTabBar pushModel:(ZKBAnimationPushModel)model;

/**
 *  获取根视图
 *
 *  @return 根视图
 */
- (ZKBView *)getRootMainView;



- (void)pushMainView:(ZKBView *)mainView;
- (void)pushMainView:(ZKBView *)mainView animation:(BOOL)animation;
- (void)pushMainView:(ZKBView *)mainView isBelowTabBar:(BOOL)isBelowTabBar;
- (void)pushMainView:(ZKBView *)mainView animation:(BOOL)animation isBelowTabBar:(BOOL)isBelowTabBar;
- (void)pushMainView:(ZKBView *)mainView animation:(BOOL)animation isBelowTabBar:(BOOL)isBelowTabBar pushModel:(ZKBAnimationPushModel)model;



- (void)popMainViewWithAnimated:(BOOL)animated;
- (void)popMainViewWithAnimated:(BOOL)animated popModel:(ZKBAnimationPopModel)model;

- (void)popToMainView:(ZKBView *)mainView;
- (void)popToMainView:(ZKBView *)mainView animated:(BOOL)animated;
- (void)popToMainView:(ZKBView *)mainView animated:(BOOL)animated popModel:(ZKBAnimationPopModel)model;

- (void)popToRootMainViewAnimated:(BOOL)animated;
- (void)popToRootMainViewAnimated:(BOOL)animated popModel:(ZKBAnimationPopModel)model;

@end
