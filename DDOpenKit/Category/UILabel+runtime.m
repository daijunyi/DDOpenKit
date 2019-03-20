//
//  UILabel+runtime.m
//  YunTaiXin
//
//  Created by DD on 2018/11/17.
//  Copyright © 2018 DD. All rights reserved.
//

#import "UILabel+runtime.h"
#import <objc/runtime.h>

@implementation UILabel (runtime)

//+ (void)load{
//    Method method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
//    Method method2 = class_getInstanceMethod([self class], @selector(runtimeInitWithCoder:));
//    method_exchangeImplementations(method1, method2);
//}
//
//- (instancetype)runtimeInitWithCoder:(NSCoder *)aDecoder{
//    [self runtimeInitWithCoder:aDecoder];
//    if (self) {
//        NSString *familyName = self.font.familyName;
//        self.font = [UIFont fontWithName:familyName size:[UIFont AppFloatFromFloat:self.font.pointSize]];
//    }
//    return self;
//}

@end
