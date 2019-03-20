//
//  UIView+DDAdd.h
//  NewStar
//
//  Created by DD on 2017/2/16.
//  Copyright © 2017年 DD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ViewLinePostion) {
    ViewLinePostionLeft = 0,
    ViewLinePostionTop,
    ViewLinePostionRight,
    ViewLinePostionBottom,
    ViewLinePostionAround,
};

@interface UIView (DDAdd)

@property (nonatomic, assign) CGSize dd_size;
@property (nonatomic, assign) CGFloat dd_width;
@property (nonatomic, assign) CGFloat dd_height;
@property (nonatomic, assign) CGFloat dd_x;
@property (nonatomic, assign) CGFloat dd_y;
@property (nonatomic, assign) CGFloat dd_centerX;
@property (nonatomic, assign) CGFloat dd_centerY;

@property (nonatomic, assign) CGFloat dd_right;
@property (nonatomic, assign) CGFloat dd_bottom;

@property (nonatomic,assign)CGFloat dd_scale;

@property (nonatomic,assign)BOOL shadowBlack;

@property (nonatomic,assign)BOOL shadowWhite;

@property (nonatomic,strong)UIColor *shadowWithColor;

@property (nonatomic,strong)NSArray<NSString *> *backgroundGradient;
//设置默认的渐变背景
@property (nonatomic,assign)CGFloat backgroundGradientDefaultRadius;

@property (nonatomic,strong,readonly)CAGradientLayer *gradientlayer;

@property (nonatomic,strong,readonly)CAShapeLayer *lineLayer;

+ (instancetype)viewFromXib;

- (BOOL)intersectWithView:(UIView *)view;

- (void)dd_circularWith:(CGFloat)bili height:(CGFloat)height;
/**设置控件圆角 按照比例  1是最圆*/
- (void)dd_circularWith:(CGFloat)bili;
/**点击动画*/
//- (void)clickAmiantion:(void(^)())complected;

- (CGRect)dd_getClickRect;

- (CGRect)dd_getClickRectWidthScaleSize:(CGFloat)size;
/**画虚线*/
- (void)setLineImaginarylineWithPostion:(ViewLinePostion)postion withColor:(UIColor *)color;

//实线
- (void)setLineWithPostion:(ViewLinePostion)postion withColor:(UIColor *)color;

@end
