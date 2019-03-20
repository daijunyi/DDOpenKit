//
//  NSDate+DDAdd.m
//  NewStar
//
//  Created by DD on 2017/2/22.
//  Copyright © 2017年 DD. All rights reserved.
//

#import "NSDate+DDAdd.h"
#import "NSString+DDAdd.h"


@implementation NSDate (DDAdd)


+ (NSString *)dd_yearWithString:(NSString *)str format:(NSString *)format{
    NSDate *date = [self dd_dateFromString:str format:format];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy";
    return [formatter stringFromDate:date];
}

+ (NSString *)dd_monthWithString:(NSString *)str format:(NSString *)format{
    NSDate *date = [self dd_dateFromString:str format:format];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM";
    return [formatter stringFromDate:date];
}

+ (NSString *)dd_dayWithString:(NSString *)str format:(NSString *)format{
    NSDate *date = [self dd_dateFromString:str format:format];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"dd";
    return [formatter stringFromDate:date];
}

+ (NSString *)dd_stringWithTime:(NSTimeInterval)time toFormat:(NSString *)format{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}

+ (NSString *)dd_timeWithString:(NSString *)str format:(NSString *)format{
    NSDate *date = [self dd_dateFromString:str format:format];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm";
    return [formatter stringFromDate:date];
}

+ (NSDate *)dd_dateFromString:(NSString *)str format:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    return [formatter dateFromString:str];
}

+ (NSString *)dd_yearCurrent{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy";
    return [formatter stringFromDate:[NSDate new]];
}

+ (NSString *)dd_timestamp{
    NSString * timestamp = [(@((long)([[NSDate alloc] init].timeIntervalSince1970*1000))) stringValue];
    return timestamp;
}

+ (NSString *)dd_yyyyMMdd{
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:date];
}

+ (NSString *)dd_yyyyMMddHHmmssSSS{
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss SSS";
    return [formatter stringFromDate:date];
}

+ (NSString *)dd_yyyyMMddHHmmssSSSWithStr:(NSString *)str{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSDate *timeDate = [self dateFromString:str dateFormatter:formatter];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss SSS";
    return [formatter stringFromDate:timeDate];
}

+ (NSString *)dd_WithString:(NSString *)str fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat{
    NSDate *date = [self dd_dateFromString:str format:fromFormat];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = toFormat;
    return [formatter stringFromDate:date];
}

+ (NSString *)dd_WithString:(NSString *)str toFormat:(NSString *)toFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //把字符串转为NSdate
    NSDate *timeDate = [self dateFromString:str dateFormatter:dateFormatter];
    dateFormatter.dateFormat = toFormat;
    return [dateFormatter stringFromDate:timeDate];
}


+ (NSDate *)dateFromString:(NSString *)str dateFormatter:(NSDateFormatter *)dateFormatter{
    if(dateFormatter == nil){
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SSS"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    if(timeDate == nil){
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        timeDate = [dateFormatter dateFromString:str];
    }
    
    if(timeDate == nil){
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss S"];
        timeDate = [dateFormatter dateFromString:str];
    }
    
    if(timeDate == nil){
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SS"];
        timeDate = [dateFormatter dateFromString:str];
    }
    
    if(timeDate == nil){
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        timeDate = [dateFormatter dateFromString:str];
    }
    
    if(timeDate == nil){
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        timeDate = [dateFormatter dateFromString:str];
    }
    
    if(timeDate == nil){
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        timeDate = [dateFormatter dateFromString:str];
    }
    
    if(timeDate == nil){
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        timeDate = [dateFormatter dateFromString:str];
    }
    
    if(timeDate == nil){
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        timeDate = [dateFormatter dateFromString:str];
    }
    
    if(timeDate == nil){
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss SSS"];
        timeDate = [dateFormatter dateFromString:str];
    }
    
    return timeDate;
}

+(NSString *)createOrderTimeWithTimeStr:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //把字符串转为NSdate
    NSDate *timeDate = [self dateFromString:str dateFormatter:dateFormatter];
    if(timeDate == nil){
        return @"";
    }
    NSString *result;
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    result = [dateFormatter stringFromDate:timeDate];
    return  result;
}

+(NSString *)dd_MMdd:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //把字符串转为NSdate
    NSDate *timeDate = [self dateFromString:str dateFormatter:dateFormatter];
    if(timeDate == nil){
        return @"";
    }
    NSString *result;
    [dateFormatter setDateFormat:@"MM/dd"];
    result = [dateFormatter stringFromDate:timeDate];
    return  result;
}

//检测是否可以撤销
+ (BOOL)dd_checIsCanRevocation:(NSString *)str
{
    if(str == nil || str.dd_isEmpty){
        return false;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //把字符串转为NSdate
    NSDate *timeDate = [self dateFromString:str dateFormatter:dateFormatter];
    if(timeDate == nil){
        return false;
    }
    
    NSDate *currentDate = [NSDate date];
    
    //得到两个时间差
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    long temp = 0;
    if((temp = timeInterval/60) <= 5){
        return true;
    }
    return  false;
}

//方式一 后台给的格式为yyyy-MM-dd HH:mm:ss  几分钟前等
+ (NSString *)dd_compareCurrentTime:(NSString *)str
{
    if(str == nil || str.dd_isEmpty){
        return @"";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //把字符串转为NSdate
    NSDate *timeDate = [self dateFromString:str dateFormatter:dateFormatter];
    if(timeDate == nil){
        return @"";
    }
    
    NSDate *currentDate = [NSDate date];
    
    //得到两个时间差
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    long temp = 0;
    NSString *result;
    if (timeInterval/60 < 1)
    {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <3){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
//    else if((temp = temp/30) <12){
//        result = [NSString stringWithFormat:@"%ld月前",temp];
//    } else{
//        temp = temp/12;
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//    }
    else{
        [dateFormatter setDateFormat:@"yyyy"];
        if ([[NSDate dd_yearCurrent] isEqualToString:[dateFormatter stringFromDate:timeDate]]) {
            [dateFormatter setDateFormat:@"MM/dd HH:mm"];
            result = [dateFormatter stringFromDate:timeDate];
        }else{
            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
            result = [dateFormatter stringFromDate:timeDate];
        }
        
    }
    return  result;
}
//将后台获取到的yyyy-MM-dd 转化为 dd/MM月
+(NSString *)createdTimeForPersonalCenter:(NSString *)str{
    //把字符串转为NSdate
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //把字符串转为NSdate
    NSDate *timeDate = [self dateFromString:str dateFormatter:dateFormatter];
    if(timeDate == nil){
        return @"";
    }
    
    NSString *result;
    [dateFormatter setDateFormat:@"dd/MM月"];
    result = [dateFormatter stringFromDate:timeDate];
    return  result;
}
//yyyy/MM/dd
+(NSString *)createdTimeDateNormal:(NSString *)str{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //把字符串转为NSdate
    NSDate *timeDate = [self dateFromString:str dateFormatter:dateFormatter];
    if(timeDate == nil){
        return @"";
    }
    
    NSString *result;
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    result = [dateFormatter stringFromDate:timeDate];
    return  result;
}

+(NSString *)createDateForServer:(NSString *)str{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //把字符串转为NSdate
    NSDate *timeDate = [self dateFromString:str dateFormatter:dateFormatter];
    if(timeDate == nil){
        return @"";
    }
    
    NSString *result;
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    result = [dateFormatter stringFromDate:timeDate];
    return  result;
}

//yyyy/MM/dd-yyyy/MM/dd
+(NSString *)createdTimeDateSpanWithStarStr:(NSString *)starStr EndStr:(NSString *)endStr{
    if (starStr == nil || endStr == nil) {
        
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *starDate = [dateFormatter dateFromString:starStr];
    NSDate *endDate = [dateFormatter dateFromString:endStr];
    
    NSString *result;
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    result = [[[dateFormatter stringFromDate:starDate] stringByAppendingString:@"-"] stringByAppendingString:[dateFormatter stringFromDate:endDate]];
    return  result;
}

//方式二 后台给的格式为 纯数字1352170595000(13位)
+ (NSString *)dd_updateTimeForRow:(NSString *)str {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime =[str floatValue]/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    //秒转分钟
    NSInteger small = time / 60;
    if (small == 0) {
        return [NSString stringWithFormat:@"刚刚"];
    }
    
    
    if (small < 60) {
        return [NSString stringWithFormat:@"%ld分钟前",small];
    }
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}

/**
 *转换时间
 **/
+ (NSString *)formatSecondsToString:(NSTimeInterval)seconds
{
    NSInteger a =round(seconds) ;
    NSInteger c = a/60;
    NSInteger d = a-c*60;
    
    if (c < 10) {
        if (d < 10) {
            NSString * time  = [NSString stringWithFormat:@"0%ld:0%ld", (long)c,(long)d];
            return time;
        } else {
            NSString * time  = [NSString stringWithFormat:@"0%ld:%ld", (long)c,(long)d];
            return time;
        }
    } else {
        if (d < 10) {
            NSString * time  = [NSString stringWithFormat:@"%ld:0%ld", (long)c,(long)d];
            return time;
        } else {
            NSString * time  = [NSString stringWithFormat:@"%ld:%ld", (long)c,(long)d];
            return time;
        }
    }
    
}

@end
