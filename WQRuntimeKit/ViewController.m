//
//  ViewController.m
//  WQRuntimeKit
//
//  Created by admin on 17/3/2.
//  Copyright © 2017年 jolimark. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@protocol MyProtocolDelegate <NSObject>
@required
- (void)myFunction;
@end

@interface ViewController ()
@end

@implementation ViewController
- (void)viewDidLoad {
    Class objClass = [WQRuntimeKit createClassWithName:@"MyObject" superclass:[NSObject class]];
    [WQRuntimeKit addInstanceMethod:@"myFunc" toClass:objClass withImplement:@selector(func) fromClass:self.class];
    [WQRuntimeKit registClass:objClass];
    id obj = [[objClass alloc] init];
    if ([obj respondsToSelector:@selector(myFunc)]) {
        [obj performSelector:@selector(myFunc)];
    }
    NSLog(@"%@",[WQRuntimeKit methodNamesWithClass:objClass]);
}

- (void)func {
    NSLog(@"%@ -- %s",self.class,__func__);
}
@end
