//
//  ViewController+WQViewController.m
//  WQRuntimeKit
//
//  Created by admin on 17/3/2.
//  Copyright © 2017年 jolimark. All rights reserved.
//

#import "ViewController+WQViewController.h"
#import <objc/runtime.h>


@implementation ViewController (WQViewController)
- (void)func2 {
    NSLog(@"func2");
}

static const void *str2Key = &str2Key;
- (void)setStr2:(NSString *)str2 {
    objc_setAssociatedObject(self,
                             str2Key,
                             str2,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)str2 {
    return objc_getAssociatedObject(self,
                                    str2Key);
}
@end
