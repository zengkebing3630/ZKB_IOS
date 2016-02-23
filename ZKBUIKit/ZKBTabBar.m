//
//  ZKBTabBar.m
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBTabBar.h"
#import "ZKBTabBarItem.h"
#import "ZKBLineView.h"


@interface ZKBTabBar()
{
    ZKBLineView         * _lineView;
    NSMutableArray      * _barItems;
}
@property (nonatomic) UIImageView *backgroundView;
@end

@implementation ZKBTabBar
@dynamic items;

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _barItems = [NSMutableArray new];
    
    _backgroundView = [[UIImageView alloc] init];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backgroundView];
    
    _lineView = ({
        ZKBLineView *lineView = [[ZKBLineView alloc] init];
        lineView;
    });
    [self addSubview:_lineView];
}


- (void)layoutSubviews
{
    self.backgroundView.frame = self.bounds;
    [_lineView setMarginTop:0
                       left:0
                     bottom:[self getHeight_] - ZKB_LINE_HEIGHT
                      right:0];
    CGFloat itemWidth = ceilf([self getWidth_] / _barItems.count);
    
    NSInteger index = 0;
    for (ZKBTabBarItem *item in [self items]) {
        CGFloat itemHeight = [item itemHeight];
        CGFloat itemY = ceilf(([self getHeight_] - itemHeight)/ 2);;
        if (!itemHeight) {
            itemHeight = self.height;
        }
        [item setFrame:CGRectMake(itemWidth * index,
                                  itemY,
                                  itemWidth,
                                  itemHeight)];
        index++;
    }
}


- (void)setSelectedItem:(ZKBTabBarItem *)selectedItem
{
    if (!selectedItem) {
        return;
    }
    if (![selectedItem isEqual:_selectedItem]) {
        
        for (ZKBTabBarItem * item in _barItems) {
            item.selected = NO;
        }
        
        _selectedItem = selectedItem;
        _selectedItem.selected = YES;
    }
}

- (NSArray *)items
{
    return _barItems;
}

- (void)setItems:(NSArray *)items
{
    if (_barItems.count > 0) {
        for (ZKBTabBarItem * item in _barItems) {
            [item removeFromSuperview];
        }
        [_barItems removeAllObjects];
    }
    
    if (items.count > 0) {
        for (int i = 0; i < items.count; i++) {
            ZKBTabBarItem * item = [items objectAtIndex:i];
            item.tag = i;
            [self addSubview:item];
            [item addTarget:self
                     action:@selector(tabBarItemDidClick:)
           forControlEvents:UIControlEventTouchUpInside];
            [_barItems addObject:item];
        }
    }
    
    [self setSelectedItem:[_barItems firstObject]];
    [self setNeedsLayout];
}

- (ZKBTabBarItem *)tabBarItemWithFrame:(CGRect)frame
{
    ZKBTabBarItem * item = [[ZKBTabBarItem alloc] init];
    [item addTarget:self
             action:@selector(tabBarItemDidClick:)
   forControlEvents:UIControlEventTouchUpInside];
    return item;
}

- (void)tabBarItemDidClick:(ZKBTabBarItem *)item
{
    if ([[self delegate] respondsToSelector:@selector(tabBar:shouldSelectItem:selectIndex:)]) {
        if (![[self delegate] tabBar:self shouldSelectItem:item selectIndex:item.tag]) {
            return;
        }
    }
    
    [self setSelectedItem:item];
    
    if ([[self delegate] respondsToSelector:@selector(tabBar:didSelectItem:selectIndex:)]) {
        [[self delegate] tabBar:self didSelectItem:item selectIndex:item.tag];
    }
}

@end


