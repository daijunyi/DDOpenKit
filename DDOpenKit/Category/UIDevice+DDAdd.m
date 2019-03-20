//
//  UIDevice+DDAdd.m
//  NewStar
//
//  Created by DD on 2017/2/15.
//  Copyright © 2017年 DD. All rights reserved.
//

#import "UIDevice+DDAdd.h"
#import <YYCategories/YYCategories.h>

@implementation UIDevice (DDAdd)

//获取DeviceId
+ (NSString *)dd_deviceId_UUID{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (BOOL)dd_IphoneX{
    BOOL iPhoneXSeries = NO;
    //不是手机设备的时候
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

+ (BOOL)dd_Iphone4{
    if (kScreenWidth == 320 && kScreenHeight == 480) {
        return true;
    }else{
        return false;
    }
}

+ (BOOL)dd_Iphone5{
    if (kScreenWidth == 320 && kScreenHeight == 568) {
        return true;
    }else{
        return false;
    }
}

+ (BOOL)dd_Iphone6{
    if (kScreenWidth == 375 && kScreenHeight == 667) {
        return true;
    }else{
        return false;
    }
}

+ (BOOL)dd_Iphone6p{
    if (kScreenWidth == 414 && kScreenHeight == 736) {
        return true;
    }else{
        return false;
    }
}

+ (CGFloat)dd_IphoneXBottomSpace{
    CGFloat adjust = 0;
    if (@available(iOS 11.0, *)) {
        
        //Account for possible notch
        
        UIEdgeInsets safeArea = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;
        
        adjust = safeArea.bottom;
        
    }
    return adjust;
}

+ (NSString *)appName{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)versionName{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}



@end
