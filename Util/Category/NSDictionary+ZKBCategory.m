//
//  NSDictionary+ZKBCategory.m
//  ywq
//
//  Created by zkb on 15/2/9.
//  Copyright (c) 2015年 tgnet. All rights reserved.
//

#import "NSDictionary+ZKBCategory.h"

@implementation NSDictionary (ZKBCategory)
- (NSString*)jsonString
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil)
    {
        return nil;
    }else{
        return [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
    }
}
@end
