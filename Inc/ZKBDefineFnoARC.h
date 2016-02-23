//
//  TGDefineFnoARC.h
//
//  Created by zkb on 15/2/4.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#ifndef ZKBDefineFnoARC_h
#define ZKBDefineFnoARC_h

    #define ARC_PROP_RETAIN retain
    #define ARC_RETAIN(x) ([(x) retain])
    #define ARC_RELEASE(x) ([(x) release])
    #define ARC_AUTORELEASE(x) ([(x) autorelease])
    #define ARC_BLOCK_COPY(x) (Block_copy(x))
    #define ARC_BLOCK_RELEASE(x) (Block_release(x))
    #define ARC_SUPER_DEALLOC() ([super dealloc])
    #define ARC_AUTORELEASE_POOL_START() NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    #define ARC_AUTORELEASE_POOL_END() [pool release];

#define  PROPERTY_NON_ATOMIC_ASSIGN  @property (nonatomic,assign)
#define  PROPERTY_NON_ATOMIC_COPY    @property (nonatomic,copy  )
#define  PROPERTY_NON_ATOMIC_RETAIN  @property (nonatomic,retain)

#define  PROPERTY_ATOMIC_ASSIGN      @property (atomic,assign)
#define  PROPERTY_ATOMIC_COPY        @property (atomic,copy  )
#define  PROPERTY_ATOMIC_RETAIN      @property (atomic,retain)



    //单利
    #define SYNTHESIZE_SINGLETON_FOR_CLASS(className)   static className *shared##className = nil; \
                                                        + (className *)share {\
                                                            static dispatch_once_t onceToken; \
                                                            dispatch_once(&onceToken, ^{ \
                                                                shared##className = [[self alloc] init]; \
                                                            }); \
                                                            return shared##className;\
                                                        }\
                                                        + (id)allocWithZone:(NSZone *)zone{\
                                                            static dispatch_once_t onceToken; \
                                                            dispatch_once(&onceToken, ^{ \
                                                                shared##className = [super allocWithZone:zone]; \
                                                            }); \
                                                            return shared##className;\
                                                        }\
                                                        - (id)copyWithZone:(NSZone *)zone{\
                                                            return self;\
                                                        } \
                                                        - (id)retain{\
                                                            return self;\
                                                        }\
                                                        - (NSUInteger)retainCount{\
                                                            return NSUIntegerMax;\
                                                        }\
                                                        - (void)release{\
                                                        }\
                                                        - (void)dealloc{\
                                                        }\
                                                        - (id)autorelease{\
                                                            return self; \
                                                        }


#endif
