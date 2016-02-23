//
//  ZKBTabBar.h
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKBDefine.h"
@class ZKBTabBarItem;
@protocol ZKBTabBarDelegate;

@interface ZKBTabBar : UIView
@property (nonatomic,assign         ) id<ZKBTabBarDelegate> delegate;
@property (nonatomic,strong         ) NSArray           *items;
@property (nonatomic,assign         ) ZKBTabBarItem     *selectedItem;
@property (nonatomic,strong,readonly) UIImageView       *backgroundView;
@end


@protocol ZKBTabBarDelegate <NSObject>
@required
- (void)tabBar:(ZKBTabBar *)tabBar didSelectItem:(ZKBTabBarItem *)item selectIndex:(NSInteger)index;
@optional
- (BOOL)tabBar:(ZKBTabBar *)tabBar shouldSelectItem:(ZKBTabBarItem *)item selectIndex:(NSInteger)index;
@end
