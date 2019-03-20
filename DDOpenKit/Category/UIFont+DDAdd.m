//
//  UIFont+DDAdd.m
//  KaiGua
//
//  Created by DD on 2017/5/5.
//  Copyright © 2017年 戴俊毅. All rights reserved.
//

#import "UIFont+DDAdd.h"

@implementation UIFont (DDAdd)

+ (UIFont *)AppFontOfSize:(CGFloat)size{
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        size = [UIScreen mainScreen].bounds.size.width*size/375;;
    }
    return [self systemFontOfSize:size];
}

+ (UIFont *)AppFontOfSize_bold:(CGFloat)size{
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        size = [UIScreen mainScreen].bounds.size.width*size/375;
    }
    return [self boldSystemFontOfSize:size];
}

+ (CGFloat)AppFloatFromPx:(CGFloat)px{
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return px/2;
    }
    return [UIScreen mainScreen].bounds.size.width*px/750;
}

+ (CGFloat)AppFloatFromFloat:(CGFloat)value{
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return value;
    }
    return [UIScreen mainScreen].bounds.size.width*value/325;
}


+ (UIFont *)AppFontFromPx:(CGFloat)px{
    return [self systemFontOfSize:[self AppFloatFromPx:px]];
}

+ (UIFont *)AppFontFromPx_bold:(CGFloat)px{
    return [self AppFontOfSize_bold:[self AppFloatFromPx:px]];
}

+ (UIFont *)HappyZcoolWithSize:(CGFloat)value{
    return [UIFont fontWithName:@"HappyZcool-2016" size:[UIFont AppFloatFromFloat:value]];
}

+ (void)printAllFontFamilyname{
    for (NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
}

@end
