//
//  TGTypeDefine.h
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//


/**
 *      全局类别声明放此文件，局部类别声明放在局部文件
 */

#ifndef ZKBTypeDefine_h
#define ZKBTypeDefine_h

typedef NS_ENUM(NSInteger, ZKBNavigationItemType) {
    ZKBNavigationItemTypeNone,
    ZKBNavigationItemTypeBack,
};

typedef NS_ENUM(NSInteger, ZKBAnimationPushModel) {
    ZKBAnimationPushModelLeft,
    ZKBAnimationPushModelRight,
    ZKBAnimationPushModelUp,
    ZKBAnimationPushModelDown,
    ZKBAnimationPushModelDefault = ZKBAnimationPushModelRight,
    
};

typedef NS_ENUM(NSInteger, ZKBAnimationPopModel) {
    ZKBAnimationPopModelLeft,
    ZKBAnimationPopModelRight,
    ZKBAnimationPopModelUp,
    ZKBAnimationPopModelDown,
    ZKBAnimationPopModelDefault = ZKBAnimationPopModelRight,
};

#endif
