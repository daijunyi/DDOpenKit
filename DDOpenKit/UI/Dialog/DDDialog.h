//
//  DDDialog.h
//  NewStar
//
//  Created by DD on 2017/2/15.
//  Copyright © 2017年 DD. All rights reserved.
//

#import <Foundation/Foundation.h>

// 过期提醒
#define DDDialogDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

@interface DDDialog : NSObject

+(void)HUDWithText:(NSString *)text DDDialogDeprecated("该方法已经过期 请使用text方法代替");
+ (void)text:(NSString *)text;

+(void)HUDWithText:(NSString *)text withTime:(float)time DDDialogDeprecated("该方法已经过期 请使用text withTime方法代替");
+ (void)text:(NSString *)text withTime:(float)time;

+(void)LoadingHUDWithText:(NSString *)text DDDialogDeprecated("该方法已经过期 请使用loadWithText方法代替");
+(void)loadWithText:(NSString *)text;
/**阻挡当前界面 触摸*/
+ (void)loadCannotTouchWithText:(NSString *)text;
/**延迟显示*/
+ (void)LoadingDefaultDelayShowHUDWithText:(NSString *)text DDDialogDeprecated("该方法已经过期 请使用loadDelayWithText方法代替");
+(void)loadDelayWithText:(NSString *)text;

+(void)LoadingHUDDismiss DDDialogDeprecated("该方法已经过期 请使用dismiss方法代替");
+(void)dismiss;

+ (BOOL)isLoadding;
///**
// 初始化弹框样式
// */
//+ (void)setUpParams;
@end
