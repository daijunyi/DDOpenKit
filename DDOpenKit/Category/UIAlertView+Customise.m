//
//  UIAlertView+Customise.m
//  LaiCai
//
//  Created by SmartMin on 15-8-10.
//  Copyright (c) 2015年 LaiCai. All rights reserved.
//

#import "UIAlertView+Customise.h"
#import <objc/runtime.h>

static char *alertViewCallBaclBlockKey;

@implementation UIAlertView (Customise)


+(instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)msg buttonTitles:(NSArray *)titleArr callBlock:(void (^)(UIAlertView *, NSInteger))callBaclBlock{
    NSInteger count = titleArr.count;
    NSString *cancelTitle = nil;
    NSString *otherTitle1 = nil;
    NSString *otherTitle2 = nil;
    switch (count) {
        case 1:{
            cancelTitle = [titleArr objectAtIndex:0];
            break;
        }
        case 2:{
            cancelTitle = [titleArr objectAtIndex:0];
            otherTitle1 = [titleArr objectAtIndex:1];
            break;
        }
        case 3:{
            cancelTitle = [titleArr objectAtIndex:0];
            otherTitle1 = [titleArr objectAtIndex:1];
            otherTitle2 = [titleArr objectAtIndex:2];
            break;
        }
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle1, otherTitle2, nil];
    if (callBaclBlock){
        objc_setAssociatedObject(alertView, &alertViewCallBaclBlockKey, callBaclBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    alertView.delegate = alertView;
    return alertView;
}

-(UITextField *)nameTextField{
    return [self textFieldAtIndex:0];
}

-(UITextField *)passwordTextField{
    return [self textFieldAtIndex:1];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    alertView.delegate = nil;
    void (^callbackBlock) (UIAlertView *alertView, NSInteger buttonIndex) = objc_getAssociatedObject(alertView, &alertViewCallBaclBlockKey);
    
    if (callbackBlock) {
        callbackBlock(alertView, buttonIndex);
    }
}


@end
