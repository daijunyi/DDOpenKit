
//
//  Tool.m
//  YunTaiXin
//
//  Created by 戴俊毅 on 2018/11/19.
//  Copyright © 2018 DD. All rights reserved.
//

#import "DDTool.h"
#import <AVKit/AVKit.h>
#import "DDShotcut.h"

@implementation DDTool

#pragma mark - 手机号码验证
+ (BOOL)checkIsPhoneNumber:(NSString *)mobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1((2|3|4|5|6|7|8|9)\\d)\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

/**
 *将周数字符串转化为显示的字符串
 **/
+ (NSString *)transWeeksString:(NSString *)OriginalWeeks{
    NSArray  *array = [OriginalWeeks componentsSeparatedByString:@","];
    if (array.count == 1) {
        return [NSString stringWithFormat:@"第%@周",[array objectAtIndex:0]];
    }
    else{
        return [NSString stringWithFormat:@"第%@-%@周",[array objectAtIndex:0],[array objectAtIndex:array.count-1]];
    }
}
/**获取音频的时间长度*/
+ (float)audioSoundDuration:(NSURL *)fileUrl{
    
    AVAudioPlayer* player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
    double duration = player.duration;
//    if (@available(iOS 10.0, *)) {
//        AVAudioFormat* format = player.format;
//        Log(@"音频时长:%lf",player.duration);
//        Log(@"音频声道数:%u",format.channelCount);
//        Log(@"采样频率==%lf",format.sampleRate);////默认为:25600,所以也是按照这个频率来计算的
//        duration = duration*(25600/format.sampleRate);
//    } else {
//        // Fallback on earlier versions
//    }
    return duration;

//    AVURLAsset*audioAsset = [AVURLAsset URLAssetWithURL:fileUrl options:nil];
//    CMTime audioDuration = audioAsset.duration;
//    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
//    return audioDurationSeconds;
    
//    NSDictionary *options = @{AVURLAssetPreferPreciseDurationAndTimingKey: @YES};
//    AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:fileUrl options:options];
//    CMTime audioDuration = audioAsset.duration;
//    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
//    return audioDurationSeconds;
}

+ (BOOL)canLoadOneFlagWithString:(NSString *)value{
    NSUserDefaults *saveInfo = [NSUserDefaults standardUserDefaults];
    NSString *homeDialog = [saveInfo stringForKey:value];
    if ([homeDialog isEqualToString:@"1"] && WarnDialogFlag) {
        return false;
    }
    [saveInfo setObject:@"1" forKey:value];
    return true;
}

@end
