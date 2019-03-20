//
//  UIActionSheet+Customise.h
//  LaiCai
//
//  Created by SmartMin on 15-8-10.
//  Copyright (c) 2015年 LaiCai. All rights reserved.
//
// 自定义actionSheet

#import <UIKit/UIKit.h>

@interface UIActionSheet (Customise)<UIActionSheetDelegate>

+ (instancetype)actionSheetWithTitle:(NSString *)title buttonTitles:(NSArray *)titleArray callback:(void(^)(UIActionSheet *actionSheet,NSInteger buttonIndex))callbackBlock;

@end
