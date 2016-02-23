//
//  NSObject+TCategory.h
//  Function
//
//  Created by keven on 14-11-21.
//  Copyright (c) 2014年 无线网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZKBCategory)



/**
 *  属性列表转换成数组 @[@{property:propertyValue}，@{}] -->IOS反射 ,不能直接用NSObject
 *
 *  @return 属性数组
 */
- (NSMutableArray *)TpropertyList;
@end
