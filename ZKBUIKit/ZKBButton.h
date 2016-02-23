//
//  TRButton.h
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  SDK通用button的父类
 */
@interface ZKBButton : UIControl

@property (nonatomic,strong) UIImageView *backgroudImageView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,assign) UIEdgeInsets contentInsets;
@property (nonatomic,assign) UIEdgeInsets imageEdgeInsets;
@property (nonatomic,assign) UIEdgeInsets titleEdgeInsets;
@property (nonatomic,assign) NSTimeInterval delayInterval; //点击延迟响应时间
@property (nonatomic,assign) NSTimeInterval highlightDelayInterval; //高亮延迟时间
//当前状态
@property (nonatomic, readonly, strong) NSString *currentTitle;
@property (nonatomic, readonly, strong) UIColor *currentTitleColor;
@property (nonatomic, readonly, strong) UIColor *currentTitleShadowColor;
@property (nonatomic, readonly, strong) UIImage *currentImage;
@property (nonatomic,assign) BOOL isSelectType; //是否选择类型按钮,设置了该属性的button事件监听需要监听UIControlEventValueChanged这个事件
@property (nonatomic,assign) BOOL isChangePresentWhenSetHightlighted; //是否在设置hightlight属性的时候改变button的样式,default is YES.



-(id)initWithFrame:(CGRect)frame;

-(NSString *)titleForState:(UIControlState)state;
-(void)setTitle:(NSString *)title forState:(UIControlState)state;

-(UIColor *)titleColorForState:(UIControlState)state;
-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state;

-(UIColor *)titleShadowColorForState:(UIControlState)state;
-(void)setTitleShadowColor:(UIColor *)color forState:(UIControlState)state;

-(UIImage *)imageForState:(UIControlState)state;
-(void)setImage:(UIImage *)image forState:(UIControlState)state;

-(UIColor *)backgroundColorForState:(UIControlState)state;
-(void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


-(void)updateContentForSelect:(BOOL)selected;

@end

/**
 *  对子类开放的方法
 */
@interface ZKBButton (private)

#pragma mark - 子类需要特殊响应事件处理的时候,重写一下方法实现
-(void)controlEventTouchDown:(UIControl *)sender event:(UIEvent *)event;
-(void)controlEventTouchDownRepeat:(UIControl *)sender event:(UIEvent *)event;
-(void)controlEventTouchDragInside:(UIControl *)sender event:(UIEvent *)event;
-(void)controlEventTouchDragOutside:(UIControl *)sender event:(UIEvent *)event;
-(void)controlEventTouchDragEnter:(UIControl *)sender event:(UIEvent *)event;
-(void)controlEventTouchDragExit:(UIControl *)sender event:(UIEvent *)event;
-(void)controlEventTouchUpInside:(UIControl *)sender event:(UIEvent *)event;
-(void)controlEventTouchOutside:(UIControl *)sender event:(UIEvent *)event;
-(void)controlEventTouchCancel:(UIControl *)sender event:(UIEvent *)event;
-(void)controlEventValueChange:(UIControl *)sender event:(UIEvent *)event;
-(void)controlEventAllTouchEvents:(UIControl *)sender event:(UIEvent *)event;
-(void)execAction:(NSNumber *)controlEventNum event:(UIEvent *)event;

@end
