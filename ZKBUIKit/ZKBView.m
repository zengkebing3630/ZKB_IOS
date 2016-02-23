//
//  ZKBView.m
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBView.h"
#import "ZKBNavigationBar.h"

@interface ZKBView ()
{
    ZKBNavigationBar * _navigationBar;
    CGFloat _navigationBarHeight;
}
@end

@implementation ZKBView
@dynamic navTitle,navBgImg,navLeftItemType,navRighItemType,navDelegate,navigationBarHidden;
- (id)init
{
    self = [super init];
    if (self) {
        [self commonInitData];
        [self commonInit];
    }
    return self;}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitData];
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitData];
        [self commonInit];
    }
    return self;
}

- (void)commonInitData
{
    _navigationBarHeight = ZKB_NAVIGATION_BAR_HEIGHT;
}

- (void)commonInit
{
    _navigationBar = ({
        ZKBNavigationBar *aBar = [[ZKBNavigationBar alloc] initWithFrame:CGRectMake(ZKB_DISTANCE_0, ZKB_DISTANCE_0,
                                                                                    [self getWidth_], _navigationBarHeight)];
        aBar.clipsToBounds = YES;
        aBar;
    });
    [self addSubview:_navigationBar];
    
    _mainView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(ZKB_DISTANCE_0, _navigationBar.botm,
                                                                [self getWidth_], [self getHeight_] - _navigationBar.botm)];
        view.clipsToBounds = YES;
        view;
    });
    [self addSubview:_mainView];

}

- (void)layoutSubviews
{
    _navigationBar.frame = CGRectMake(ZKB_DISTANCE_0, ZKB_DISTANCE_0,
                                      [self getWidth_], _navigationBarHeight);
    _mainView.frame = CGRectMake(ZKB_DISTANCE_0, _navigationBar.botm,
                                 [self getWidth_], [self getHeight_] - _navigationBar.botm);
}


#pragma mark - < get || set > -


- (void)setMainViewController:(ZKBViewController *)mainViewController
{
    _mainViewController = mainViewController;
    if (_mainViewController) {
        _mainViewController.tNavigationBar =  _navigationBar;
        _mainViewController.tNavigationBar.delegate = _mainViewController;
        _mainViewController.delegate = self;
    }
}

- (void)setNavTitle:(NSString *)navTitle
{
    _navigationBar.title = navTitle;
}

- (NSString *)navTitle
{
    return _navigationBar.title;
}

- (void)setNavBgImg:(UIImage *)navBgImg
{
    _navigationBar.bgImg = navBgImg;
}

- (UIImage *)navBgImg
{
    return _navigationBar.bgImg;
}


- (void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    _navigationBar.hidden = navigationBarHidden;
    if (navigationBarHidden) {
        _navigationBarHeight = 0;
    }else{
        _navigationBarHeight = ZKB_NAVIGATION_BAR_HEIGHT;
    }
    [self setNeedsLayout];
}

- (BOOL)navigationBarHidden
{
    return _navigationBar.hidden;
}

- (void)setNavLeftItemType:(ZKBNavigationItemType)navLeftItemType
{
    _navigationBar.leftItemType = navLeftItemType;
}

- (ZKBNavigationItemType)navLeftItemType
{
    return _navigationBar.leftItemType;
}

- (void)setNavRighItemType:(ZKBNavigationItemType)navRighItemType
{
    _navigationBar.rightItemType = navRighItemType;
}

- (ZKBNavigationItemType)navRighItemType
{
    return _navigationBar.rightItemType;
}

- (void)setNavDelegate:(id<ZKBNavigationBarDelegate>)navDelegate
{
    _navigationBar.delegate = navDelegate;
    if (_mainViewController && _mainViewController.tNavigationBar) {
        _mainViewController.tNavigationBar.delegate = _mainViewController;
        _mainViewController.delegate = self;
    }
}

- (id<ZKBNavigationBarDelegate>)navDelegate
{
    return _navigationBar.delegate;
}

#pragma mark - < 重写 > -

/**
 *  自动收起键盘
 *
 *  @param point 点击事件的位置
 *  @param event 点击事件
 *
 *  @return 处理点击事件的视图
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView * result = [super hitTest:point withEvent:event];
    if (![result isKindOfClass:[UITextField class]] && //自动收起键盘，排除UITextField，UITextView，UISearchBar
        ![result isKindOfClass:[UITextView class]] &&
        ![result isKindOfClass:[UISearchBar class]]) {
        [self endEditing:YES];
    }
    return result;
}
@end
