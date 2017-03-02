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
@public
    dispatch_queue_t queue;
@private
    NSObject *obj1;
@protected
    NSObject *obj2;
}
@property (nonatomic, weak) UIView *wqView;
@property (nonatomic, strong) WQTestObj *obj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",[WQRuntimeKit protocolNamesWithClass:[self class]]);
//    [self func1];
//    [self func2];
//    [WQRuntimeKit exchangeMethodForClass:[self class]
//                             methodFirst:@selector(func1)
//                            methodSecond:@selector(func2)];
//    [self func1];
//    [self func2];
    self.obj = [WQTestObj new];
    [self.obj performSelector:@selector(func4)];
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    [WQRuntimeKit addMethodForClass:[self class]
//                         methodName:sel
//                          implement:@selector(func3)];
//    return YES;
//}

- (void)func3 {
    NSLog(@"function 3");
}

- (void)func1 {
    NSLog(@"func1");
}
@end






