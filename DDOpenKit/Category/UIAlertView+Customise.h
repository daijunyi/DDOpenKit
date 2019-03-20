//
//  UIAlertView+Customise.h
//  LaiCai
//
//  Created by SmartMin on 15-8-10.
//  Copyright (c) 2015年 LaiCai. All rights reserved.
//
// 自定义AlertView
#import <UIKit/UIKit.h>

@interface UIAlertView (Customise)

+(instancetype)alertViewWithTitle:(NSString *)title
                          message:(NSString *)msg
                     buttonTitles:(NSArray *)titleArr
                        callBlock:(void(^)(UIAlertView *alertView,NSInteger buttonIndex))callBaclBlock;

-(UITextField *)nameTextField;
-(UITextField *)passwordTextField;

@end
