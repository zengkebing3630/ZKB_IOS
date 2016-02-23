//
//  ZKBObject.m
//  UITest
//
//  Created by zkb on 15/2/13.
//  Copyright (c) 2015年 zkb. All rights reserved.
//

#import "ZKBObject.h"

#import <objc/runtime.h>

/*
使用场景
在一个函数找不到时，Objective-C提供了三种方式去补救：

1、调用resolveInstanceMethod给个机会让类添加这个实现这个函数

2、调用forwardingTargetForSelector让别的对象去执行这个函数

3、调用methodSignatureForSelector（函数符号制造器）和forwardInvocation（函数执行器）灵活的将目标函数以其他形式执行。

4、如果都不中，调用doesNotRecognizeSelector抛出异常。
*/

@interface ZKBObject (/*private*/)
@property (nonatomic,assign)BOOL isOpenNotRecognizeSelectorHandler;
@end


//全局函数
void dynamicMethodIMP(id self, SEL _cmd)
{
    // implementation ....
}


@implementation ZKBObject

/**
 *  开启NotRecognizeSelector 容错处理
 *
 *  @param isOpen 开启：YES  | 关闭 ： NO
 */
- (void)openNotRecognizeSelectorHandler:(BOOL)isOpen
{
    if ([self isOpenNotRecognizeSelectorHandler] != isOpen) {
        self.isOpenNotRecognizeSelectorHandler = isOpen;
    }
}

//(1)这个函数在运行时(runtime)，没有找到SEL的IML时就会执行。这个函数是给类利用class_addMethod添加函数的机会。
//根据文档，如果实现了添加函数代码则返回YES，未实现返回NO。
//根据Demo实验，这个函数返回的BOOL值系统实现的objc_msgSend函数并没有参考，无论返回什么系统都会尝试再次用SEL找IML，
//如果找到函数实现则执行函数。如果找不到继续其他查找流程。
+ (BOOL)resolveInstanceMethod:(SEL)aSEL
{
    if (aSEL == @selector(resolveThisMethodDynamically))
    {
        class_addMethod([self class], aSEL, (IMP) dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:aSEL];
}


//(2)流程到了这里，系统给了个将这个SEL转给其他对象的机会。
//返回参数是一个对象，如果这个对象非nil、非self的话，系统会将运行的消息转发给这个对象执行。否则，继续查找其他流程
- (id)forwardingTargetForSelector
{
    return nil;
}

//(3)这个函数和后面的forwardInvocation:是最后一个寻找IML的机会。这个函数让重载方有机会抛出一个函数的签名，
//再由后面的forwardInvocation:去执行。

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return nil;
}

//(4)真正执行从methodSignatureForSelector:返回的NSMethodSignature。在这个函数里可以将NSInvocation多次转发到多个对象中，
//这也是这种方式灵活的地方。（forwardingTargetForSelector只能以Selector的形式转向一个对象）
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if (![self respondsToSelector:anInvocation.selector]) {
        
    }
    [super forwardInvocation:anInvocation];
}
//(5)作为找不到函数实现的最后一步，NSObject实现这个函数只有一个功能，就是抛出异常。
//虽然理论上可以重载这个函数实现保证不抛出异常（不调用super实现），但是苹果文档着重提出“一定不能让这个函数就这么结束掉，必须抛出异常”。
- (void)doesNotRecognizeSelector:(SEL)aSelector
{

}

@end
