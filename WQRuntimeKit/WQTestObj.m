//
//  WQTestObj.m
//  WQRuntimeKit
//
//  Created by admin on 17/3/2.
//  Copyright © 2017年 jolimark. All rights reserved.
//

#import "WQForword.h"
#import "WQTestObj.h"
#import "WQRuntimeKit.h"
#import <objc/message.h>

@implementation WQTestObj
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@">> >> >> %s << << <<",__func__);
    [WQRuntimeKit addInstanceMethodForClass:[self class]
                                 methodName:sel
                                  implement:@selector(func5)];
    return YES;
}

//+ (BOOL)resolveClassMethod:(SEL)sel {
//    NSLog(@">> >> >> %s << << <<",__func__);
//    return YES;
//}
//
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    NSLog(@">> >> >> %s << << <<",__func__);
//    // 返回一个能处理这个函数的对象
//    return [super forwardingTargetForSelector:aSelector];
//}
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    if (aSelector == @selector(func11:)) {
//        NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
//        if (!signature) {
//            if ([WQForword instancesRespondToSelector:aSelector]) {
//                signature = [WQForword instanceMethodSignatureForSelector:aSelector];
//            }
//        }
//        return signature;
//    }
//    return [super methodSignatureForSelector:aSelector];
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    NSLog(@">> >> >> %s << << <<",__func__);
//    WQForword *forword = [[WQForword alloc] init];
//    if ([forword respondsToSelector:anInvocation.selector]) {
//        [anInvocation invokeWithTarget:forword];
//    }
//}

void func66 (NSNumber *i) {
    NSLog(@"func66 %@",i);
}

- (int)func11:(int)i j:(NSNumber *)j {
    NSLog(@"func11: %d -- j: %@",i,j);
    return i+[j intValue];
}

- (void)func4:(int)value {
    NSLog(@"func4: %d",value);
}

- (NSNumber *)func5 {
    NSLog(@"func5");
    return @(5);
}

- (void)func8:(NSString *)str {
    NSLog(@"func8: %@",str);
}

- (NSInteger)func9:(int)value {
    NSLog(@"func9: %d",value);
    return 9;
}

- (void)func10:(int)value0 value1:(int)value1 {
    NSLog(@"value0 = %d -- value1 = %d",value0,value1);
}

- (void)func {
    NSLog(@"Func: %d",self.volume++);
}

- (id)performSelector:(SEL)aSelector
            arguments:(void **)arguments
                count:(int)count {
    NSMethodSignature *singature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (singature) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:singature];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        NSArray *params = [NSStringFromSelector(aSelector) componentsSeparatedByString:@":"];
        NSInteger paramCount = params.count - 1;
        if (paramCount != count) {
            // 传入参数不正确
            @throw [NSException exceptionWithName:@"WQException" reason:@"传入参数错误" userInfo:nil];
            return nil;
        }
        int argIndex = 2;
        for (int index = 0; index < count; index ++) {
            void* argument = *(arguments+index);
            [invocation setArgument:argument atIndex:argIndex ++];
        }
        [invocation retainArguments];
        [invocation invoke];
        
        const char *returnType = singature.methodReturnType;
        
        //声明返回值变量
        id returnValue;
        
        //如果没有返回值，也就是消息声明为void，那么returnValue=nil
        if( !strcmp(returnType, @encode(void)) ){
            returnValue =  nil;
        }else if( !strcmp(returnType, @encode(id)) ){
            //如果返回值为对象，那么为变量赋值
            [invocation getReturnValue:&returnValue];
        }else{
            //如果返回值为普通类型NSInteger  BOOL
            //返回值长度
            NSUInteger length = [singature methodReturnLength];
            
            //根据长度申请内存
            void *buffer = (void *)malloc(length);
            
            //为变量赋值
            [invocation getReturnValue:buffer];
            if (strcmp(returnType, @encode(void))  == 0) {
                returnValue = nil;
            }else if (strcmp(returnType, @encode(int))  == 0) {
                returnValue = [NSNumber numberWithInt:*((int *)buffer)];
            }else if (strcmp(returnType, @encode(unsigned int))  == 0) {
                returnValue = [NSNumber numberWithUnsignedInt:*((unsigned int *)buffer)];
            }else if (strcmp(returnType, @encode(float)) == 0) {
                returnValue = [NSNumber numberWithFloat:*((float *)buffer)];
            }else if (strcmp(returnType, @encode(double))  == 0) {
                returnValue = [NSNumber numberWithDouble:*((double *)buffer)];
            }else if (strcmp(returnType, @encode(BOOL)) == 0) {
                returnValue = [NSNumber numberWithBool:*((BOOL *)buffer)];
            }else if(strcmp(returnType, @encode(NSInteger)) == 0){
                returnValue = [NSNumber numberWithInteger:*((NSInteger *)buffer)];
            }else if (strcmp(returnType, @encode(char)) == 0) {
                returnValue = [NSNumber numberWithChar:*((char *)buffer)];
            }else if (strcmp(returnType, @encode(unsigned char)) == 0) {
                returnValue = [NSNumber numberWithUnsignedChar:*((unsigned char *)buffer)];
            }else if (strcmp(returnType, @encode(short)) == 0) {
                returnValue = [NSNumber numberWithShort:*((short *)buffer)];
            }else if (strcmp(returnType, @encode(unsigned short)) == 0) {
                returnValue = [NSNumber numberWithUnsignedShort:*((unsigned short *)buffer)];
            }else if (strcmp(returnType, @encode(long)) == 0) {
                returnValue = [NSNumber numberWithUnsignedLong:*((long *)buffer)];
            }else if (strcmp(returnType, @encode(long long)) == 0) {
                returnValue = [NSNumber numberWithUnsignedLongLong:*((long long *)buffer)];
            }else if (strcmp(returnType, @encode(unsigned long long)) == 0) {
                returnValue = [NSNumber numberWithUnsignedLongLong:*((unsigned long long *)buffer)];
            }
        }
        return returnValue;
    }else {
        // 不存在这个方法，抛出异常
        @throw [NSException exceptionWithName:@"WQException" reason:@"不存在调用方法" userInfo:nil];
        return nil;
    }
}

- (id)performSelector:(SEL)aSelector
        withArguments:(NSArray<id> *)arguments {
    NSMethodSignature *singature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (singature) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:singature];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        NSArray *params = [NSStringFromSelector(aSelector) componentsSeparatedByString:@":"];
        NSInteger paramCount = params.count - 1;
        if (paramCount != arguments.count) {
            // 传入参数不正确
            @throw [NSException exceptionWithName:@"WQException" reason:@"传入参数错误" userInfo:nil];
            return nil;
        }
        int argIndex = 2;
        for (int index = 0; index < arguments.count; index ++) {
            id argument = arguments[index];
            [invocation setArgument:&argument atIndex:argIndex ++];
        }
        [invocation retainArguments];
        [invocation invoke];
        
        const char *returnType = singature.methodReturnType;
        
        //声明返回值变量
        id returnValue;
        
        //如果没有返回值，也就是消息声明为void，那么returnValue=nil
        if( !strcmp(returnType, @encode(void)) ){
            returnValue =  nil;
        }else if( !strcmp(returnType, @encode(id)) ){
            //如果返回值为对象，那么为变量赋值
            [invocation getReturnValue:&returnValue];
        }else{
            //如果返回值为普通类型NSInteger  BOOL
            //返回值长度
            NSUInteger length = [singature methodReturnLength];
            
            //根据长度申请内存
            void *buffer = (void *)malloc(length);
            
            //为变量赋值
            [invocation getReturnValue:buffer];
            if (strcmp(returnType, @encode(void))  == 0) {
                returnValue = nil;
            }else if (strcmp(returnType, @encode(int))  == 0) {
                returnValue = [NSNumber numberWithInt:*((int *)buffer)];
            }else if (strcmp(returnType, @encode(unsigned int))  == 0) {
                returnValue = [NSNumber numberWithUnsignedInt:*((unsigned int *)buffer)];
            }else if (strcmp(returnType, @encode(float)) == 0) {
                returnValue = [NSNumber numberWithFloat:*((float *)buffer)];
            }else if (strcmp(returnType, @encode(double))  == 0) {
                returnValue = [NSNumber numberWithDouble:*((double *)buffer)];
            }else if (strcmp(returnType, @encode(BOOL)) == 0) {
                returnValue = [NSNumber numberWithBool:*((BOOL *)buffer)];
            }else if(strcmp(returnType, @encode(NSInteger)) == 0){
                returnValue = [NSNumber numberWithInteger:*((NSInteger *)buffer)];
            }else if (strcmp(returnType, @encode(char)) == 0) {
                returnValue = [NSNumber numberWithChar:*((char *)buffer)];
            }else if (strcmp(returnType, @encode(unsigned char)) == 0) {
                returnValue = [NSNumber numberWithUnsignedChar:*((unsigned char *)buffer)];
            }else if (strcmp(returnType, @encode(short)) == 0) {
                returnValue = [NSNumber numberWithShort:*((short *)buffer)];
            }else if (strcmp(returnType, @encode(unsigned short)) == 0) {
                returnValue = [NSNumber numberWithUnsignedShort:*((unsigned short *)buffer)];
            }else if (strcmp(returnType, @encode(long)) == 0) {
                returnValue = [NSNumber numberWithUnsignedLong:*((long *)buffer)];
            }else if (strcmp(returnType, @encode(long long)) == 0) {
                returnValue = [NSNumber numberWithUnsignedLongLong:*((long long *)buffer)];
            }else if (strcmp(returnType, @encode(unsigned long long)) == 0) {
                returnValue = [NSNumber numberWithUnsignedLongLong:*((unsigned long long *)buffer)];
            }
        }
        return returnValue;
    }else {
        // 不存在这个方法，抛出异常
        @throw [NSException exceptionWithName:@"WQException" reason:@"不存在调用方法" userInfo:nil];
        return nil;
    }
}

- (id)performSelector:(SEL)aSelector
            arguments:(void *)arguments,... {
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (signature) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = self;
        invocation.selector = aSelector;
        NSArray<NSString *> *params = [NSStringFromSelector(aSelector) componentsSeparatedByString:@":"];
        NSInteger paramCount = params.count - 1;
        NSInteger argIndex = 2;
        va_list list;
        void* arg = arguments;
        va_start(list, arguments);
        int count = 0;
        while (arg) {
            count ++;
            if (count > paramCount) {
                @throw [NSException exceptionWithName:@"WQException" reason:@"传入参数错误" userInfo:nil];
                return nil;
            }
            [invocation setArgument:arg atIndex:argIndex ++];
            arg = va_arg(list, void *);
        };
        va_end(list);
        [invocation retainArguments];
        [invocation invoke];
        const char *returnType = signature.methodReturnType;
        
        //声明返回值变量
        id returnValue;
        
        //如果没有返回值，也就是消息声明为void，那么returnValue=nil
        if( !strcmp(returnType, @encode(void)) ){
            returnValue =  nil;
        }else if( !strcmp(returnType, @encode(id)) ){
            //如果返回值为对象，那么为变量赋值
            [invocation getReturnValue:&returnValue];
        }else{
            //如果返回值为普通类型NSInteger  BOOL
            //返回值长度
            NSUInteger length = [signature methodReturnLength];
            
            //根据长度申请内存
            void *buffer = (void *)malloc(length);
            
            //为变量赋值
            [invocation getReturnValue:buffer];
            if (strcmp(returnType, @encode(void))  == 0) {
                returnValue = nil;
            }else if (strcmp(returnType, @encode(int))  == 0) {
                returnValue = [NSNumber numberWithInt:*((int *)buffer)];
            }else if (strcmp(returnType, @encode(unsigned int))  == 0) {
                returnValue = [NSNumber numberWithUnsignedInt:*((unsigned int *)buffer)];
            }else if (strcmp(returnType, @encode(float)) == 0) {
                returnValue = [NSNumber numberWithFloat:*((float *)buffer)];
            }else if (strcmp(returnType, @encode(double))  == 0) {
                returnValue = [NSNumber numberWithDouble:*((double *)buffer)];
            }else if (strcmp(returnType, @encode(BOOL)) == 0) {
                returnValue = [NSNumber numberWithBool:*((BOOL *)buffer)];
            }else if(strcmp(returnType, @encode(NSInteger)) == 0){
                returnValue = [NSNumber numberWithInteger:*((NSInteger *)buffer)];
            }else if (strcmp(returnType, @encode(char)) == 0) {
                returnValue = [NSNumber numberWithChar:*((char *)buffer)];
            }else if (strcmp(returnType, @encode(unsigned char)) == 0) {
                returnValue = [NSNumber numberWithUnsignedChar:*((unsigned char *)buffer)];
            }else if (strcmp(returnType, @encode(short)) == 0) {
                returnValue = [NSNumber numberWithShort:*((short *)buffer)];
            }else if (strcmp(returnType, @encode(unsigned short)) == 0) {
                returnValue = [NSNumber numberWithUnsignedShort:*((unsigned short *)buffer)];
            }else if (strcmp(returnType, @encode(long)) == 0) {
                returnValue = [NSNumber numberWithUnsignedLong:*((long *)buffer)];
            }else if (strcmp(returnType, @encode(long long)) == 0) {
                returnValue = [NSNumber numberWithUnsignedLongLong:*((long long *)buffer)];
            }else if (strcmp(returnType, @encode(unsigned long long)) == 0) {
                returnValue = [NSNumber numberWithUnsignedLongLong:*((unsigned long long *)buffer)];
            }
            free(buffer);
        }
        return returnValue;
    }else {
        // 不存在这个方法，抛出异常
        @throw [NSException exceptionWithName:@"WQException" reason:@"不存在调用方法" userInfo:nil];
        return nil;
    }
}

- (void)func1 {
    NSLog(@"func1");
}
- (void)func2 {
    NSLog(@"func2");
}
@end
