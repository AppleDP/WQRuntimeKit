//
//  WQRuntimeKit.m
//  WQRuntimeKit
//
//  Created by admin on 17/3/2.
//  Copyright © 2017年 jolimark. All rights reserved.
//

#import "WQRuntimeKit.h"
#import <objc/runtime.h>

@implementation WQRuntimeKit
+ (NSString *)classNameWithClass:(Class)mClass {
    NSString *name;
    const char *cName = class_getName(mClass);
    name = [NSString stringWithUTF8String:cName];
    return name;
}

+ (Class _Nullable)classWithName:(NSString *)name {
    return objc_getClass(name.UTF8String);
}

+ (NSString *)protocolNameWithProtocol:(Protocol *)protocol {
    return [NSString stringWithUTF8String:protocol_getName(protocol)];
}

+ (Protocol * _Nullable)protocolWithName:(NSString *)name {
    return objc_getProtocol(name.UTF8String);
}

+ (NSArray<NSString *> *)methodNamesWithClass:(Class)mClass {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(mClass, &count);
    NSMutableArray *names = [[NSMutableArray alloc] initWithCapacity:count];
    for (unsigned int index = 0; index < count; index ++) {
        Method method = methodList[index];
        SEL methodSel = method_getName(method);
        [names addObject:NSStringFromSelector(methodSel)];
    }
    return [names copy];
}

+ (NSArray<NSString *> *)methodNamesWithProtocol:(Protocol *)procotol {
    uint instanceRequestMethodsCount = 0;
    uint instanceOptionMethodsCount = 0;
    uint classRequestMethodsCount = 0;
    uint classOptionMethodsCount = 0;
    struct objc_method_description *instanceRequestMethods = protocol_copyMethodDescriptionList(procotol, YES, YES, &instanceRequestMethodsCount);
    struct objc_method_description *instanceOptionMethods = protocol_copyMethodDescriptionList(procotol, NO, YES, &instanceOptionMethodsCount);
    struct objc_method_description *classRequestMethods = protocol_copyMethodDescriptionList(procotol, YES, NO, &classRequestMethodsCount);
    struct objc_method_description *classOptionMethods = protocol_copyMethodDescriptionList(procotol, NO, NO, &classOptionMethodsCount);
    uint count = instanceRequestMethodsCount + instanceOptionMethodsCount + classRequestMethodsCount + classOptionMethodsCount;
    NSMutableArray *names = [[NSMutableArray alloc] initWithCapacity:count];
    for (int idx = 0; idx < instanceRequestMethodsCount; idx++) {
        struct objc_method_description method = instanceRequestMethods[idx];
        [names addObject:NSStringFromSelector(method.name)];
    }
    for (int idx = 0; idx < instanceOptionMethodsCount; idx++) {
        struct objc_method_description method = instanceOptionMethods[idx];
        [names addObject:NSStringFromSelector(method.name)];
    }
    for (int idx = 0; idx < classRequestMethodsCount; idx++) {
        struct objc_method_description method = classRequestMethods[idx];
        [names addObject:NSStringFromSelector(method.name)];
    }
    for (int idx = 0; idx < classOptionMethodsCount; idx++) {
        struct objc_method_description method = classOptionMethods[idx];
        [names addObject:NSStringFromSelector(method.name)];
    }
    return [names copy];
}

+ (NSArray<NSDictionary <NSString *, NSString *> *> *)ivarNamesWithClass:(Class)mClass {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(mClass, &count);
    NSMutableArray *message = [[NSMutableArray alloc] initWithCapacity:count];
    for (unsigned int index = 0; index < count; index ++) {
        NSMutableDictionary *ivarDic = [[NSMutableDictionary alloc] initWithCapacity:2];
        Ivar ivar = ivarList[index];
        const char *cName = ivar_getName(ivar);
        const char *cType = ivar_getTypeEncoding(ivar);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSString *type = [NSString stringWithUTF8String:cType];
        ivarDic[@"name"] = name;
        ivarDic[@"type"] = type;
        [message addObject:ivarDic];
    }
    free(ivarList);
    return message;
}

+ (NSArray<NSDictionary <NSString *, NSString *> *> *)propertyNamesWithClass:(Class)mClass {
    unsigned int count = 0;
    objc_property_t *propertys = class_copyPropertyList(mClass, &count);
    NSMutableArray *message = [[NSMutableArray alloc] initWithCapacity:count];
    for (unsigned index = 0; index < count; index ++) {
        NSMutableDictionary *propertyDic = [[NSMutableDictionary alloc] initWithCapacity:2];
        const char *cName = property_getName(propertys[index]);
        const char *cAttribute = property_getAttributes(propertys[index]);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSString *attribute = [NSString stringWithUTF8String:cAttribute];
        propertyDic[@"name"] = name;
        propertyDic[@"attribute"] = attribute;
        [message addObject:propertyDic];
    }
    free(propertys);
    return message;
}

+ (NSArray<NSString *> *)protocolNamesWithClass:(Class)mClass {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(mClass, &count);
    NSMutableArray *names = [[NSMutableArray alloc] initWithCapacity:count];
    for (unsigned int index = 0; index < count; index ++) {
        Protocol *protocol = protocolList[index];
        const char *cName = protocol_getName(protocol);
        [names addObject:[NSString stringWithUTF8String:cName]];
    }
    free(protocolList);
    return names;
}

+ (void)addInstanceMethodForClass:(Class)mClass
                       methodName:(SEL)name
                        implement:(SEL)implement {
    [self addInstanceMethod:NSStringFromSelector(name) toClass:mClass withImplement:implement fromClass:mClass];
}

+ (BOOL)addInstanceMethod:(NSString *)name
                  toClass:(Class)tCls
            withImplement:(SEL)impSel
                fromClass:(Class)fCls {
    Method method = class_getInstanceMethod(fCls, impSel);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    return class_addMethod(tCls, NSSelectorFromString(name), methodIMP, types);
}

+ (void)addClassMethodForClass:(Class)mClass
                    methodName:(SEL)name
                     implement:(SEL)implement {
    [self addClassMethod:NSStringFromSelector(name) toClass:mClass withImplement:implement fromClass:mClass];
}

+ (BOOL)addClassMethod:(NSString *)name
               toClass:(Class)tCls
         withImplement:(SEL)impSel
             fromClass:(Class)fCls {
    Method method = class_getClassMethod(fCls, impSel);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    return class_addMethod(tCls, NSSelectorFromString(name), methodIMP, types);
}

+ (void)exchangeInstanceMethodForClass:(Class)mClass
                           methodFirst:(SEL)method1
                          methodSecond:(SEL)method2 {
    Method m1 = class_getInstanceMethod(mClass, method1);
    Method m2 = class_getInstanceMethod(mClass, method2);
    method_exchangeImplementations(m1, m2);
}

+ (void)exchangeClassMethodForClass:(Class)mClass
                        methodFirst:(SEL)method1
                       methodSecond:(SEL)method2 {
    Method m1 = class_getClassMethod(mClass, method1);
    Method m2 = class_getClassMethod(mClass, method2);
    method_exchangeImplementations(m1, m2);
}

+ (void)changeInstanceMethodForClass:(Class)mClass
                              method:(SEL)method1
                           implement:(SEL)method2 {
    Method m1 = class_getInstanceMethod(mClass, method1);
    Method m2 = class_getInstanceMethod(mClass, method2);
    IMP m2IMP = method_getImplementation(m2);
    method_setImplementation(m1, m2IMP);
}

+ (void)changeClassMethodForClass:(Class)mClass
                           method:(SEL)method1
                        implement:(SEL)method2 {
    Method m1 = class_getClassMethod(mClass, method1);
    Method m2 = class_getClassMethod(mClass, method2);
    IMP m2IMP = method_getImplementation(m2);
    method_setImplementation(m1, m2IMP);
}

+ (NSArray<NSString *> *)getRegistClass {
    uint count;
    Class *clss = objc_copyClassList(&count);
    NSMutableArray<NSString *> *classes = [[NSMutableArray alloc] initWithCapacity:count];
    for (int idx = 0; idx < count; idx++) {
        Class cls = clss[idx];
        [classes addObject:[NSString stringWithUTF8String:class_getName(cls)]];
    }
    free(clss);
    return [classes copy];
}

+ (Class)createClassWithName:(NSString *)name
                  superclass:(Class)superclass {
    Class c = NSClassFromString(name);
    if (c) {
        // 已经生成前类
        @throw [NSException exceptionWithName:@"WQRuntimeKeyException" reason:@"当前类已创建" userInfo:nil];
        return c;
    }
    c = objc_allocateClassPair(superclass, name.UTF8String, 0);
    return c;
}

+ (void)registClass:(Class)cls {
    objc_registerClassPair(cls);
}

+ (BOOL)addIvarToClass:(Class)cls
                  name:(NSString *)name
                  type:(const char *)type {
    size_t size = 0;
    if(!strcmp(type, @encode(void))){
        size = sizeof(void);
    }else if(!strcmp(type, @encode(id))){
        size = sizeof(id);
    }else{
        if (strcmp(type, @encode(void))  == 0) {
            size = sizeof(void);
        }else if (strcmp(type, @encode(int))  == 0) {
            size = sizeof(int);
        }else if (strcmp(type, @encode(unsigned int))  == 0) {
            size = sizeof(unsigned int);
        }else if (strcmp(type, @encode(float)) == 0) {
            size = sizeof(float);
        }else if (strcmp(type, @encode(double))  == 0) {
            size = sizeof(double);
        }else if (strcmp(type, @encode(BOOL)) == 0) {
            size = sizeof(BOOL);
        }else if(strcmp(type, @encode(NSInteger)) == 0){
            size = sizeof(NSInteger);
        }else if (strcmp(type, @encode(char)) == 0) {
            size = sizeof(char);
        }else if (strcmp(type, @encode(unsigned char)) == 0) {
            size = sizeof(unsigned char);
        }else if (strcmp(type, @encode(short)) == 0) {
            size = sizeof(short);
        }else if (strcmp(type, @encode(unsigned short)) == 0) {
            size = sizeof(unsigned short);
        }else if (strcmp(type, @encode(long)) == 0) {
            size = sizeof(long);
        }else if (strcmp(type, @encode(long long)) == 0) {
            size = sizeof(long long);
        }else if (strcmp(type, @encode(unsigned long long)) == 0) {
            size = sizeof(unsigned long long);
        }
    }
    return class_addIvar(cls, name.UTF8String, size, log2(size), type);
}

+ (BOOL)addProtocolToClass:(Class)cls
                  protocol:(Protocol *)protocol {
    if (class_conformsToProtocol(cls, protocol)) {
        @throw [NSException exceptionWithName:@"WQRuntimeKeyException" reason:@"当前类已经遵守协议" userInfo:nil];
        return YES;
    }
    return class_addProtocol(cls, protocol);
}

+ (Protocol *)createProtocol:(NSString *)name {
    return objc_allocateProtocol(name.UTF8String);
}

+ (void)protocol:(Protocol *)protocol
     addProtocol:(Protocol *)addProtocol {
    protocol_addProtocol(protocol, addProtocol);
}

+ (void)addMethodToProtocol:(Protocol *)protocol
                        sel:(SEL)sel
                       type:(const char * _Nullable)types
                  isRequestMethod:(BOOL)isRequest
           isInstanceMethod:(BOOL)isInstance {
    protocol_addMethodDescription(protocol, sel, types, isRequest, isInstance);
}

+ (void)registProtocol:(Protocol *)protocol {
    objc_registerProtocol(protocol);
}

+ (BOOL)protocol:(Protocol *)protocol
conformsProtocol:(Protocol *)conProtocol {
    return protocol_conformsToProtocol(protocol, conProtocol);
}
@end
