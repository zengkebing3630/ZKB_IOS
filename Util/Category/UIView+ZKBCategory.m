//
//  UIView+TCategory.m
//  Function
//
//  Created by keven/KevenTsang/曾克兵(简称：T) on 14-11-21.
//  Copyright (c) 2014年 无线网络科技有限公司. All rights reserved.
//


#import "UIView+ZKBCategory.h"

@implementation UIView (ZKBCategory)

- (void)setX_:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)getX_
{
    return self.frame.origin.x;
}

- (void)setY_:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)getY_
{
    return self.frame.origin.y;
}

- (void)setWidth_:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)getWidth_
{
    return self.frame.size.width;
}

- (void)setHeight_:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)getHeight_
{
    return self.frame.size.height;
}

- (void)setSize_:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGSize)getSize_
{
    return self.frame.size;
}

- (void)setOrigin_:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)getOrigin_
{
    return self.frame.origin;
}

- (void)setTop_:(CGFloat)top
{
    self.y = top;
}

- (CGFloat)getTop_
{
    return self.y;
}

- (void)setLeft_:(CGFloat)left
{
    self.x = left;
}

- (CGFloat)getLeft_
{
    return self.x;
}

- (void)setBotm_:(CGFloat)botm
{
    self.y += botm - self.botm;
}

- (CGFloat)getBotm_
{
    return self.y + self.height;
}

- (void)setRight_:(CGFloat)right
{
    self.x += right - self.width;
}

- (CGFloat)getRight_
{
    return self.x + self.width;
}

- (void)setCenterX_:(CGFloat)centerX
{
    [self setCenter:(CGPoint){centerX, self.center.y}];
}

- (CGFloat)getCenterX_
{
    return self.center.x;
}

- (void)setCenterY_:(CGFloat)centerY
{
    [self setCenter:(CGPoint){self.center.x, centerY}];
}

- (CGFloat)getCenterY_
{
    return self.center.y;
}

- (void)setFrame:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    [self setFrame:CGRectMake(x, y, w, h)];
}

- (void)setXY:(CGFloat)x Y:(CGFloat)y
{
    CGPoint point;
    point.x = x;
    point.y = y;
    
    self.origin = point;
}

- (void)setSizew:(CGFloat)w h:(CGFloat)h
{
    CGSize size;
    size.width = w;
    size.height = h;
    
    self.size = size;
}

- (CGRect)getFrameApplyAffineTransform_
{
    return CGRectApplyAffineTransform(self.frame, self.transform);
}

- (CGRect)getBoundsApplyAffineTransform_
{
    return CGRectApplyAffineTransform(self.bounds, self.transform);
}

//<----------------快速坐标 End---------------->

//<----------------快速排版---------------->

//添加子视图@[]
- (void)addSubviewAry:(NSArray *)objects
{
    for(UIView *vi in objects)
        [self addSubview:vi];
}

//置父视图顶部
- (void)setSuperViewTop
{
    self.y = 0;
}

//置父视图左边
- (void)setSuperViewLeft
{
    self.x = 0;
}

//置父视图底部
- (void)setSuperViewBotm
{
    NSAssert(self.superview, @"not superView!");
    self.y = self.superview.height - self.height;
}

//置父视图右边
- (void)setSuperViewRight
{
    NSAssert(self.superview, @"not superView!");
    self.x = self.superview.width - self.width;
}

//置View到指定View的顶部，并且设置间距
- (void)setTopFromView:(UIView*)vi dis:(CGFloat)dis
{
    self.y = vi.y - dis - self.height;
}

//置View到指定View左边，并且设置间距
- (void)setLeftFromView:(UIView*)vi dis:(CGFloat)dis
{
    self.x = vi.x - dis - self.width;
}

//置View到指定View底部，并且设置间距
- (void)setBotmFromView:(UIView*)vi dis:(CGFloat)dis
{
    self.y = vi.botm + dis;
}

//置View到指定View右边，并且设置间距
- (void)setRightFromView:(UIView*)vi dis:(CGFloat)dis
{
    self.x = vi.right + dis;
}

//使用Margin设置坐标-相对父视图
- (void)setMarginTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right
{
    NSAssert(self.superview, @"没有父视图!");
    CGRect frame;
    frame.origin.y = top;
    frame.origin.x = left;
    frame.size.height = self.superview.height - frame.origin.y - bottom;
    frame.size.width = self.superview.width - frame.origin.x - right;
    self.frame = frame;
}

//设置UIViewAutoresizingFlexibleLeftMargin
- (void)setLeftMargin
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleLeftMargin;
}

//设置UIViewAutoresizingFlexibleRightMargin
- (void)setRightMargin
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleRightMargin;
}

//设置UIViewAutoresizingFlexibleTopMargin
- (void)setTopMargin
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleTopMargin;
}

//设置UIViewAutoresizingFlexibleWidth
- (void)setWidthMargin
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleWidth;
}

//设置UIViewAutoresizingFlexibleHeight
- (void)setHeightMargin
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleHeight;
}

//设置UIViewAutoresizingFlexibleBottomMargin
- (void)setBottomMargin
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleBottomMargin;
}

//设置AllMargin
- (void)setAllMargin
{
    [self setLeftMargin];
    [self setRightMargin];
    [self setTopMargin];
    [self setHeightMargin];
    [self setBottomMargin];
}

//输出View的Frame
- (void)ptrFrame
{
    NSLog(@"[%@]", NSStringFromCGRect(self.frame));
}

//<----------------快速排版 End---------------->

//<----------------杂项---------------->

//使用空白背景颜色
- (void)setBgrClearColor
{
    self.backgroundColor = [UIColor clearColor];
}

//<----------------杂项 End---------------->


#pragma mark - < 分割 > -

/**
 *  打印视图层次
 *
 *  @param aView     视图
 *  @param indent    层次等级,0 为最高级
 *  @param outstring 打印字符串
 */
+ (void)TprintViewLevel:(UIView *)aView
               atIndent:(int)indent
                 output:(NSMutableString *)outstring
{
    @autoreleasepool {
        for (int i = 0; i < indent; i++) {
            [outstring appendString:@"--"];
        }
        [outstring appendFormat:@"[%2d] %@\n", indent, [[aView class] description]];
        for (UIView *view in [aView subviews]) {
            [UIView TprintViewLevel:view atIndent:indent + 1 output:outstring];
        }
    }
}

/**
 *  打印视图层次
 */
- (void)TprintViewLevel
{
    @autoreleasepool {
        NSMutableString * outstring = [NSMutableString stringWithString:@"\n-- BEGIN --\n"];
        [UIView TprintViewLevel:self atIndent:0 output:outstring];
        [outstring appendString:@"\n-- END --\n"];
        NSLog(@"ViewLevel:%@",outstring);
    }
}

/**
 *  添加阴影
 *
 *  @param shadowColor 阴影颜色
 *  @param offset      阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
 *  @param opacity     阴影透明度，默认0
 *  @param radius      阴影半径，默认3
 */
- (void)addShadow:(UIColor *)shadowColor
           offset:(CGSize)offset
          opacity:(CGFloat)opacity
           radius:(CGFloat)radius
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1,1);
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 1;
}



@end
