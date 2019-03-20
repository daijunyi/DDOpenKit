//
//  DDLoading.m
//  YunTaiXin
//
//  Created by 戴俊毅 on 2018/12/20.
//  Copyright © 2018 DD. All rights reserved.
//

#import "DDLoading.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface DDLoading ()

@property (weak,nonatomic)MBProgressHUD *loadView;

@end

@implementation DDLoading

+ (instancetype)shareInstance{
    static DDLoading *sharedMyManager = nil;
    
    static dispatch_once_t DDLoading;
    
    dispatch_once(&DDLoading, ^{
        sharedMyManager = [[self alloc] init];
        //从数据库加载用户信息
    });
    
    return sharedMyManager;
}

- (void)showLoaddingWithText:(NSString *)text{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    if (view == nil) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    if (view == nil) {
        view = [UIView new];
    }
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = !self.isCannotTouch;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    self.loadView = hud;
}

- (void)setIsCannotTouch:(BOOL)isCannotTouch{
    _isCannotTouch = isCannotTouch;
    self.loadView.userInteractionEnabled = !isCannotTouch;
}

- (void)showLoaddingWithText:(NSString *)text withDalayTime:(NSInteger)time{
    self.isLoadding = true;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (time == 0) {
        [self showLoaddingWithText:text];
        return;
    }
    [self performSelector:@selector(showLoaddingWithText:) withObject:text afterDelay:time];
}

- (void)hiddenLoadding{
    self.isLoadding = false;
    [self performSelector:@selector(cancelDelayLoad) withObject:nil afterDelay:0.4];
}


- (void)cancelDelayLoad{
    self.isLoadding = false;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:true];
}

@end
