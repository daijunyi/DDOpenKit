//
//  NSDate+DDAdd.h
//  NewStar
//
//  Created by DD on 2017/2/22.
//  Copyright © 2017年 DD. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const defaultFormatterString = @"yyyy-MM-dd HH:mm:ss";

@interface NSDate (DDAdd)

/**
 转换成任何需要的格式
 
 @param time 时间
 @param format 需要的时间格式
 @return 返回需要的时间样式
 */

+ (NSString *)dd_stringWithTime:(NSTimeInterval)time toFormat:(NSString *)format;
/**
 转换成任何需要的格式

 @param str 之前的时间
 @param toFormat 需要的时间格式
 @return 返回需要的时间样式
 */
+ (NSString *)dd_WithString:(NSString *)str toFormat:(NSString *)toFormat;

/**
 获取年

 @param str 时间参数 yyyy-MM-dd HH:mm:ss
 @return 返回年
 */
+ (NSString *)dd_yearWithString:(NSString *)str format:(NSString *)format;

/**
 获取月份

 @param str 时间参数yyyy-MM-dd HH:mm:ss
 @return 获取月份
 */
+ (NSString *)dd_monthWithString:(NSString *)str format:(NSString *)format;

/**
 获取时分
 
 @param str 时间参数yyyy-MM-dd HH:mm:ss
 @return 获取月份
 */
+ (NSString *)dd_timeWithString:(NSString *)str format:(NSString *)format;
/**
 获取天

 @param str 时间参数时间参数yyyy-MM-dd HH:mm:ss
 @return 返回天
 */
+ (NSString *)dd_dayWithString:(NSString *)str format:(NSString *)format;
/**
 获取天
 
 @param str 时间参数时间参数yyyy-MM-dd HH:mm:ss
 @return 返回 dd/MM月
 */
+ (NSString *)createdTimeForPersonalCenter:(NSString*)str;
/**
 获取天
 
 @param str 时间参数时间参数yyyy-MM-dd HH:mm:ss
 @return 返回 yyyy/MM/dd
 */
+ (NSString *)createdTimeDateNormal:(NSString*)str;


+(NSString *)createDateForServer:(NSString *)str;
/**
 获取天
 
 @param starStr 时间参数时间参数yyyy-MM-dd HH:mm:ss
 @param endStr 时间参数时间参数yyyy-MM-dd HH:mm:ss
 @return 返回 yyyy/MM/dd-yyyy/MM/dd
 */
+(NSString *)createdTimeDateSpanWithStarStr:(NSString *)starStr EndStr:(NSString *)endStr;

+(NSString *)createOrderTimeWithTimeStr:(NSString *)str;
/**
 当前时间的年

 @return 返回年份
 */
+ (NSString *)dd_yearCurrent;

/**
 时间戳

 @return 返回时间戳
 */
+ (NSString *)dd_timestamp;


/**
 时间格式

 @return 返回数据
 */
+ (NSString *)dd_yyyyMMdd;


/**
 检测是否可以撤销
 */
+ (BOOL)dd_checIsCanRevocation:(NSString *)str;

+(NSString *)dd_MMdd:(NSString *)str;

/**
 时间格式

 @return 返回正确的时间
 */
+ (NSString *)dd_yyyyMMddHHmmssSSS;


/**
 把其他格式转换成这个格式
 */
+ (NSString *)dd_yyyyMMddHHmmssSSSWithStr:(NSString *)str;

/**
 时间格式化

 @param str 时间格式的数据
 @param fromFormat 时间的格式
 @param toFormat 要转换的格式
 @return 返回格式化完的数据
 */
+ (NSString *)dd_WithString:(NSString *)str fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat;


+ (NSString *)dd_updateTimeForRow:(NSString *)str;

+ (NSString *)dd_compareCurrentTime:(NSString *)str;

/**
 *转换时间
 **/
+ (NSString *)formatSecondsToString:(NSTimeInterval)seconds;

@end
