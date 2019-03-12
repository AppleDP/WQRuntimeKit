//
//  ViewController.m
//  WQRuntimeKit
//
//  Created by admin on 17/3/2.
//  Copyright © 2017年 jolimark. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+WQViewController.h"
#import "WQTestObj.h"
#import "WQObj.h"
#import <objc/message.h>

@interface SecondClass : NSObject
- (void)noThisMethod:(NSString *)value;
- (void)func3;
@end

@implementation SecondClass
- (void)noThisMethod:(NSString *)value {
    NSLog(@"SecondClass中的方法实现%@", value);
}
- (void)func3 {
    NSLog(@"function 3");
}
@end

@interface ViewController ()
<
    NSCopying,
    UITableViewDelegate
>
{
    
    IMP m1IMP;
@public
    dispatch_queue_t queue;
@private
    NSObject *obj1;
@protected
    NSObject *obj2;
}
@property (nonatomic, weak) UIView *wqView;
@property (nonatomic, strong) WQTestObj *obj;
@property (nonatomic, assign) BOOL result;
@property (nonatomic, copy) NSString *str0;

- (void)func1;
- (void)func2;
@end

@implementation ViewController
- (void)viewDidLoad {
//    [super viewDidLoad];
//    Ivar _resultIvar = class_getInstanceVariable([self class], "_result");
//    object_setIvar(self, _resultIvar, @1);
//    NSLog(@"%@",object_getIvar(self, _resultIvar));
//    NSLog(@"%d",self.result);
//    NSLog(@"%d",_result);
    
    WQTestObj *obj1 = [[WQTestObj alloc] init];
    WQTestObj *obj2 = [[WQTestObj alloc] init];
    [WQRuntimeKit exchangeInstanceMethodForClass:[WQTestObj class] methodFirst:@selector(func1) methodSecond:@selector(func2)];
    [obj2 func1];
    [obj1 func1];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//}
//
//- (void)func8:(NSString *)str {
//    NSLog(@"func 8");
//}
//
//- (void)func2 {
//    // 用 func1 的函数 IMP 指针调用原 func1 函数
//    ((void(*)(void))m1IMP)();
//    NSLog(@"func2");
//}
//
//- (void)func1 {
//    NSLog(@"func1");
//}
@end
