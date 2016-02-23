//
//  ZKBNavigationBar.h
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKBDefine.h"

@class ZKBNavigationItem;
@protocol ZKBNavigationBarDelegate;

@interface ZKBNavigationBar : UIView

@property (nonatomic, assign)id<ZKBNavigationBarDelegate> delegate;
@property (nonatomic, assign)ZKBNavigationItemType leftItemType;
@property (nonatomic, assign)ZKBNavigationItemType rightItemType;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)UIImage * bgImg;
@end



#pragma mark - < ZKBNavigationBarDelegate > -

@protocol ZKBNavigationBarDelegate <NSObject>
@optional
/**
 *  按钮被点击
 *
 *  @param leftBtn 左按钮
 */
- (void)ZKBNavigationBar:(ZKBNavigationBar *)navigationBar didClickLeftButton:(ZKBNavigationItem *)leftBtn;

/**
 *  按钮被点击
 *
 *  @param rightBtn 右按钮
 */
- (void)ZKBNavigationBar:(ZKBNavigationBar *)navigationBar  didClickRightButton:(ZKBNavigationItem *)rightBtn;
@end
