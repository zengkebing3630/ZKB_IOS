//
//  ZKBViewController.m
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBViewController.h"
#import "ZKBView.h"
#import "ZKBTabBar.h"
#import "ZKBNavigationBar.h"
#import "ZKBMainViewDelegate.h"
#import "ZKBViewController+ZKBAnimation.h"



@interface ZKBViewController ()
{
    NSMutableArray	*_conViewArray;
}
@end

@implementation ZKBViewController
@dynamic tabBarItems,tabBarHidden;

- (void)loadView
{
    self.view = ({
        UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        view.clipsToBounds = YES;
        view;
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _conViewArray = [NSMutableArray new];
    _tTabBar =({
        ZKBTabBar * aTabBar = [[ZKBTabBar alloc] initWithFrame:CGRectMake(0, [self.view getHeight_] - ZKB_TAB_BAR_HEIGHT, [self.view getWidth_], ZKB_TAB_BAR_HEIGHT)];
        aTabBar.delegate = self;
        aTabBar.hidden = YES;
        aTabBar;
    });
    [self.view addSubview:_tTabBar];
    [self updateTabBar:_tTabBar hidden:_tTabBar.hidden];
}


#pragma mark - < RootView > -

- (void)setRootMainView:(ZKBView *)rootMainView
{
    [self setRootMainView:rootMainView animation:NO isBelowTabBar:NO pushModel:ZKBAnimationPushModelDefault];
}

- (void)setRootMainView:(ZKBView *)rootMainView  animation:(BOOL)animation
{
    [self setRootMainView:rootMainView animation:animation isBelowTabBar:NO pushModel:ZKBAnimationPushModelDefault];
}

- (void)setRootMainView:(ZKBView *)rootMainView  isBelowTabBar:(BOOL)isBelowTabBar
{
    [self setRootMainView:rootMainView animation:NO isBelowTabBar:isBelowTabBar pushModel:ZKBAnimationPushModelDefault];
}

- (void)setRootMainView:(ZKBView *)rootMainView  animation:(BOOL)animation isBelowTabBar:(BOOL)isBelowTabBar
{
    [self setRootMainView:rootMainView animation:animation isBelowTabBar:isBelowTabBar pushModel:ZKBAnimationPushModelDefault];
}

- (void)setRootMainView:(ZKBView *)rootMainView  animation:(BOOL)animation isBelowTabBar:(BOOL)isBelowTabBar pushModel:(ZKBAnimationPushModel)model
{
    DLog(@"setRootMainView");
    
    ZKB_ASSERT_METHOD(rootMainView, @"[setRootMainView] -> rootMainView not be nil");
    [self animationBlock:^(BOOL isFinished) {
        if (_conViewArray.count > 0) {
            ZKBView *curMainView = [_conViewArray lastObject];
            //新视图将要显示
            if([curMainView respondsToSelector:@selector(ZKBMainViewWillHide)])
            {
                [curMainView ZKBMainViewWillHide];
            }
            
            [curMainView removeFromSuperview];
            
            //新视图显示完成
            if([curMainView respondsToSelector:@selector(ZKBMainViewDidHide)])
            {
                [curMainView ZKBMainViewDidHide];
            }
            [_conViewArray removeAllObjects];
        }
        ZKBView *newMainView = rootMainView;
        newMainView.mainViewController = self;
        newMainView.isBelowTabBar = isBelowTabBar;
        
        //重设View的frame
        [self updateView:newMainView isBelowTabBar:isBelowTabBar];
        
        //新视图将要显示
        if([newMainView respondsToSelector:@selector(ZKBMainViewWillShow)])
        {
            [newMainView ZKBMainViewWillShow];
        }
        
        [self.view addSubview:newMainView];
        
        [ZKBViewController pushView:newMainView pushModel:model animantion:animation callBack:^(BOOL isFinished) {
            //新视图显示完成
            if([newMainView respondsToSelector:@selector(ZKBMainViewDidShow)])
            {
                [newMainView ZKBMainViewDidShow];
            }
        }];
        
        [_conViewArray addObject:newMainView];
        
    }];

}

- (ZKBView *)getRootMainView
{
    return [_conViewArray firstObject];
}

#pragma mark - < Push > -


- (void)pushMainView:(ZKBView *)mainView
{
    [self pushMainView:mainView animation:NO isBelowTabBar:NO pushModel:ZKBAnimationPushModelDefault];
}
- (void)pushMainView:(ZKBView *)mainView animation:(BOOL)animation
{
    [self pushMainView:mainView animation:animation isBelowTabBar:NO pushModel:ZKBAnimationPushModelDefault];
}
- (void)pushMainView:(ZKBView *)mainView isBelowTabBar:(BOOL)isBelowTabBar
{
    [self pushMainView:mainView animation:NO isBelowTabBar:isBelowTabBar pushModel:ZKBAnimationPushModelDefault];
}
- (void)pushMainView:(ZKBView *)mainView animation:(BOOL)animation isBelowTabBar:(BOOL)isBelowTabBar
{
    [self pushMainView:mainView animation:animation isBelowTabBar:isBelowTabBar pushModel:ZKBAnimationPushModelDefault];
}
- (void)pushMainView:(ZKBView *)mainView animation:(BOOL)animation isBelowTabBar:(BOOL)isBelowTabBar pushModel:(ZKBAnimationPushModel)model
{
    DLog(@"Push");
    
    ZKB_ASSERT_METHOD(mainView, @"[pushMainView] -> mainView not be nil");
    ZKB_ASSERT_METHOD(_conViewArray.count > 0, @"未设置根视图!");
    
    [self animationBlock:^(BOOL isFinished) {
        ZKBView *curMainView = [_conViewArray lastObject];

        ZKBView *newMainView = mainView;
        newMainView.isBelowTabBar = isBelowTabBar;
        newMainView.mainViewController = self;
        //重设View的frame
        [self updateView:newMainView isBelowTabBar:isBelowTabBar];
        
        //新视图将要push
        if([newMainView respondsToSelector:@selector(ZKBMainViewWillShow)])
        {
            [newMainView ZKBMainViewWillShow];
        }
        
        [self.view addSubview:newMainView];
        
        [ZKBViewController pushView:newMainView pushModel:model animantion:animation callBack:^(BOOL isFinished) {
            //新视图push完成
            if([newMainView respondsToSelector:@selector(ZKBMainViewDidShow)])
            {
                [newMainView ZKBMainViewDidShow];
            }
            
            //当前视图将要隐藏
            if([curMainView respondsToSelector:@selector(ZKBMainViewWillHide)])
            {
                [curMainView ZKBMainViewWillHide];
            }
            
            [curMainView removeFromSuperview];
            
            //当前视图隐藏完成
            if([curMainView respondsToSelector:@selector(ZKBMainViewDidHide)])
            {
                [curMainView ZKBMainViewDidHide];
            }
    
        }];
        [_conViewArray addObject:newMainView];
    }];
}

#pragma mark - < Pop > -


- (void)popMainViewWithAnimated:(BOOL)animated
{
    return [self popMainViewWithAnimated:animated popModel:ZKBAnimationPopModelDefault];
}
- (void)popMainViewWithAnimated:(BOOL)animated popModel:(ZKBAnimationPopModel)model
{
    DLog(@"PopMainView");

    //根视图不执行
    if(_conViewArray.count <= 1)
    {
        DLog(@"根视图不允许 pop");
        return ;
    }
    
    [self animationBlock:^(BOOL isFinished) {
       
        ZKBView *curMainView = [_conViewArray lastObject];
        [_conViewArray removeLastObject];
        
        ZKBView *newMainView = [_conViewArray lastObject];
        newMainView.mainViewController = self; //更改上导航的代理
        //重设View的frame
        [self updateView:newMainView isBelowTabBar:newMainView.isBelowTabBar];
        
        //新视图将要显示
        if([newMainView respondsToSelector:@selector(ZKBMainViewWillShow)])
        {
            [newMainView ZKBMainViewWillShow];
        }
        [self.view insertSubview:newMainView belowSubview:curMainView];
        
        //新视图显示完成
        if([newMainView respondsToSelector:@selector(ZKBMainViewDidShow)])
        {
            [newMainView ZKBMainViewDidShow];
        }
        

        //当前视图将要Pop
        if([curMainView respondsToSelector:@selector(ZKBMainViewWillShow)])
        {
            [curMainView ZKBMainViewWillShow];
        }
        
        [ZKBViewController popView:curMainView popModel:model animation:animated callBack:^(BOOL isFinished) {
            [curMainView removeFromSuperview]; //动画完成之后Remove

            //当前视图Pop完成
            if([curMainView respondsToSelector:@selector(ZKBMainViewDidShow)])
            {
                [curMainView ZKBMainViewDidShow];
            }
        }];
    }];
}


- (void)popToMainView:(ZKBView *)mainView
{
    [self popToMainView:mainView animated:NO popModel:ZKBAnimationPopModelDefault];
}

- (void)popToMainView:(ZKBView *)mainView animated:(BOOL)animated
{
    [self popToMainView:mainView animated:animated popModel:ZKBAnimationPopModelDefault];
}
- (void)popToMainView:(ZKBView *)mainView animated:(BOOL)animated popModel:(ZKBAnimationPopModel)model
{
    ZKB_ASSERT_METHOD(mainView, @"[popToMainView] -> mainView not be nil");

    //根视图不执行
    if(_conViewArray.count <= 1)
    {
        DLog(@"根视图不允许 pop");
        return ;
    }
    
    if ([mainView isEqual:[_conViewArray lastObject]]) {
        DLog(@"不允许 pop 到 顶视图");
        return ;
    }
    
    int mainViewIndex = -1;
    mainViewIndex = [_conViewArray indexOfObject:mainView];
    
    if ( 0 > mainViewIndex || mainViewIndex >= _conViewArray.count) {
        DLog(@"pop顶视图 不在栈中");
        return;
    }
    
    NSMutableArray *popArray = [NSMutableArray new];
    if (mainViewIndex == 0) {
        [popArray addObject:_conViewArray.firstObject];
    }else{
       [popArray addObjectsFromArray:[_conViewArray subarrayWithRange:NSMakeRange(0, mainViewIndex)]];
    }
    [popArray addObject:_conViewArray.lastObject];
    _conViewArray = popArray;
    [self popMainViewWithAnimated:animated popModel:model];
}

- (void)popToRootMainViewAnimated:(BOOL)animated
{
    [self popToRootMainViewAnimated:animated popModel:ZKBAnimationPopModelDefault];
}

- (void)popToRootMainViewAnimated:(BOOL)animated popModel:(ZKBAnimationPopModel)model
{
    //根视图不执行
    if(_conViewArray.count <= 1)
    {
        DLog(@"根视图不允许 pop");
        return ;
    }
    NSMutableArray *popArray = [NSMutableArray arrayWithObjects:[_conViewArray firstObject],[_conViewArray lastObject], nil];
    _conViewArray = popArray;
    [self popMainViewWithAnimated:animated popModel:model];
}


#pragma mark - < 工具方法 > -

- (void)animationBlock:(ZKBCallBack)blcok
{
    self.view.userInteractionEnabled = NO;
    if (blcok) {
        blcok(YES);
    }
    self.view.userInteractionEnabled = YES;
}



//适配各个版本的屏幕
- (void)updateView:(ZKBView *)rootView isBelowTabBar:(BOOL)isBelowTabBar
{
    CGRect bounds = self.view.bounds;
    if (!isBelowTabBar) {
        if (!_tTabBar.hidden) {
            bounds.size.height -= ZKB_TAB_BAR_HEIGHT;
        }
    }
//    
//    
//    CGRect viewRect = bounds;
//    if (ZKB_IOS_VERSION_OR_ABOVE(ZKB_IOS_VERSION_8)) {
//        viewRect.origin.y = ZKB_STATUS_BAR_HEIGHT;
//        viewRect.size.height -= ZKB_STATUS_BAR_HEIGHT;
//        
//    }else if (ZKB_IOS_VERSION_OR_ABOVE(ZKB_IOS_VERSION_7)) {
//        viewRect.origin.y = ZKB_STATUS_BAR_HEIGHT;
//        viewRect.size.height -= ZKB_STATUS_BAR_HEIGHT;
//    }
//    
    rootView.frame = bounds;
}

- (void)updateTabBar:(ZKBTabBar *)tabBar  hidden:(BOOL)hidden
{
    CGFloat tabBarH = 0;
    if (!hidden) {
        tabBarH = ZKB_TAB_BAR_HEIGHT;
    }
    tabBar.frame = CGRectMake(tabBar.x, [self.view getHeight_] - ZKB_TAB_BAR_HEIGHT, [self.view getWidth_], tabBarH);
}


- (void)setTabBarHidden:(BOOL)tabBarHidden
{
    if (_tTabBar.hidden != tabBarHidden) {
        _tTabBar.hidden = tabBarHidden;
        [self updateTabBar:_tTabBar hidden:tabBarHidden];
        [self viewWillLayoutSubviews];
    }
}

- (BOOL)tabBarHidden
{
    return _tTabBar.hidden;
}

- (void)setTabBarItems:(NSArray *)tabBarItems
{
    [_tTabBar setItems:tabBarItems];
}

- (NSArray *)tabBarItems
{
    return _tTabBar.items;
}

#pragma mark - < ZKBTabBarDelegate > -

- (void)tabBar:(ZKBTabBar *)tabBar didSelectItem:(ZKBTabBarItem *)item selectIndex:(NSInteger)index
{
    if ([_tabBarViews count] > 0 && 0<= index && index < _tabBarViews.count) {
        ZKBView * newView = [_tabBarViews objectAtIndex:index];
        ZKBView * curView = [_conViewArray firstObject];
        if (![newView isEqual:curView]) {
            [self setRootMainView:newView];
        }
    }
}

- (BOOL)tabBar:(ZKBTabBar *)tabBar shouldSelectItem:(ZKBTabBarItem *)item selectIndex:(NSInteger)index
{
    return YES;
}

#pragma mark - < ZKBNavigationBarDelegate > -
/**
 *  按钮被点击
 *
 *  @param leftBtn 左按钮
 */
- (void)ZKBNavigationBar:(ZKBNavigationBar *)navigationBar didClickLeftButton:(ZKBNavigationItem *)leftBtn
{
    if ([self.delegate respondsToSelector:@selector(ZKBNavigationBarDidClickLeftButton:clickedItem:)]) {
        [self.delegate ZKBNavigationBarDidClickLeftButton:YES clickedItem:leftBtn];
    }else{
        [self popMainViewWithAnimated:YES];
    }
}

/**
 *  按钮被点击
 *
 *  @param rightBtn 右按钮
 */
- (void)ZKBNavigationBar:(ZKBNavigationBar *)navigationBar  didClickRightButton:(ZKBNavigationItem *)rightBtn
{
    if ([self.delegate respondsToSelector:@selector(ZKBNavigationBarDidClickLeftButton:clickedItem:)]) {
        [self.delegate ZKBNavigationBarDidClickLeftButton:NO clickedItem:rightBtn];
    }
}

#pragma mark - < 旋屏支持 > -

//IOS 6.0 以上旋屏支持

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

//IOS 6.0 以下旋屏支持

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - < 旋屏分发事件 > -

//将要旋转
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}
//将要旋转
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}
//旋转完成
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
}

#pragma mark - < 内存溢出警告 >  -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
