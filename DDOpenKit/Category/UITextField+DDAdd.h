//
//  UITextField+DDAdd.h
//  NewStar
//
//  Created by DD on 2017/2/17.
//  Copyright © 2017年 DD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (DDAdd)
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *dd_placeholderColor;

@property (nonatomic,assign)NSInteger dd_maxLength;

@end
