//
//  TRButton.m
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//
#import "ZKBButton.h"
#import <UIKit/UIControl.h>
#import <objc/runtime.h>

@interface ZKBControlAction : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) UIControlEvents controlEvents;

@end

@implementation ZKBControlAction

- (BOOL)isEqual:(id)object
{
    if (object == self) {
        return YES;
    } else if ([object isKindOfClass:[[self class] class]]) {
        return ([object target] == self.target &&
                ((ZKBControlAction *)object).action == self.action &&
                ((ZKBControlAction *)object).controlEvents == self.controlEvents
                );
    } else {
        return NO;
    }
}

@end

@implementation ZKBButton{
    NSMutableDictionary *_imageDic;
    NSMutableDictionary *_titleColorDic;
    NSMutableDictionary *_titleShadowColorDic;
    NSMutableDictionary *_titleDic;
    NSMutableDictionary *_backgroundColorDic;
    NSMutableArray      *_registeredActions;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _isChangePresentWhenSetHightlighted = YES;
        _delayInterval = 0.1;
        _imageDic = [NSMutableDictionary dictionary];
        _titleColorDic = [NSMutableDictionary dictionary];
        _titleShadowColorDic = [NSMutableDictionary dictionary];
        _titleDic = [NSMutableDictionary dictionary];
        _backgroundColorDic = [NSMutableDictionary dictionary];
        _registeredActions = [NSMutableArray array];
        
        _backgroudImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_backgroudImageView];
        
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.userInteractionEnabled = NO;
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.userInteractionEnabled = NO;
        [self addSubview:_titleLabel];
        
        [self registerControlEvents];
    }
    return self;
}

-(UIColor *)defaultTitleColor{
    return [UIColor blackColor];
}

- (UIColor *)defaultTitleShadowColor
{
    return [UIColor clearColor];
}

- (NSString *)currentTitle
{
    return _titleLabel.text;
}

- (UIColor *)currentTitleColor
{
    return _titleLabel.textColor;
}

- (UIColor *)currentTitleShadowColor
{
    return _titleLabel.shadowColor;
}

- (UIImage *)currentImage
{
    return _imageView.image;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _backgroudImageView.frame = self.bounds;
    
    
    CGRect titleRect = {_contentInsets.left + _titleEdgeInsets.left,
    _contentInsets.top + _titleEdgeInsets.top,
    self.bounds.size.width - (_contentInsets.left + _titleEdgeInsets.left) - (_contentInsets.right + _titleEdgeInsets.right),
    self.bounds.size.height -(_contentInsets.top + _titleEdgeInsets.top) - (_contentInsets.bottom + _titleEdgeInsets.bottom)
    };
    CGRect imageRect = {_contentInsets.left + _imageEdgeInsets.left,
        _contentInsets.top + _imageEdgeInsets.top,
        self.bounds.size.width - (_contentInsets.left + _imageEdgeInsets.left) - (_contentInsets.right + _imageEdgeInsets.right),
        self.bounds.size.height -(_contentInsets.top + _imageEdgeInsets.top) - (_contentInsets.bottom + _imageEdgeInsets.bottom)
    };
    
    self.titleLabel.frame = titleRect;
    self.imageView.frame = imageRect;
}

-(void)updateTitleState{
    UIControlState state = self.state;
    _titleLabel.text = [self titleForState:state];
    _titleLabel.textColor = [self titleColorForState:state] ?: [self defaultTitleColor];
    _titleLabel.shadowColor = [self titleShadowColorForState:state] ?: [self defaultTitleShadowColor];
}

-(void)updateImageViewState{
    UIControlState state = self.state;
    UIImage *image = [self imageForStateOrNormalStateWhenNoExist:state];
    _imageView.image = image;
}

-(void)updateBackgroudColorState{
    UIControlState state = self.state;
    UIColor *backgroudColor = [self backgroundColorForState:state];
    _backgroudImageView.backgroundColor = backgroudColor;
}

-(void)updateAllContent{
    [self updateTitleState];
    [self updateImageViewState];
    [self updateBackgroudColorState];
}

-(void)updateContentForSelect:(BOOL)selected{
    if (selected) {
        UIImage *selectedImage = [self imageForState:UIControlStateSelected];
        if (selectedImage) {
            _imageView.image = selectedImage;
        }
        _titleLabel.textColor = [self titleColorForState:UIControlStateSelected];
        _titleLabel.shadowColor = [self titleShadowColorForState:UIControlStateSelected];
        _titleLabel.text = [self titleForState:UIControlStateSelected];
        _backgroudImageView.backgroundColor = [self backgroundColorForState:UIControlStateSelected];
    }else{
        UIImage *enableImage = [self imageForState:UIControlStateNormal];
        if (enableImage) {
            _imageView.image = enableImage;
        }
        _titleLabel.textColor = [self titleColorForState:UIControlStateNormal];
        _titleLabel.shadowColor = [self titleShadowColorForState:UIControlStateNormal];
        _titleLabel.text = [self titleForState:UIControlStateNormal];
        _backgroudImageView.backgroundColor = [self backgroundColorForState:UIControlStateNormal];
    }
}

-(NSString *)titleForState:(UIControlState)state{
    NSString *title = [_titleDic objectForKey:@(state)];
    if (state != UIControlStateNormal) {
        if (!title) {
            title = [_titleDic objectForKey:@(UIControlStateNormal)];
        }
    }
    return title;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    if (title) {
        [_titleDic setObject:title forKey:@(state)];
        if (state == self.state) {
            _titleLabel.text = title;
        }
    }
}


-(UIColor *)titleColorForState:(UIControlState)state{
    UIColor *color = [_titleColorDic objectForKey:@(state)];
    if (!color) {
        color = [_titleColorDic objectForKey:@(UIControlStateNormal)];
    }
    return color;
}

-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    if (color) {
        [_titleColorDic setObject:color forKey:@(state)];
        if (self.state == state) {
            _titleLabel.textColor = color;
        }
    }

}


-(UIColor *)titleShadowColorForState:(UIControlState)state{
    return [_titleShadowColorDic objectForKey:@(state)];
}

-(void)setTitleShadowColor:(UIColor *)color forState:(UIControlState)state{
    [_titleShadowColorDic setObject:color forKey:@(state)];
    if (self.state == state) {
        _titleLabel.shadowColor = color;
    }
}


-(UIImage *)imageForState:(UIControlState)state{
    return [_imageDic objectForKey:@(state)];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    if (image) {
        [_imageDic setObject:image forKey:@(state)];
        [self updateImageViewState];
    }
}

-(UIImage *)imageForStateOrNormalStateWhenNoExist:(UIControlState)state{
    return [self imageForState:state]?:[self imageForState:UIControlStateNormal];
}

-(UIColor *)backgroundColorForState:(UIControlState)state{
    UIColor *color = [_backgroundColorDic objectForKey:@(state)];
    if (!color) {
        color = [_backgroundColorDic objectForKey:@(UIControlStateNormal)];
    }
    return color;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    if (backgroundColor) {
        [_backgroundColorDic setObject:backgroundColor forKey:@(state)];
        if (self.state == state) {
            _backgroudImageView.backgroundColor = backgroundColor;
        }
    }
}

-(void)setContentInsets:(UIEdgeInsets)contentInsets{
    _contentInsets = contentInsets;
    [self setNeedsLayout];
}

-(void)setIsSelectType:(BOOL)isSelectType{
    _isSelectType = isSelectType;
    if (_isSelectType) {
        _isChangePresentWhenSetHightlighted = NO;
    }
}

#pragma mark - 点击时间处理

-(void)registerControlEvents{
    [super addTarget:self action:@selector(controlEventTouchDown:event:) forControlEvents:UIControlEventTouchDown];
    [super addTarget:self action:@selector(controlEventTouchDownRepeat:event:) forControlEvents:UIControlEventTouchDownRepeat];
    [super addTarget:self action:@selector(controlEventTouchDragInside:event:) forControlEvents:UIControlEventTouchDragInside];
    [super addTarget:self action:@selector(controlEventTouchDragOutside:event:) forControlEvents:UIControlEventTouchDragOutside];
    [super addTarget:self action:@selector(controlEventTouchDragEnter:event:) forControlEvents:UIControlEventTouchDragEnter];
    [super addTarget:self action:@selector(controlEventTouchDragExit:event:) forControlEvents:UIControlEventTouchDragExit];
    [super addTarget:self action:@selector(controlEventTouchUpInside:event:) forControlEvents:UIControlEventTouchUpInside];
    [super addTarget:self action:@selector(controlEventTouchOutside:event:) forControlEvents:UIControlEventTouchUpOutside];
    [super addTarget:self action:@selector(controlEventTouchCancel:event:) forControlEvents:UIControlEventTouchCancel];
    [super addTarget:self action:@selector(controlEventValueChange:event:) forControlEvents:UIControlEventValueChanged];
    [super addTarget:self action:@selector(controlEventAllTouchEvents:event:) forControlEvents:UIControlEventAllTouchEvents];
}

-(void)controlEventTouchDown:(UIControl *)sender event:(UIEvent *)event{
    [self execAction:@(UIControlEventTouchDown) event:event];
}

-(void)controlEventTouchDownRepeat:(UIControl *)sender event:(UIEvent *)event{
    [self execAction:@(UIControlEventTouchDownRepeat) event:event];
}

-(void)controlEventTouchDragInside:(UIControl *)sender event:(UIEvent *)event{
    [self execAction:@(UIControlEventTouchDragInside) event:event];
}

-(void)controlEventTouchDragOutside:(UIControl *)sender event:(UIEvent *)event{
    [self execAction:@(UIControlEventTouchDragOutside) event:event];
}

-(void)controlEventTouchDragEnter:(UIControl *)sender event:(UIEvent *)event{
    [self execAction:@(UIControlEventTouchDragEnter) event:event];
}

-(void)controlEventTouchDragExit:(UIControl *)sender event:(UIEvent *)event{
    [self execAction:@(UIControlEventTouchDragExit) event:event];
}

-(void)controlEventTouchUpInside:(UIControl *)sender event:(UIEvent *)event{
    //处理超出边界不响应
    NSSet *touchSet = [event touchesForView:self];
    [touchSet enumerateObjectsUsingBlock:^(UITouch * touch, BOOL *stop) {
        CGPoint touchPoint = [touch locationInView:self];
        if (CGRectContainsPoint(self.bounds, touchPoint)){
            
            self.userInteractionEnabled = NO;
            [self performSelector:@selector(setUserInteractionEnabledByNumber) withObject:nil afterDelay:0.5]; //防止连续点击
            
            
            //处理延迟加载
            if (_delayInterval > 0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_delayInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self execAction:@(UIControlEventTouchUpInside) event:event];
                });
            }else{
                [self execAction:@(UIControlEventTouchUpInside) event:event];
            }
        }
        else{
            *stop = YES;
        }
    }];
}

- (void)setUserInteractionEnabledByNumber
{
    self.userInteractionEnabled = YES;
}

-(void)controlEventTouchOutside:(UIControl *)sender event:(UIEvent *)event{
    [self execAction:@(UIControlEventTouchUpOutside) event:event];
}

-(void)controlEventTouchCancel:(UIControl *)sender event:(UIEvent *)event{
    [self execAction:@(UIControlEventTouchCancel) event:event];
}

-(void)controlEventValueChange:(UIControl *)sender event:(UIEvent *)event{
    //处理超出边界不响应
    NSSet *touchSet = [event touchesForView:self];
    [touchSet enumerateObjectsUsingBlock:^(UITouch * touch, BOOL *stop) {
        CGPoint touchPoint = [touch locationInView:self];
        if (CGRectContainsPoint(self.bounds, touchPoint)){
            
            
            //处理延迟加载
            if (_delayInterval > 0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_delayInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self execAction:@(UIControlEventValueChanged) event:event];
                });
            }else{
                [self execAction:@(UIControlEventValueChanged) event:event];
            }
        }
        else{
            *stop = YES;
        }
    }];
}

-(void)controlEventAllTouchEvents:(UIControl *)sender event:(UIEvent *)event{
    [self execAction:@(UIControlEventAllTouchEvents) event:event];
}

-(void)execAction:(NSNumber *)controlEventNum event:(UIEvent *)event{
    UIControlEvents events = [controlEventNum integerValue];
    for (ZKBControlAction *controlAction in _registeredActions) {
        if (controlAction.controlEvents == events) {
            id target = controlAction.target;
            SEL sel = controlAction.action;
            Method method = class_getInstanceMethod([target class], sel);
            int argumentCount = method_getNumberOfArguments(method);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            if (argumentCount > 0) {
                if (argumentCount == 1) {
                    [target performSelector:sel withObject:self];
                }else{
                    [target performSelector:sel withObject:self withObject:event];
                }
                
            }else{
                [target performSelector:sel];
            }
#pragma clang diagnostic pop
        }
    }
}

#pragma mark - 重写父类的方法
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    if (_isSelectType) {
        [self updateContentForSelect:!self.selected];
    }
    return [super beginTrackingWithTouch:touch withEvent:event] ;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {

    //判断是否是选择类型按钮,是的话,如果点击取消,需要还原按钮的状态
    if (_isSelectType) {
        CGPoint touchPoint = [touch locationInView:self];
        if (!CGRectContainsPoint(self.bounds, touchPoint)){
            [self updateContentForSelect:self.selected];
        }else{
            self.selected = !self.selected;
            [self execAction:@(UIControlEventValueChanged) event:event];
        }
    }

    
    [super endTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event{
    //判断是否是选择类型按钮,是的话,如果点击取消,需要还原按钮的状态
    if (_isSelectType) {
        [self updateContentForSelect:self.selected];
    }
    [super cancelTrackingWithEvent:event];
}


-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    ZKBControlAction *controlAction = [[ZKBControlAction alloc] init];
    controlAction.target = target;
    controlAction.action = action;
    controlAction.controlEvents = controlEvents;
    [_registeredActions addObject:controlAction];
}

-(void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    NSMutableArray *discard = [[NSMutableArray alloc] init];
    
    for (ZKBControlAction *controlAction in _registeredActions) {
        if (controlAction.target == target && (controlAction.action == action || action == NULL || controlAction.controlEvents == controlEvents)) {
            [discard addObject:controlAction];
        }
    }
    
    [_registeredActions removeObjectsInArray:discard];
}

- (NSArray *)actionsForTarget:(id)target forControlEvent:(UIControlEvents)controlEvent
{
    NSMutableArray *actions = [[NSMutableArray alloc] init];
    
    for (ZKBControlAction *controlAction in _registeredActions) {
        if ((target == nil || controlAction.target == target) && (controlAction.controlEvents & controlEvent) ) {
            [actions addObject:NSStringFromSelector(controlAction.action)];
        }
    }
    
    if ([actions count] == 0) {
        return nil;
    } else {
        return actions;
    }
}

- (NSSet *)allTargets
{
    return [NSSet setWithArray:[_registeredActions valueForKey:@"target"]];
}

- (UIControlEvents)allControlEvents
{
    UIControlEvents allEvents = 0;
    
    for (ZKBControlAction *controlAction in _registeredActions) {
        allEvents |= controlAction.controlEvents;
    }
    
    return allEvents;
}

-(void)setEnabled:(BOOL)enabled{
    if (enabled != self.isEnabled) {
        [super setEnabled:enabled];
        if (enabled) {
            UIImage *enableImage = [self imageForState:UIControlStateNormal];
            if (enableImage) {
                _imageView.image = enableImage;
            }
            _titleLabel.textColor = [self titleColorForState:UIControlStateNormal];
            _titleLabel.shadowColor = [self titleShadowColorForState:UIControlStateNormal];
        }else{
            UIImage *disableImage = [self imageForState:UIControlStateDisabled];
            if (disableImage) {
                _imageView.image = disableImage;
            }
            _titleLabel.textColor = [self titleColorForState:UIControlStateDisabled];
            _titleLabel.shadowColor = [self titleShadowColorForState:UIControlStateDisabled];
        }
    }
}

-(void)setSelected:(BOOL)selected{
    if(self.selected != selected){
        [super setSelected:selected];
        [self updateContentForSelect:selected];
    }
}



/**
 *  重写系统的setHighlighted方法,这个方法系统默认会在touchBegin和touchEnd方法中调用两次,所以跟hightlight相关的变化不需要再Tracking系列方法中处理
 *
 */
-(void)setHighlighted:(BOOL)highlighted{
    if (self.highlighted != highlighted) {
        [super setHighlighted:highlighted];
        
        if (_isChangePresentWhenSetHightlighted) {
            if(_highlightDelayInterval > 0){
                [self performSelector:@selector(updateAllContent) withObject:nil afterDelay:_highlightDelayInterval inModes:@[NSRunLoopCommonModes]];
            }else{
                [self updateAllContent];
            }
//            if (highlighted) {
//                UIImage *highlightedImage = [self imageForState:UIControlStateHighlighted];
//                if (highlightedImage) {
//                    _imageView.image = highlightedImage;
//                }
//                _titleLabel.textColor = [self titleColorForState:UIControlStateHighlighted];
//                _titleLabel.shadowColor = [self titleShadowColorForState:UIControlStateHighlighted];
//                _titleLabel.text = [self titleForState:UIControlStateHighlighted];
//                [self updateAllContent];
//            }else{
//                UIImage *enableImage = [self imageForState:UIControlStateNormal];
//                if (enableImage) {
//                    _imageView.image = enableImage;
//                }
//                _titleLabel.textColor = [self titleColorForState:UIControlStateNormal];
//                _titleLabel.shadowColor = [self titleShadowColorForState:UIControlStateNormal];
//                _titleLabel.text = [self titleForState:UIControlStateNormal];
//            }
        }
    }
}


@end
