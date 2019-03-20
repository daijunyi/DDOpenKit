//
//  UIButton+tuntime.m
//  YunTaiXin
//
//  Created by DD on 2018/11/17.
//  Copyright © 2018 DD. All rights reserved.
//

#import "UIButton+runtime.h"
#import <objc/runtime.h>
#import "UIFont+DDAdd.h"

@implementation UIButton (runtime)
//+ (void)load{
//    Method method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
//    Method method2 = class_getInstanceMethod([self class], @selector(runtimeInitWithCoder:));
//    method_exchangeImplementations(method1, method2);
//}
//
//- (instancetype)runtimeInitWithCoder:(NSCoder *)aDecoder{
//    [self runtimeInitWithCoder:aDecoder];
//    if (self) {
//        UIFont *font = self.titleLabel.font;
//        NSString *familyName = font.familyName;
//        self.titleLabel.font = [UIFont fontWithName:familyName size:[UIFont AppFloatFromFloat:font.pointSize]];
//    }
//    return self;
//}
@end
