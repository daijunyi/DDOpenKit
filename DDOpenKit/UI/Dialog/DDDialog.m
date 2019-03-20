//
//  DDDialog.m
//  NewStar
//
//  Created by DD on 2017/2/15.
//  Copyright © 2017年 DD. All rights reserved.
//

#import "DDDialog.h"
#import "UIColor+DDAdd.h"
#import "DDDialogManager.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "DDLoading.h"

@implementation DDDialog

+(void)HUDWithText:(NSString *)text andTime:(float)time andView:(UIView *)View{
    [[DDLoading shareInstance] cancelDelayLoad];
    [MBProgressHUD hideHUDForView:View animated:NO];
    if (View == nil) {
        View = [UIApplication sharedApplication].delegate.window;
    }
    if (View == nil) {
        View = [UIView new];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:View animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.label.font = [UIFont fontWithName:@"Helvetica-thin" size:18.f];
    hud.userInteractionEnabled = false;
    [hud hideAnimated:YES afterDelay:time];
}


+ (void)text:(NSString *)text{
    [DDDialog HUDWithText:text andTime:2 andView:[UIApplication sharedApplication].keyWindow];
}


+(void)text:(NSString *)text withTime:(float)time{
    [DDDialog HUDWithText:text andTime:time andView:[UIApplication sharedApplication].keyWindow];
}

+ (void)loadWithText:(NSString *)text{
    [DDLoading shareInstance].isCannotTouch = true;
    [[DDLoading shareInstance] showLoaddingWithText:text withDalayTime:0];
}

+ (void)loadCannotTouchWithText:(NSString *)text{
    [[DDLoading shareInstance] showLoaddingWithText:text withDalayTime:0];
    [DDLoading shareInstance].isCannotTouch = false;
}

+(void)loadDelayWithText:(NSString *)text{
    [DDLoading shareInstance].isCannotTouch = true;
    [[DDLoading shareInstance] showLoaddingWithText:text withDalayTime:1.2];
}

+ (void)dismiss{
    [[DDLoading shareInstance] hiddenLoadding];
}

+(void)HUDWithText:(NSString *)text{
    [self text:text];
}

+(void)HUDWithText:(NSString *)text withTime:(float)time{
    [self text:text withTime:time];
}

+(void)LoadingHUDDismiss{
    [self dismiss];
}

+ (void)LoadingHUDWithText:(NSString *)text{
    [self loadWithText:text];
}

+ (void)LoadingDefaultDelayShowHUDWithText:(NSString *)text{
    [self loadDelayWithText:text];
}

+ (BOOL)isLoadding{
    return [DDLoading shareInstance].isLoadding;
}


@end
