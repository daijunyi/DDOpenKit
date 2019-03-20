//
//  Tool.h
//  YunTaiXin
//
//  Created by 戴俊毅 on 2018/11/19.
//  Copyright © 2018 DD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDTool : NSObject

#pragma mark - 手机号码验证
+ (BOOL)checkIsPhoneNumber:(NSString *)mobile;

/**
 *将周数字符串转化为显示的字符串
 **/
+ (NSString *)transWeeksString:(NSString *)OriginalWeeks;

/**获取音频的时间长度*/
+ (float)audioSoundDuration:(NSURL *)fileUrl;

+ (BOOL)canLoadOneFlagWithString:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
