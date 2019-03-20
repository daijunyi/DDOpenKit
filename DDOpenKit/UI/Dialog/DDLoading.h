//
//  DDLoading.h
//  YunTaiXin
//
//  Created by 戴俊毅 on 2018/12/20.
//  Copyright © 2018 DD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDLoading : NSObject

+ (instancetype)shareInstance;

- (void)showLoaddingWithText:(NSString *)text withDalayTime:(NSInteger)time;

- (void)hiddenLoadding;
/**是否正在loadding*/
@property (nonatomic,assign)BOOL isLoadding;
/**设置不可触摸*/
@property (assign,nonatomic)BOOL isCannotTouch;

- (void)cancelDelayLoad;

@end

NS_ASSUME_NONNULL_END
