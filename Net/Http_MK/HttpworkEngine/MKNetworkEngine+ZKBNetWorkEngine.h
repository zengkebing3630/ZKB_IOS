//
//  MKNetworkEngine+ZKBNetWorkEngine.h
//  UITest
//
//  Created by zkb on 15/2/11.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface MKNetworkEngine (ZKBNetWorkEngine)
- (MKNetworkOperation*)operationWithGetURLString:(NSString *)getURLString;
- (MKNetworkOperation*)operationWithDeleteURLString:(NSString *)deleteURLString;

- (MKNetworkOperation*)operationWithPostURLString:(NSString *)postURLString params:(NSDictionary*)body;
- (MKNetworkOperation*)operationWithPutURLString:(NSString *)putURLString params:(NSDictionary*)body;
- (MKNetworkOperation*)operationWithPatchURLString:(NSString *)patchURLString params:(NSDictionary*)body;

@end
