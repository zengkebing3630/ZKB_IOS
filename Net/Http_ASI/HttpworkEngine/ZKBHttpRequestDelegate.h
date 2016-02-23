//
//  ZKBHttpRequestDelegate.h
//  UITest
//
//  Created by zkb on 15/2/10.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZKBHttpRequestDelegate <NSObject>
- (void)requestCallBack:(BOOL)isSuccess
               response:(NSDictionary *)response
                    tag:(NSInteger)iRequestTag
               userInfo:(NSDictionary *)info
                   data:(id)data;
@end
