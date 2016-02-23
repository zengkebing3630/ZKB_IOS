//
//  TGDefineARC.h
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//


#ifndef ZKBDefineARC_h
#define ZKBDefineARC_h

    #define ARC_PROP_RETAIN strong
    #define ARC_RETAIN(x) (x)
    #define ARC_RELEASE(x)
    #define ARC_AUTORELEASE(x) (x)
    #define ARC_BLOCK_COPY(x) (x)
    #define ARC_BLOCK_RELEASE(x)
    #define ARC_SUPER_DEALLOC()
    #define ARC_AUTORELEASE_POOL_START() @autoreleasepool {
    #define ARC_AUTORELEASE_POOL_END() }



#define  PROPERTY_NON_ATOMIC_ASSIGN  @property (nonatomic,assign)
#define  PROPERTY_NON_ATOMIC_COPY    @property (nonatomic,copy  )
#define  PROPERTY_NON_ATOMIC_RETAIN  @property (nonatomic,strong)
#define  PROPERTY_NON_ATOMIC_WEAK    @property (nonatomic,weak)

#define  PROPERTY_ATOMIC_ASSIGN      @property (atomic,weak  )
#define  PROPERTY_ATOMIC_COPY        @property (atomic,copy  )
#define  PROPERTY_ATOMIC_RETAIN      @property (atomic,strong)

    //单例
    #define SYNTHESIZE_SINGLETON_FOR_CLASS(className)   + (className *)share { \
                                                        static className *shared##className = nil; \
                                                        static dispatch_once_t onceToken; \
                                                        dispatch_once(&onceToken, ^{ \
                                                            shared##className = [[self alloc] init]; \
                                                        }); \
                                                        return shared##className;\
                                                        }
#endif
