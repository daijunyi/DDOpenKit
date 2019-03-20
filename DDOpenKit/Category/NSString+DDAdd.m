//
//  NSString+DDAdd.m
//  NewStar
//
//  Created by DD on 2017/2/14.
//  Copyright © 2017年 DD. All rights reserved.
//

#import "NSString+DDAdd.h"

@implementation NSString (DDAdd)


+ (NSString*) dd_AFPercentEscapedStringFromString:(NSString *)string {
    return (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)string,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
}


- (NSString*) dd_AFPercentEscapedStringFromString {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)self,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
}

- (BOOL)dd_isUrl
{
    if(self == nil)
        return NO;
    NSString *url;
    if (self.length>4 && [[self substringToIndex:4] isEqualToString:@"www."]) {
        url = [NSString stringWithFormat:@"http://%@",self];
    }else{
        url = self;
    }
    NSString *urlRegex = @"(https|http|ftp|rtsp|igmp|file|rtspt|rtspu)://((((25[0-5]|2[0-4]\\d|1?\\d?\\d)\\.){3}(25[0-5]|2[0-4]\\d|1?\\d?\\d))|([0-9a-z_!~*'()-]*\\.?))([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\.([a-z]{2,6})(:[0-9]{1,4})?([a-zA-Z/?_=]*)\\.\\w{1,5}";
    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:url];
}

//判断手机号码格式是否正确
- (BOOL)dd_IsPhoneMobile
{
    if (self.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:self];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:self];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:self];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

- (BOOL)dd_isEmpty{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


+ (NSString *)dd_Format:(NSInteger)value{
    return [NSString stringWithFormat:@"%ld",value];
}

+ (NSString *)dd_FormatNSInteger:(NSInteger)value{
    return [NSString stringWithFormat:@"%ld",value];
}

- (NSString *)dd_removeWithLastFalg:(NSString *)LastFalg{
    if(self.length>0 && LastFalg.length < self.length){
        if([[self substringFromIndex:self.length-LastFalg.length] isEqualToString:LastFalg]){
            return [self substringToIndex:self.length-LastFalg.length];
        }
    }
    return self;
}

+ (NSString *)dd_ArrayToStrWithFlag:(NSString *)flag array:(NSArray<NSString *> *)array{
    NSString *path = @"";
    for (NSString *item in array){
        if(item == nil || [item dd_isEmpty] == true){
            continue;
        }
        path = [path stringByAppendingString:item];
        path = [path stringByAppendingString:flag];
    }
    path = [path dd_removeWithLastFalg:flag];
    return path;
}

- (NSString *)dd_addStartBlank{
    return [NSString stringWithFormat:@" %@",self];
}

- (NSString *)dd_addEndBlank{
    return [NSString stringWithFormat:@"%@ ",self];
}

+ (NSString *)dd_fromatSize:(double)size{
    if(size > 1000000){
        return [NSString stringWithFormat:@"%0.1fMB",size/1000000.f];
    }else if(size > 1000){
        return [NSString stringWithFormat:@"%0.1fkb",size/1000.f];
    }else{
        return [NSString stringWithFormat:@"%0.1fb",size];
    }
}

- (NSDictionary<NSTextCheckingResult *,NSString *> *)dd_checkUrl{
    if (self.dd_isEmpty) {
        return nil;
    }
    NSError *error;
    NSString *regulaStr = @"((http{0,1}|ftp|https)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:self
                                                options:0
                                                  range:NSMakeRange(0, [self length])];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSTextCheckingResult *match in arrayOfAllMatches) {
        NSString *substringForMatch = [self substringWithRange:match.range];
        [dic setObject:substringForMatch forKey:match];
    }
    return dic;
}

+ (NSString *)dd_checkNumToStr:(NSInteger)number{
    if (number < 1000) {
        return [NSString dd_Format:number];
    }else if(number<10000){
        double value = number/1000.0f;
        return [NSString stringWithFormat:@"%.1fk",value];
    }else{
        double value = number/10000.0f;
        return [NSString stringWithFormat:@"%.0f万",value];
    }
}

@end
