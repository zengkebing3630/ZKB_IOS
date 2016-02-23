//
//  UIImage+TGCategory.m
//  WenDa
//
//  Created by tg on 14-12-22.
//  Copyright (c) 2014年 天工网. All rights reserved.
//

#import "UIImage+ZKBCategoryCategory.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@implementation UIImage (ZKBCategory)

/**
 *  图片拉伸
 *
 *  @param widthFraction  总宽几分之几处
 *  @param heightFraction 总高几分之几处
 *
 *  @return 被拉伸的图片
 */
- (UIImage *)stretchableImageWithCapWidthFraction:(CGFloat)widthFraction
                                CapHeightFraction:(CGFloat)heightFraction
{
    return [self stretchableImageWithLeftCapWidth:self.size.width * widthFraction
                                      topCapHeight:self.size.height * heightFraction];
}


- (void)imageByScalingToMaxSize
{
    if (self.size.width < ORIGINAL_MAX_WIDTH) return;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (self.size.width > self.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = self.size.width * (ORIGINAL_MAX_WIDTH / self.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = self.size.height * (ORIGINAL_MAX_WIDTH / self.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    [self imageByScalingAndCroppingForTargetSize:targetSize];
}



- (UIImage *)imageByScalingAndCroppingForTargetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

//等比例缩放
+ (UIImage*)originImage:(UIImage *)image
{
    int h = image.size.height;
    int w = image.size.width;
    CGSize imageSize = image.size;
    if(w > 320){
        float b = (float)320/w;
        imageSize = CGSizeMake(b*w, b*h);
    }
    
    UIGraphicsBeginImageContext(imageSize);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}

//图片压缩 scale：0 ~1
- (NSData * )imageCompression:(CGFloat)scale
{
    if (UIImagePNGRepresentation(self) == nil) {
        return  UIImageJPEGRepresentation(self, scale);
    } else {
        return UIImagePNGRepresentation(self);
    }
}
@end
