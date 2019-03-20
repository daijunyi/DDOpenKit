//
//  DDViewController.h
//  YunTaiXin
//
//  Created by DD on 2018/11/13.
//  Copyright © 2018 DD. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DDBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDViewController : UIViewController
//取消左边侧滑
@property (nonatomic,assign)BOOL cancelLeftTouch;

- (instancetype)initFromNib;

+ (instancetype)newFromNib;

- (void)onViewDidLoadWithBlock:(void(^)(id viewController))block;

#pragma mark-  删除页面中的一些页面
- (void)removeController:(NSArray<Class> *)classs;

@end

NS_ASSUME_NONNULL_END
