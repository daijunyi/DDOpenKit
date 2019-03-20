//
//  UIDevice+DDAdd.h
//  NewStar
//
//  Created by DD on 2017/2/15.
//  Copyright © 2017年 DD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (DDAdd)

/**
 获取设备id

 @return 返回设备id
 */
+ (NSString *)dd_deviceId_UUID;

+ (BOOL)dd_IphoneX;

+ (BOOL)dd_Iphone4;

+ (BOOL)dd_Iphone5;

+ (BOOL)dd_Iphone6p;

+ (BOOL)dd_Iphone6;

+ (CGFloat)dd_IphoneXBottomSpace;

+ (NSString *)appName;

+ (NSString *)versionName;

@end
