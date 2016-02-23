//
//  ZKBViewController+ZKBAnimation.m
//  UITest
//
//  Created by keven on 15/2/7.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBViewController+ZKBAnimation.h"
#import "ZKBView.h"

@implementation ZKBViewController (ZKBAnimation)

+ (void)pushView:(ZKBView *)pushView  pushModel:(ZKBAnimationPushModel)model animantion:(BOOL)animation  callBack:(ZKBCallBack)block
{
    ZKB_ASSERT_METHOD(pushView.superview, @"pushView: -> pushView.superview not be nil");
    
    CGRect begainFrame = [ZKBViewController begainFrameForPushView:pushView pushModel:model];
    CGRect endFrame = pushView.bounds;
    
    pushView.frame = begainFrame;
    void (^animations)(void) = ^(){
        pushView.frame = endFrame;
    };
    
    void (^completion)(BOOL finished) = ^(BOOL finished){
        if (block) {
            block(finished);
        }
    };
    
    if (animation) {
        [UIView animateWithDuration:ZKB_ANIMATION_DURATION
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animations
                         completion:completion];
        
//        [UIView animateWithDuration:ZKB_ANIMATION_DURATION
//                         animations:animations
//                         completion:completion];
    }else{
        animations();
        completion(YES);
    }
}

+ (void)popView:(ZKBView *)popView  popModel:(ZKBAnimationPopModel)model animation:(BOOL)animation callBack:(ZKBCallBack)block
{
    ZKB_ASSERT_METHOD(popView, @"popView: -> popView not be nil");
    
    CGRect endFrame = [ZKBViewController endFrameForPopView:popView popModel:model];
    void (^animations)(void) = ^(){
        popView.frame = endFrame;
    };
    
    void (^completion)(BOOL finished) = ^(BOOL finished){
        if (block) {
            block(finished);
        }
    };
    
    if (animation) {
        [UIView animateWithDuration:ZKB_ANIMATION_DURATION
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animations
                         completion:completion];
    }else{
        animations();
        completion(YES);
    }
}

#pragma mark - < 工具方法 > -

+ (CGRect)begainFrameForPushView:(ZKBView *)pushView pushModel:(ZKBAnimationPushModel)model
{
    CGRect retRect = pushView.bounds;
    switch (model) {
        case ZKBAnimationPushModelLeft:{
            retRect.origin.x = -retRect.size.width;
            break;
        }
        case ZKBAnimationPushModelRight:{
            retRect.origin.x = retRect.size.width;
            break;
        }
        case ZKBAnimationPushModelUp:{
            retRect.origin.y = - retRect.size.height;

            break;
        }
        case ZKBAnimationPushModelDown:{
            retRect.origin.y = retRect.size.height;

            break;
        }
            
        default:
            break;
    }
    return  retRect;
}

+ (CGRect)endFrameForPopView:(ZKBView *)popView popModel:(ZKBAnimationPopModel)model
{
    CGRect retRect = popView.bounds;
    
    switch (model) {
        case ZKBAnimationPopModelLeft:{
            retRect.origin.x = -retRect.size.width;
            break;
        }
        case ZKBAnimationPopModelRight:{
            retRect.origin.x = retRect.size.width;

            break;
        }
        case ZKBAnimationPopModelUp:{
            retRect.origin.y = - retRect.size.height;

            break;
        }
        case ZKBAnimationPopModelDown:{
            retRect.origin.y = retRect.size.height;

            break;
        }
        
            
        default:
            break;
    }
    return  retRect;

}
@end
