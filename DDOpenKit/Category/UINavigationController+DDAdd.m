//
//  UINavigationController+DDAdd.m
//  KaiGua
//
//  Created by DD on 2017/9/6.
//  Copyright © 2017年 戴俊毅. All rights reserved.
//

#import "UINavigationController+DDAdd.h"

@implementation UINavigationController (DDAdd)

- (void)dd_pushViewControllerByDownWithController:(UIViewController *)controller{
    CATransition *transition = [CATransition new];
    transition.duration = 0.3;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [self pushViewController:controller animated:false];
    [self.view.layer addAnimation:transition forKey:nil];
}

- (void)dd_popViewControllerAnimatedDown{
    CATransition *transition = [CATransition new];
    transition.duration = 0.3;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [self popViewControllerAnimated:false];
    [self.view.layer addAnimation:transition forKey:nil];
}

- (void)dd_popViewControllerAnimatedDownWithTargetController:(UIViewController *)target{
    CATransition *transition = [CATransition new];
    transition.duration = 0.3;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [self popToViewController:target animated:false];
    [self.view.layer addAnimation:transition forKey:nil];
}

@end
