//
//  UIActionSheet+Customise.m
//  LaiCai
//
//  Created by SmartMin on 15-8-10.
//  Copyright (c) 2015年 LaiCai. All rights reserved.
//

#import "UIActionSheet+Customise.h"
#import <objc/runtime.h>

static char *ActionSheetCallBackBlockKey;
@implementation UIActionSheet (Customise)

+ (instancetype)actionSheetWithTitle:(NSString *)title buttonTitles:(NSArray *)titleArray callback:(void (^)(UIActionSheet *, NSInteger))callbackBlock{
    NSUInteger count = titleArray.count;
    NSString *cancelTitle = nil;
    NSString *otherTitle1 = nil;
    NSString *otherTitle2 = nil;
    NSString *otherTitle3 = nil;
    
    switch (count) {
        case 1:{
            cancelTitle = [titleArray objectAtIndex:0];
            break;
        }
        case 2:{
            cancelTitle = [titleArray objectAtIndex:0];
            otherTitle1 = [titleArray objectAtIndex:1];
            break;
        }
        case 3:{
            cancelTitle = [titleArray objectAtIndex:0];
            otherTitle1 = [titleArray objectAtIndex:1];
            otherTitle2 = [titleArray objectAtIndex:2];
            break;
        }
        case 4:{
            cancelTitle = [titleArray objectAtIndex:0];
            otherTitle1 = [titleArray objectAtIndex:1];
            otherTitle2 = [titleArray objectAtIndex:2];
            otherTitle3 = [titleArray objectAtIndex:3];
            break;
        }
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelTitle destructiveButtonTitle:nil otherButtonTitles: otherTitle1,otherTitle2,otherTitle3,nil];
    
    if (callbackBlock){
        objc_setAssociatedObject(actionSheet, &ActionSheetCallBackBlockKey, callbackBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    actionSheet.delegate = actionSheet;
    return actionSheet;
    
}




- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    actionSheet.delegate = nil;
    void (^callbackBlock)(UIActionSheet *actionSheet,NSInteger buttonIndex) = objc_getAssociatedObject(actionSheet, &ActionSheetCallBackBlockKey);
    if (callbackBlock){
        callbackBlock(actionSheet,buttonIndex);
    }
}
@end
