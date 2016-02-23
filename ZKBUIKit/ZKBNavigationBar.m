//
//  ZKBNavigationBar.m
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBNavigationBar.h"
#import "ZKBNavigationItem.h"
#import "ZKBLineView.h"
#import "ZKBTools.h"

#define ZKB_NAVIGATION_BAR_LEFT_BTN_TAG  1000
#define ZKB_NAVIGATION_BAR_RIGHT_BTN_TAG 2000

#define ZKB_NAVIGATION_BAR_BTN_WIDTH    60.0

@interface ZKBNavigationBar ()
{
    ZKBNavigationItem   * _leftItem;
    ZKBNavigationItem   * _rightItem;
    UILabel             * _titleLabel;
    ZKBLineView         * _lineView;
    BOOL                _rotatingAnimation; //是否旋屏动画中
    UIImageView         *_bgImageView;
}
@end

@implementation ZKBNavigationBar
@dynamic bgImg,title;

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _rotatingAnimation = NO;
        _bgImageView = ({
            UIImageView * aImgView = [[UIImageView alloc] init];
            aImgView;
        });
        [self addSubview:_bgImageView];
        
#ifdef DEBUG
        self.backgroundColor = [UIColor darkTextColor];
#endif

        _titleLabel = ({
            UILabel *label = [UILabel new];
            label.backgroundColor = [UIColor clearColor];
            label.clipsToBounds = YES;
            label.textAlignment = NSTextAlignmentCenter;
            FontStyle30_ffffff_10(label.font, label.textColor);
            label;
        });
        [self addSubview:_titleLabel];
        

        _lineView = ({
            ZKBLineView *lineView = [[ZKBLineView alloc] init];
            lineView;
        });
        [self addSubview:_lineView];
        
    }
    return self;
}


- (void)layoutSubviews
{
    
    if(_leftItem)
    {
        
        [_leftItem setMarginTop:ZKB_NAVIGATION_BAR_HEIGHT - ZKB_NAVIGATION_BAR_HEIGHT_44
                           left:0
                         bottom:0
                          right:[self getWidth_] - ZKB_NAVIGATION_BAR_BTN_WIDTH];
    }
    if(_rightItem)
    {
        [_rightItem setMarginTop:ZKB_NAVIGATION_BAR_HEIGHT - ZKB_NAVIGATION_BAR_HEIGHT_44
                            left:[self getWidth_] - ZKB_NAVIGATION_BAR_BTN_WIDTH
                          bottom:0
                           right:0];
    }
    _bgImageView.frame = self.bounds;
    [_titleLabel setMarginTop:ZKB_NAVIGATION_BAR_HEIGHT - ZKB_NAVIGATION_BAR_HEIGHT_44 left:ZKB_NAVIGATION_BAR_BTN_WIDTH
                       bottom:0.f right:ZKB_NAVIGATION_BAR_BTN_WIDTH];
    _lineView.frame = (CGRect){0, [self getHeight_ ] - ZKB_LINE_HEIGHT, [self getWidth_], ZKB_LINE_HEIGHT};
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}
- (NSString *)title
{
    return  _titleLabel.text;
}

- (void)setBgImg:(UIImage *)bgImg
{
    _bgImageView.image = bgImg;
}

- (UIImage *)bgImg
{
    return  _bgImageView.image;
}

- (void)setLeftItemType:(ZKBNavigationItemType)leftItemType
{
    ZKBNavigationItem *item = [self navigationItemWithFrame:CGRectZero
                                                       type:leftItemType];
    [self addSubview:item];
    
    if(item)
    {
        if(_leftItem)
        {
            [_leftItem removeFromSuperview];
        }
        _leftItem = item;
        _leftItem.tag = ZKB_NAVIGATION_BAR_LEFT_BTN_TAG;
        _leftItemType = leftItemType;
    }else{
        if(_leftItem)
        {
            [_leftItem removeFromSuperview];
        }
        _leftItem = nil;
    }

}

- (void)setRightItemType:(ZKBNavigationItemType)rightItemType
{
    ZKBNavigationItem *item = [self navigationItemWithFrame:CGRectZero
                                                       type:rightItemType];
    [self addSubview:item];
    
    if(item)
    {
        if(_rightItem)
        {
            [_rightItem removeFromSuperview];
        }
        _rightItem = item;
        _rightItem.tag = ZKB_NAVIGATION_BAR_RIGHT_BTN_TAG;
        _rightItemType = rightItemType;
    }else{
        if(_rightItem)
        {
            [_rightItem removeFromSuperview];
        }
        _rightItem = nil;
    }
}


- (ZKBNavigationItem *)navigationItemWithFrame:(CGRect)frame
                         type:(ZKBNavigationItemType)type
{
    ZKBNavigationItem * item = nil;
    switch (type) {
        case ZKBNavigationItemTypeNone:{
            break;
        }
        case ZKBNavigationItemTypeBack:{
            item = [[ZKBNavigationItem alloc] initWithFrame:frame];
            break;
        }
    }
    
    if(item)
    {
        
        [item addTarget:self
                   action:@selector(navigationItemClick:)
         forControlEvents:UIControlEventTouchUpInside];
    }
    
    return item;
}


/**
 *  按钮点击
 */
- (void)navigationItemClick:(ZKBNavigationItem *)item
{
    if (ZKB_NAVIGATION_BAR_RIGHT_BTN_TAG == item.tag) {
        
        if ([self.delegate respondsToSelector:@selector(ZKBNavigationBar:didClickRightButton:)]) {
            [self.delegate ZKBNavigationBar:self didClickRightButton:item];
        }
        
    }else if (ZKB_NAVIGATION_BAR_LEFT_BTN_TAG == item.tag){
    
        if ([self.delegate respondsToSelector:@selector(ZKBNavigationBar:didClickLeftButton:)]) {
            [self.delegate ZKBNavigationBar:self didClickLeftButton:item];
        }else{
            //默认返回pop
        }
        
    }
}


//旋转

@end
