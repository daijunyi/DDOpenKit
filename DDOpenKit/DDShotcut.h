//
//  DDShotcut.h
//  YunTaiXin
//
//  Created by DD on 2018/11/13.
//  Copyright © 2018 DD. All rights reserved.
//

#ifndef DDShotcut_h
#define DDShotcut_h

#define dd_RGB(r, g, b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define dd_colorWithHexString(str)  [UIColor dd_colorWithHexString:str]


#define dd_appBackGroudColor dd_RGB(249,249,249)
#define dd_appBlueColor dd_colorWithHexString(@"347fae")
#define dd_appYellowColor dd_colorWithHexString(@"ffc200")

#define dd_weaktypf(var)   __weak typeof(var) weakSelf = var
#define dd_weakObj(type)  __weak typeof(type) weak##type = type

#define dd_strongObj(type)  __strong typeof(type) strong##type = type;
#define dd_strongtypf(var) __strong typeof(var) strongSelf = var

#define dd_window [UIApplication sharedApplication].keyWindow

#define dd_StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define dd_SystemNavHeight 44.0

#define dd_navigationHeight (dd_StatusBarHeight+dd_SystemNavHeight)

#define dd_bottomBarSpace [UIDevice dd_IphoneXBottomSpace]

#define dd_float(value) [UIFont AppFloatFromFloat:value]
#define dd_float_px(value) [UIFont AppFloatFromPx:value]
#define dd_font_px(value) [UIFont AppFontFromPx:value]

#define IS_Iphone4 [UIDevice dd_Iphone4]
#define IS_Iphone5 [UIDevice dd_Iphone5]
#define IS_Iphone6 [UIDevice dd_Iphone6]
#define IS_Iphone6p [UIDevice dd_Iphone6p]
#define IS_IphoneX [UIDevice dd_IphoneX]

#define IOS_Version [UIDevice currentDevice].systemVersion.floatValue
#define IS_IOS7_LATER   ([UIDevice currentDevice].systemVersion.floatValue > 6.99)
#define IS_IOS8_LATER   ([UIDevice currentDevice].systemVersion.floatValue > 7.99)
#define IS_IOS9_LATER   ([UIDevice currentDevice].systemVersion.floatValue > 8.99)
#define IS_IOS10_LATER   ([UIDevice currentDevice].systemVersion.floatValue > 9.99)
#define IS_IOS11_LATER   ([UIDevice currentDevice].systemVersion.floatValue > 10.99)

#ifdef DEBUG
//调试状态
#define Log(...) NSLog(__VA_ARGS__)
//发布状态
#else
#define Log(...)
#endif

#ifdef DEBUG
//调试状态
#define WarnDialogFlag false
//发布状态
#else
#define WarnDialogFlag true
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

#define canLoadOneFlagWithString(value) [DDTool canLoadOneFlagWithString:value]

//app名字
#define kInfoDict [NSBundle mainBundle].localizedInfoDictionary ?: [NSBundle mainBundle].infoDictionary
#define kAPPName [kInfoDict valueForKey:@"CFBundleDisplayName"] ?: [kInfoDict valueForKey:@"CFBundleName"]


#endif /* DDShotcut_h */
