//
//  CALayer+DDAdd.m
//  YunTaiXin
//
//  Created by 戴俊毅 on 2018/11/19.
//  Copyright © 2018 DD. All rights reserved.
//

#import "CALayer+DDAdd.h"

@implementation CALayer (DDAdd)

- (UIColor *)borderUIColor{
    if (self.borderColor == nil) {
        return nil;
    }else{
        return [[UIColor alloc] initWithCGColor:self.borderColor];
    }
}

- (void)setBorderUIColor:(UIColor *)borderUIColor{
    self.borderColor = borderUIColor.CGColor;
}

@end
