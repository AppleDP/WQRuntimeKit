//
//  WQRuntimeKit.h
//  WQRuntimeKit
//
//  Created by admin on 17/3/2.
//  Copyright © 2017年 jolimark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface WQRuntimeKit : NSObject
/**
 * 获取类名
 *
 * @param class Class
 *
 * @return 类名
 */
+ (NSString *)classNameWithClass:(Class)mClass;

/**
 * 获取类
 *
 * @param name 类名
 */
+ (Class _Nullable)classWithName:(NSString *)name;

/**
 * 获取协议名
 *
 * @param 协议
 */
+ (NSString *)protocolNameWithProtocol:(Protocol *)protocol;

/**
 * 获取协议
 *
 * @param name 协议名
 */
+ (Protocol * _Nullable)protocolWithName:(NSString *)name;

/**
 * 获取该类 .m 文件中的所有方法名（包括分类 .m 文件中的方法）
 *
 * @param class Class
 *
 * @return 方法名数组
 */
+ (NSArray<NSString *> *)methodNamesWithClass:(Class)mClass;

/**
 * 获取协议中所有的方法
 *
 * @param procotol 协议
 *
 * @return 方法名数组
 */
+ (NSArray<NSString *> *)methodNamesWithProtocol:(Protocol *)procotol;

/**
 * 获取类的变量名（分类变量除外），属性 + 实例变量
 *
 * @param class Class
 *
 * @return 变量名及类型数组
 */
+ (NSArray<NSDictionary <NSString *, NSString *> *> *)ivarNamesWithClass:(Class)mClass;

/**
 * 获取类的属性名（包括分类属性）
 *
 * @param mClass Class
 *
 * @return 变量名及特性
 */
+ (NSArray<NSDictionary <NSString *, NSString *> *> *)propertyNamesWithClass:(Class)mClass;

/**
 * 获取遵循的协议名称（包括分类遵循的协议）
 *
 * @param mClass Class
 *
 * @return 遵循的协议
 */
+ (NSArray<NSString *> *)protocolNamesWithClass:(Class)mClass;

/**
 * 向类动态添加实例方法，如果类实例调用 name 方法，则实际上是调用 implement 方法
 *
 * @param mClass    Class
 * @param name      方法名
 * @param implement 方法具体实现
 */
+ (void)addInstanceMethodForClass:(Class)mClass
                       methodName:(SEL)name
                        implement:(SEL)implement DEPRECATED_MSG_ATTRIBUTE("方法已经废弃，请调用 -addInstanceMethod:toClass:withImplement:fromClass:");
/**
 * 向类动态添加实例方法
 *
 * @param name 方法名称
 * @param tCls 须要添加方法的动态类
 * @param impSel 方法的实现
 * @param fCls 方法实现所在类
 */
+ (BOOL)addInstanceMethod:(NSString *)name
                  toClass:(Class)tCls
            withImplement:(SEL)impSel
                fromClass:(Class)fCls;
/**
 * 向类动态添加类方法，如果类调用 name 方法，则实际上是调用 implement 方法
 *
 * @param mClass    Class
 * @param name      方法名
 * @param implement 方法具体实现
 */
+ (void)addClassMethodForClass:(Class)mClass
                    methodName:(SEL)name
                     implement:(SEL)implement DEPRECATED_MSG_ATTRIBUTE("方法已经废弃，请调用 -addClassMethod:toClass:withImplement:fromClass:");
/**
 * 向类动态添加类方法
 *
 * @param name 方法名称
 * @param tCls 须要添加方法的动态类
 * @param impSel 方法的实现
 * @param fCls 方法实现所在类
 */
+ (BOOL)addClassMethod:(NSString *)name
               toClass:(Class)tCls
         withImplement:(SEL)impSel
             fromClass:(Class)fCls;
/**
 * 交换两个实例方法，原调用 method1 处在交换后将调用 method2。反之原调用 method2 处将调用 method1
 *
 * @param mClass  Class
 * @param method1 方法1
 * @param method2 方法2
 */
+ (void)exchangeInstanceMethodForClass:(Class)mClass
                           methodFirst:(SEL)method1
                          methodSecond:(SEL)method2;
/**
 * 交换两个类方法，原调用 method1 处在交换后将调用 method2。反之原调用 method2 处将调用 method1
 *
 * @param mClass  Class
 * @param method1 方法1
 * @param method2 方法2
 */
+ (void)exchangeClassMethodForClass:(Class)mClass
                        methodFirst:(SEL)method1
                       methodSecond:(SEL)method2;
/**
 * 将 method1 实例方法的具体实现替换为 method2 实例方法。在调用 method1 时实际上调用 method2，调用 method2 时还是调用 method2
 *
 * @param mClass  Class
 * @param method1 方法1
 * @param method2 方法2
 */
+ (void)changeInstanceMethodForClass:(Class)mClass
                              method:(SEL)method1
                           implement:(SEL)method2;
/**
 * 将 method1 类方法的具体实现替换为 method2 类方法。在调用 method1 时实际上调用 method2，调用 method2 时还是调用 method2
 *
 * @param mClass  Class
 * @param method1 方法1
 * @param method2 方法2
 */
+ (void)changeClassMethodForClass:(Class)mClass
                           method:(SEL)method1
                        implement:(SEL)method2;
/**
 * 获取所有注册的类
 *
 * @return 返回注册类
 */
+ (NSArray<NSString *> *)getRegistClass;

/**
 * 创建类
 *
 * @param name 类名
 * @param superclass 继承
 */
+ (Class)createClassWithName:(NSString *)name
                  superclass:(Class)superclass;
/**
 * 注册当前类，将类注册到当前环境中
 *
 * @param cls 注册类
 */
+ (void)registClass:(Class)cls;

/**
 * 给类添加实例变量，添加后可以通过 -setValue:forKey: 赋值，-valueForKey: 取值
 *
 * @param cls 添加实例变量的类
 * @param name 变量名称
 * @param type 变量类型
 */
+ (BOOL)addIvarToClass:(Class)cls
                  name:(NSString *)name
                  type:(const char *)type;
/**
 * 添加遵守协议
 *
 * @param cls 遵守协议的类
 * @param protocol 协议
 */
+ (BOOL)addProtocolToClass:(Class)cls
                  protocol:(Protocol *)protocol;
/**
 * 获取
 */
/**
 * 创建协议
 *
 * @param name 协议名
 */
+ (Protocol *)createProtocol:(NSString *)name;

/**
 * 添加协议到另一个协议
 *
 * @param protocol 被添加协议
 * @param addProtocol 添加协议
 */
+ (void)protocol:(Protocol *)protocol
     addProtocol:(Protocol *)addProtocol;

/**
 * 协议添加方法
 *
 * @param protocol 添加方法的协议
 * @param sel 协议实现方法
 * @param types 变量类型
 * @param isRequest YES: 必需实现方法 NO: 可选实现方法
 * @param isInstance YES: 实例方法 NO: 类方法
 */
+ (void)addMethodToProtocol:(Protocol *)protocol
                        sel:(SEL)sel
                       type:(const char * _Nullable)types
            isRequestMethod:(BOOL)isRequest
           isInstanceMethod:(BOOL)isInstance;
/**
 * 注册协议
 *
 * @param protocol 注册协议
 */
+ (void)registProtocol:(Protocol *)protocol;

/**
 * 协议是否遵循协议
 *
 * @param protocol 协议
 * @param conProtocol 遵循协议
 *
 * @return protocol遵循conProtocol协议
 */
+ (BOOL)protocol:(Protocol *)protocol
conformsProtocol:(Protocol *)conProtocol;
@end
NS_ASSUME_NONNULL_END
