//
//  DDDialogManager.h
//  KaiGua
//
//  Created by DD on 2017/9/7.
//  Copyright © 2017年 戴俊毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DDDialogManager : NSObject

+ (instancetype)shareInstance;

- (void)showWithText:(NSString *)text;

- (void)dismiss;

@end
