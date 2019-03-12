//
//  WQTestObj.h
//  WQRuntimeKit
//
//  Created by admin on 17/3/2.
//  Copyright © 2017年 jolimark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQTestObj : NSObject
@property (nonatomic, assign) int volume;

+ (void)func66;

- (int)func11:(int)i j:(NSNumber *)j;

- (void)func4:(int)value;
- (NSNumber *)func5;
- (void)func8:(NSString *)str;
- (NSInteger)func9:(int)value;
- (void)func10:(int)value0 value1:(int)value1;
- (id)performSelector:(SEL)aSelector
            arguments:(void **)arguments
                count:(int)count;
- (id)performSelector:(SEL)aSelector
        withArguments:(NSArray<id> *)arguments;

- (id)performSelector:(SEL)aSelector
            arguments:(void *)arguments,... NS_REQUIRES_NIL_TERMINATION;

- (void)func1;
- (void)func2;
@end
