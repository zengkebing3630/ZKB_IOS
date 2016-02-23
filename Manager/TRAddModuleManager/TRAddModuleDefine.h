//
//  TRAddModuleDefine.h
//  PPAppPlatformKitDylib
//
//  Created by zkb on 15/3/2.
//  Copyright (c) 2015年 TR. All rights reserved.
//


#ifndef PPAppPlatformKitDylib_TRAddModuleDefine_h
#define PPAppPlatformKitDylib_TRAddModuleDefine_h

//数据埋点模块
#define TR_SUPPORT_NIUBILITY  1    //支持数据埋点 1：支持 | 0 不支持

#define TR_SDK_NIUBILITY_INTERFACE_NAME     @"TRSDKNiubility"                           //入口类
#define TR_SDK_NIUBILITY_INIT_METHOD_NAME   @"getInstance"                              //入口类初始化方法
#define TR_SDK_NIUBILITY_CLICK_METHOD_NAME  @"recordNoReferAppOperationWithClick:"      //点击方法
#define TR_SDK_NIUBILITY_SHOW_METHOD_NAME   @"recordNoReferAppOperationWithShow:"       //显示,无列表方法
#define TR_SDK_NIUBILITY_SHOW_METHOD_NAME_L @"recordNoReferAppOperationWithShow:listId:"//显示,有列表方法

#endif
