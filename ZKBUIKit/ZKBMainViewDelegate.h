//
//  ZKBMainViewDelegate.h
//  UITest
//
//  Created by zkb on 15/2/7.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZKBMainViewDelegate <NSObject>
@optional
/**
 *  将要显示
 */
- (void)ZKBMainViewWillShow;

/**
 *  显示完成
 */
- (void)ZKBMainViewDidShow;

/**
 *  将要隐藏
 */
- (void)ZKBMainViewWillHide;

/**
 *  隐藏完成
 */
- (void)ZKBMainViewDidHide;


- (void)ZKBNavigationBarDidClickLeftButton:(BOOL)isLeft  clickedItem:(id)item;

@end
