//
//  UIButton+Customise.h
//  LaiCai
//
//  Created by SmartMin on 15-8-10.
//  Copyright (c) 2015年 LaiCai. All rights reserved.
//
// 自定义按钮
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleTop,                   /**< image在上，label在下*/
    ButtonEdgeInsetsStyleLeft,                  /**< image在左，label在右*/
    ButtonEdgeInsetsStyleBottom,                /**< image在下，label在上*/
    ButtonEdgeInsetsStyleRight                  /**< image在右，label在左*/
};


@interface UIButton (Customise)

- (void) buttonWithBlock:(void(^)(UIButton *button))buttonClickBlock;
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

@end
