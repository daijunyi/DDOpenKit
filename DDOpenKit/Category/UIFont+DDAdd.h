//
//  UIFont+DDAdd.h
//  KaiGua
//
//  Created by DD on 2017/5/5.
//  Copyright © 2017年 戴俊毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (DDAdd)

+ (UIFont *)AppFontOfSize:(CGFloat)size;

+ (UIFont *)AppFontOfSize_bold:(CGFloat)size;

+ (CGFloat)AppFloatFromPx:(CGFloat)px;

+ (UIFont *)AppFontFromPx:(CGFloat)px;

+ (UIFont *)AppFontFromPx_bold:(CGFloat)px;

+ (CGFloat)AppFloatFromFloat:(CGFloat)value;
/**自定义字体*/
+ (UIFont *)HappyZcoolWithSize:(CGFloat)value;
/**打印所有字体文件名称*/
+ (void)printAllFontFamilyname;

@end
