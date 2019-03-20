//
//  UIColor+DDAdd.h
//  NewStar
//
//  Created by DD on 2017/2/11.
//  Copyright © 2017年 DD. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
//#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]



@interface UIColor (DDAdd)

/**
 //从十六进制字符串获取颜色，支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 @return UIColor
 */
+ (UIColor *)dd_colorWithHexString:(NSString *)color;

/**
 //从十六进制字符串获取颜色，支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 @param alpha 0.0f~1.0f
 @return UIColor
 */
+ (UIColor *)dd_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
/**
 app颜色
 */


#pragma mark App全局用到的参数

/**
 app全局的主题颜色

 @return UIColor
 */
+ (UIColor *)dd_ColorOfAppColor;

@end
