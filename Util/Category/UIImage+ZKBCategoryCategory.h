//
//  UIImage+TGCategory.h
//  WenDa
//
//  Created by tg on 14-12-22.
//  Copyright (c) 2014年 天工网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZKBCategory)

/**
 *  图片拉伸
 *
 *  @param widthFraction  总宽几分之几处
 *  @param heightFraction 总高几分之几处
 *
 *  @return 被拉伸的图片
 */
- (UIImage *)stretchableImageWithCapWidthFraction:(CGFloat)widthFraction
                                CapHeightFraction:(CGFloat)heightFraction;

- (void)imageByScalingToMaxSize;

//图片压缩 scale：0 ~1
- (NSData * )imageCompression:(CGFloat)scale;
@end
