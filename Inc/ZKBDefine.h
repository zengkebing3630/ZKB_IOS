//
//  ZKBUIDefine.h
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//


/**
 (1)公共的宏放“ZKBDefine”,“ZKBDefine”只能引用扩展，宏定义文件
 (2)支持ARC的宏，常量，方法 ...放在 "ZKBDefineARC.h"
 (3)支持非ARC的宏，常量，方法...放在 "TGDefineFnoARC.h"
 (3)全局的类别放在"ZKBTypeDefine.h"
 (4)全局URL定义放在"ZKBURLDefine.h"
 (5)全局UI相关的定义放在"ZKBUIDefine.h"
 */

#import "ZKBTypeDefine.h"
#import "ZKBURLDefine.h"
#import "ZKBUIDefine.h"
#import "UIView+ZKBCategory.h"

#if __has_feature(objc_arc)                   //objc_arc
#import "ZKBDefineARC.h"

#else                                           //none
#import "ZKBDefineFnoARC.h"
#endif


#ifndef ZKBDefine_h
#define ZKBDefine_h


    #if !defined(__clang__) || __clang_major__ < 3
        #ifndef __bridge
            #define __bridge
        #endif

        #ifndef __bridge_retain
            #define __bridge_retain
        #endif

        #ifndef __bridge_retained
            #define __bridge_retained
        #endif

        #ifndef __autoreleasing
            #define __autoreleasing
        #endif

        #ifndef __strong
            #define __strong
        #endif

        #ifndef __unsafe_unretained
            #define __unsafe_unretained
        #endif

        #ifndef __weak
            #define __weak
        #endif
    #endif

//打印
    #ifdef  DEBUG   //DeBug版本宏
        #define DLog(fmt, ...)                  NSLog((@"[Method:%s]-[Line %d]->" fmt),__PRETTY_FUNCTION__, __LINE__,##__VA_ARGS__)
        #define DLogSize(_size)                 DLog(@"CGSize:%@", NSStringFromCGSize(_size))
        #define DLogRect(_rect)                 DLog(@"NSRect:%@",NSStringFromCGRect(_rect))
        #define DLogPoint(_point)               DLog(@"NSPoint:%@",NSStringFromCGPoint(_point))
//        #define DLogVector(_vector)             DLog(@"NSVector:%@",NSStringFromCGVector(_vector))
        #define DLogEdgeInsets(_edgeInsets)     DLog(@"UIEdgeInsets:%@",NSStringFromUIEdgeInsets(_edgeInsets))
        #define DLogOffset(_Offset)             DLog(@"UIOffset:%@",NSStringFromUIOffset(_Offset))
        #define DLogTransform(_Transform)       DLog(@"CGAffineTransform:%@",NSStringFromCGAffineTransform(_Transform))
        #define DLogSelector                    DLog(@"Selector:%@",NSStringFromSelector(_cmd))
        #define DLogClass(_ClassObject)         DLog(@"Class:%@",NSStringFromClass([_ClassObject class]))




    #else           //Release版本宏（发布版本）
        #define DLog(fmt, ...)
        #define DLogSize(_size)
        #define DLogRect(_rect)
        #define DLogPoint(_point)
//        #define DLogVector(_vector)
        #define DLogEdgeInsets(_edgeInsets)
        #define DLogOffset(_Offset)
        #define DLogTransform(_Transform)
        #define DLogSelector
        #define DLogClass(_ClassObject)
    #endif




//断言
#define ZKB_ASSERT_METHOD(_para,_showString)  NSAssert(_para,_showString);
//固件版本判断
#define ZKB_IOS_VERSION_OR_ABOVE(_version) (([[[UIDevice currentDevice] systemVersion] floatValue] >= _version)? (YES):(NO))





typedef void (^ZKBCallBack)(BOOL isFinished);

#endif

