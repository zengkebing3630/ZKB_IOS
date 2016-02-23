//
//  ZKBTabBarItem.m
//  UITest
//
//  Created by keven on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBTabBarItem.h"
#import "ZKBDefine.h"

@interface ZKBTabBarItem()
{
    UIImageView * _badgeValueImageView;
}
@end

@implementation ZKBTabBarItem
@dynamic badgeValueImg,badgeValueHidden,itemHeight;
- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _badgeValueImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self insertSubview:_badgeValueImageView aboveSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat topSpaceing = ceilf(([self getHeight_] - self.imageView.image.size.height) / 2);
    CGFloat leftSpaceing = ceilf(([self getWidth_] - self.imageView.image.size.width) / 2);

    [self.imageView setFrame:leftSpaceing
                           y:topSpaceing
                           w:self.imageView.image.size.height
                           h:self.imageView.image.size.width];
    
    
    [_badgeValueImageView setFrame:self.imageView.center.x + ZKB_DISTANCE_10
                                 y:self.imageView.center.y - ZKB_DISTANCE_10
                                 w:_badgeValueImageView.image.size.width
                                 h:_badgeValueImageView.image.size.height];
    
}

#pragma mark - <重载> -

- (void)setBadgeValueHidden:(BOOL )badgeValueHidden
{
    _badgeValueImageView.hidden = badgeValueHidden;
}

- (BOOL)badgeValueHidden
{
    return _badgeValueImageView.hidden;
}

- (void)setBadgeValueImg:(UIImage *)badgeValueImg
{
    _badgeValueImageView.image = badgeValueImg;
}

- (UIImage *)badgeValueImg
{
    return _badgeValueImageView.image;
}

- (void)setItemHeight:(CGFloat)itemHeight
{
    self.height = itemHeight;
    [self setNeedsLayout];
}
- (CGFloat)itemHeight
{
    return self.height;
}
@end
