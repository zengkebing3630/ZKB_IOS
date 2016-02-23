//
//  ZKBTabBarItem.h
//  UITest
//
//  Created by keven on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBButton.h"

@interface ZKBTabBarItem : ZKBButton
@property (nonatomic,assign)CGFloat itemHeight;
@property (nonatomic,assign)BOOL badgeValueHidden;
@property (nonatomic,strong)UIImage *badgeValueImg;

@end
