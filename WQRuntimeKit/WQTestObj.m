//
//  WQTestObj.m
//  WQRuntimeKit
//
//  Created by admin on 17/3/2.
//  Copyright © 2017年 jolimark. All rights reserved.
//

#import "WQTestObj.h"
#import "WQRuntimeKit.h"

@implementation WQTestObj
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    [WQRuntimeKit addMethodForClass:[self class]
                         methodName:sel
                          implement:@selector(func)];
    return YES;
}

+ (void)func5 {
    NSLog(@"func5");
}

- (void)func {
    NSLog(@"Func");
}
@end
