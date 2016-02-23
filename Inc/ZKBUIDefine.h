//
//  ZKBUIDefine.h
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//


#ifndef ZKBUIDefine_h
#define ZKBUIDefine_h

#define ZKB_IOS_VERSION_8         8.0
#define ZKB_IOS_VERSION_7         7.0
#define ZKB_IOS_VERSION_6         6.0
#define ZKB_IOS_VERSION_5         5.0



#define ZKB_DISTANCE_0            0.0
#define ZKB_DISTANCE_1            1.0
#define ZKB_DISTANCE_8            8.0
#define ZKB_DISTANCE_10           10.0

#define ZKB_LINE_HEIGHT           1.0


#define ZKB_TAB_BAR_HEIGHT        49.0
#define ZKB_NAVIGATION_BAR_HEIGHT_44 44.0
#define ZKB_NAVIGATION_BAR_HEIGHT_64 64.0

//TODO：可能出错
#define ZKB_NAVIGATION_BAR_HEIGHT ((ZKB_IOS_VERSION_OR_ABOVE(ZKB_IOS_VERSION_5)) ? ZKB_NAVIGATION_BAR_HEIGHT_64 : ZKB_NAVIGATION_BAR_HEIGHT_44)
#define ZKB_STATUS_BAR_HEIGHT     20.0

#define ZKB_MAIN_SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define ZKB_ANIMATION_DURATION 0.3






//颜色
#define COLOR_FFFFFF     @"0xffffff"
#define COLOR_000000     @"0x000000"
#define COLOR_333333     @"0x333333"
#define COLOR_666666     @"0x666666"
#define COLOR_999999     @"0x999999"
#define COLOR_DADADA     @"0xdadada"
#define COLOR_F3F3F3     @"0xf3f3f3"
#define COLOR_FAFAFA     @"0xfafafa"
#define COLOR_F0F0F0     @"0xf0f0f0"
#define COLOR_CCCCCC     @"0xcccccc"


//透明度
#define Alpha01  0.1f
#define Alpha02  0.2f
#define Alpha03  0.3f
#define Alpha04  0.4f
#define Alpha05  0.5f
#define Alpha06  0.6f
#define Alpha07  0.7f
#define Alpha08  0.8f
#define Alpha09  0.9f
#define Alpha10  1.0f

//字体大小
#define Font0   0/2
#define Font2   2/2
#define Font4   4/2
#define Font6   6/2
#define Font8   8/2
#define Font10  10/2
#define Font12  12/2
#define Font14  14/2
#define Font16  16/2
#define Font18  18/2
#define Font20  20/2
#define Font22  22/2
#define Font24  24/2
#define Font26  26/2
#define Font28  28/2
#define Font30  30/2
#define Font32  32/2
#define Font34  34/2
#define Font36  36/2
#define Font38  38/2
#define Font40  40/2
#define Font42  42/2
#define Font44  44/2
#define Font46  46/2
#define Font48  48/2
#define Font50  50/2
#define Font52  52/2
#define Font54  54/2
#define Font56  56/2
#define Font58  58/2
#define Font60  60/2
#define Font62  62/2
#define Font64  64/2
#define Font66  66/2
#define Font68  68/2
#define Font70  70/2
#define Font72  72/2
#define Font74  74/2
#define Font76  76/2
#define Font78  78/2
#define Font80  80/2
#define Font82  82/2
#define Font84  84/2
#define Font86  86/2
#define Font88  88/2
#define Font90  90/2
#define Font92  92/2
#define Font94  94/2
#define Font96  96/2
#define Font98  98/2
#define Font100 100/2

#define UIColorFromRGB(_color, _alpha)  [ZKBTools TColor:_color colorAlpha:_alpha]
#define UIFontFormSize(_fontSize)       [UIFont systemFontOfSize:_fontSize] //默认字体格式
#define UIFontBoldFormSize(_fontSize)   [UIFont boldSystemFontOfSize:_fontSize] //加粗
#define UIFontItalicFormSize(_fontSize) [UIFont italicSystemFontOfSize:_fontSize] //斜体


#define FontStyle30_ffffff_10(fontParam, colorParam) \
fontParam = [UIFont systemFontOfSize:Font30];\
colorParam = [ZKBTools TColor:COLOR_FFFFFF colorAlpha:Alpha10];

#endif
