//
//  NSString+DDAdd.h
//  NewStar
//
//  Created by DD on 2017/2/14.
//  Copyright © 2017年 DD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DDAdd)


#pragma mark- URL相关的方法
/**
 URL编码 类方法

 @param string NSString
 @return NSString
 */
+ (NSString*) dd_AFPercentEscapedStringFromString:(NSString *)string;


/**
 把int转换为NSString
 
 @param value int类型值
 @return 返回NSString
 */
+ (NSString *)dd_Format:(NSInteger)value;

+ (NSString *)dd_FormatNSInteger:(NSInteger)value;
/**
 URL编码 实列方法
 
 @return NSString
 */
- (NSString*) dd_AFPercentEscapedStringFromString;

#pragma mark- 简单工具类
/**
 判断手机号是否正确

 @return 返回bool
 */
- (BOOL)dd_IsPhoneMobile;

//判断是否是网址
- (BOOL)dd_isUrl;

+ (NSString *)dd_checkNumToStr:(NSInteger)number;

/**
 判断字符串是否为空

 @return 返回bool值
 */
- (BOOL)dd_isEmpty;



/**
 删除尾部标记

 @param LastFalg 比对微博的标记
 @return 返回去掉尾部标记之后的数据
 */
- (NSString *)dd_removeWithLastFalg:(NSString *)LastFalg;

/**
 把数组变成字符串并以某个符合隔开

 @param flag 隔开的标记
 @param array 数组
 @return 返回字符串
 */
+ (NSString *)dd_ArrayToStrWithFlag:(NSString *)flag array:(NSArray<NSString *> *)array;

//添加到
- (NSString *)dd_addStartBlank;

- (NSString *)dd_addEndBlank;

+ (NSString *)dd_fromatSize:(double)size;

/**
 返回url地址
 */
- (NSDictionary<NSTextCheckingResult *,NSString *> *)dd_checkUrl;

@end
