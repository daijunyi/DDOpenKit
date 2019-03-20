//
//  UINavigationController+DDAdd.h
//  KaiGua
//
//  Created by DD on 2017/9/6.
//  Copyright © 2017年 戴俊毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (DDAdd)

- (void)dd_pushViewControllerByDownWithController:(UIViewController *)controller;

- (void)dd_popViewControllerAnimatedDown;

- (void)dd_popViewControllerAnimatedDownWithTargetController:(UIViewController *)target;

@end
