//
//  UIView+DDAdd.m
//  NewStar
//
//  Created by DD on 2017/2/16.
//  Copyright © 2017年 DD. All rights reserved.
//

#import "UIView+DDAdd.h"
//#import "CALayer+DDAdd.h"
#import "UIView+YYAdd.h"
//#import <Lottie/Lottie.h>
#import "DDAdd.h"
#import <objc/runtime.h>
#import <YYCategories/YYCategories.h>
static char shadowBlackKey;
static char shadowWhiteKey;
static char backgroundGradientKey;
static char backgroundGradientDefaultRadiusKey;
static char gradientlayerKey;
static char shadowWithColorKey;
static char dd_scaleKey;
static char lineLayerKey;

@implementation UIView (DDAdd)

//+ (void)load{
//    Method method1 = class_getInstanceMethod([self class], @selector(layoutSubviews));
//    Method method2 = class_getInstanceMethod([self class], @selector(ddAddLayoutSubviews));
//    method_exchangeImplementations(method1, method2);
//}
//
//- (void)ddAddLayoutSubviews{
//    [self ddAddLayoutSubviews];
//    CAGradientLayer *layer = objc_getAssociatedObject(self, &gradientlayerKey);
//    if (layer) {
//        layer.frame = self.bounds;
//    }
//}



- (CGSize)dd_size
{
    return self.frame.size;
}

- (void)setDd_size:(CGSize)dd_size
{
    CGRect frame = self.frame;
    frame.size = dd_size;
    self.frame = frame;
}

- (CGFloat)dd_width
{
    return self.frame.size.width;
}

- (CGFloat)dd_height
{
    return self.frame.size.height;
}

- (void)setDd_width:(CGFloat)dd_width
{
    CGRect frame = self.frame;
    frame.size.width = dd_width;
    self.frame = frame;
}

- (void)setDd_height:(CGFloat)dd_height
{
    CGRect frame = self.frame;
    frame.size.height = dd_height;
    self.frame = frame;
}

- (CGFloat)dd_x
{
    return self.frame.origin.x;
}

- (void)setDd_x:(CGFloat)dd_x
{
    CGRect frame = self.frame;
    frame.origin.x = dd_x;
    self.frame = frame;
}

- (CGFloat)dd_y
{
    return self.frame.origin.y;
}

- (void)setDd_y:(CGFloat)dd_y
{
    CGRect frame = self.frame;
    frame.origin.y = dd_y;
    self.frame = frame;
}

- (CGFloat)dd_centerX
{
    return self.center.x;
}

- (void)setDd_centerX:(CGFloat)dd_centerX
{
    CGPoint center = self.center;
    center.x = dd_centerX;
    self.center = center;
}

- (CGFloat)dd_centerY
{
    return self.center.y;
}

- (void)setDd_centerY:(CGFloat)dd_centerY
{
    CGPoint center = self.center;
    center.y = dd_centerY;
    self.center = center;
}

- (CGFloat)dd_right
{
    //    return self.dd_x + self.dd_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)dd_bottom
{
    //    return self.dd_y + self.dd_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setDd_right:(CGFloat)dd_right
{
    self.dd_x = dd_right - self.dd_width;
}

- (void)setDd_bottom:(CGFloat)dd_bottom
{
    self.dd_y = dd_bottom - self.dd_height;
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (void)dd_circularWith:(CGFloat)bili{
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = self.dd_height/2*bili;
    self.layer.borderWidth = 0;
}

- (void)dd_circularWith:(CGFloat)bili height:(CGFloat)height{
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = height/2*bili;
    self.layer.borderWidth = 0;
}

//- (void)clickAmiantion:(void(^)())complected{
//    self.userInteractionEnabled = false;
//    POPSpringAnimation* springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    //它会先缩小到(0.5,0.5),然后再去放大到(1.0,1.0)
//    springAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)];
//    springAnimation.toValue =[NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
//    springAnimation.springBounciness = 15;
//    springAnimation.springSpeed = 40;
//    //动画结束之后的回调方法
//    [springAnimation setCompletionBlock:^(POPAnimation * animation, BOOL flag) {
//        self.userInteractionEnabled = true;
//        complected();
//    }];
//    [self.layer pop_addAnimation:springAnimation forKey:@"SpringAnimation"];
//}
//
//- (void)dd_shakeToShow{
//    [self.layer dd_shakeToShow];
//}
//
//- (void)dd_loveZanWithExcursionX:(CGFloat)excursionX scale:(CGFloat)scale{
//    if (self.superview == nil) {
//        return;
//    }
//    if (scale <= 0) {
//        scale = 3;
//    }
//    LOTAnimationView *animtionView = [LOTAnimationView animationNamed:@"loveAnimation"];
//    animtionView.clipsToBounds = false;
//    animtionView.width = [UIScreen getWidthWithHeight:self.height*scale scale:CGSizeMake(animtionView.width, animtionView.height)];
//    animtionView.height = self.height*scale;
//    animtionView.center = self.center;
//    if (excursionX != 0) {
//        animtionView.centerX = animtionView.centerX+excursionX;
//    }
//    [self.superview addSubview:animtionView];
//    self.hidden = true;
//    dd_weakObj(self);
//    dd_weakObj(animtionView);
//    [animtionView playWithCompletion:^(BOOL animationFinished) {
//        weakself.hidden = false;
//        [weakanimtionView removeFromSuperview];
//    }];
//}

- (CGRect)dd_getClickRectWidthScaleSize:(CGFloat)size{
    return CGRectMake(self.left-size, self.top-size, self.width+(2*size), self.height+(2*size));
}

- (CGRect)dd_getClickRect{
    return [self dd_getClickRectWidthScaleSize:10];
}

- (CGFloat)dd_scale{
    NSNumber *reslut = objc_getAssociatedObject(self, &dd_scaleKey);
    if (reslut) {
        return reslut.floatValue;
    }
    return 0;
}

- (void)setDd_scale:(CGFloat)dd_scale{
    CGFloat scale = 0;
    NSNumber *reslut = objc_getAssociatedObject(self, &dd_scaleKey);
    if (reslut) {
        scale = reslut.floatValue;
    }
    
    CGPoint center = self.center;
    if (scale == 0) {
        self.size = CGSizeMake(self.width*dd_scale, self.height*dd_scale);
        self.center = center;
    }else{
        CGFloat width = self.width;
        CGFloat height = self.height;
        
        width = width/scale;
        height = height/scale;
        self.size = CGSizeMake(width*dd_scale, height*dd_scale);
    }
    objc_setAssociatedObject(self, &dd_scaleKey, [[NSNumber alloc] initWithFloat:dd_scale], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)setBackgroundGradientDefaultRadius:(CGFloat)backgroundGradientDefaultRadius{
    objc_setAssociatedObject(self, &backgroundGradientDefaultRadiusKey, [[NSNumber alloc] initWithFloat:backgroundGradientDefaultRadius], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setBackgroundGradient:@[@"8bacf3",@"a980f0"]];
    self.gradientlayer.cornerRadius = backgroundGradientDefaultRadius;
}

- (CGFloat)backgroundGradientDefaultRadius{
    NSNumber *reslut = objc_getAssociatedObject(self, &backgroundGradientDefaultRadiusKey);
    if (reslut) {
        return reslut.floatValue;
    }
    return 0;
}

- (CAGradientLayer *)gradientlayer{
    CAGradientLayer *layer = objc_getAssociatedObject(self, &gradientlayerKey);
    if (!layer) {
        layer = [CAGradientLayer layer];
        [self.layer insertSublayer:layer atIndex:0];
        objc_setAssociatedObject(self, &gradientlayerKey, layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [layer setFrame:self.bounds];
    return layer;
}

- (void)setBackgroundGradient:(NSArray<NSString *> *)backgroundGradient{
    objc_setAssociatedObject(self, &backgroundGradientKey, backgroundGradient, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    CAGradientLayer*layer = [self gradientlayer];
    
    NSMutableArray *colors = [NSMutableArray array];
    for (NSString *tmp in backgroundGradient) {
        [colors addObject:(__bridge id)[UIColor colorWithHexString:tmp].CGColor];
    }

    layer.colors = colors;
    layer.locations = @[@(0.0),@(1.0)];
    layer.startPoint = CGPointMake(0, 0.5);
    layer.endPoint = CGPointMake(1, 0.5);
    self.backgroundColor = [UIColor clearColor];
}

- (NSArray<NSString *> *)backgroundGradient{
    return objc_getAssociatedObject(self, &backgroundGradientKey);
}

- (BOOL)shadowWhite{
    NSNumber *reslut = objc_getAssociatedObject(self, &shadowWhiteKey);
    if (reslut) {
        return reslut.boolValue;
    }
    return false;
}

- (void)setShadowWhite:(BOOL)shadowWhite{
    objc_setAssociatedObject(self, &shadowWhiteKey, [[NSNumber alloc] initWithBool:shadowWhite], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (shadowWhite) {
        self.shadowWithColor = [UIColor whiteColor];
    }else{
        self.shadowWithColor = [UIColor clearColor];
    }
}

- (BOOL)shadowBlack{
    NSNumber *reslut = objc_getAssociatedObject(self, &shadowBlackKey);
    if (reslut) {
        return reslut.boolValue;
    }
    return false;
}

- (void)setShadowBlack:(BOOL)shadowBlack{
    objc_setAssociatedObject(self, &shadowBlackKey, [[NSNumber alloc] initWithBool:shadowBlack], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (shadowBlack) {
        self.shadowWithColor = [UIColor blackColor];
    }else{
        self.shadowWithColor = [UIColor clearColor];
    }
}

- (UIColor *)shadowWithColor{
    UIColor *color = objc_getAssociatedObject(self, &shadowWithColorKey);
    if (color) {
        return color;
    }
    return [UIColor clearColor];
}

- (void)setShadowWithColor:(UIColor *)shadowWithColor{
    objc_setAssociatedObject(self, &shadowWithColorKey, shadowWithColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CALayer *subLayer= self.layer;
    //    CGRect fixframe = self.frame;
    //    subLayer.frame= fixframe;
    //    subLayer.cornerRadius = 8;
    //    subLayer.backgroundColor=[[UIColor clea] colorWithAlphaComponent:0.8].CGColor;
    //    subLayer.backgroundColor = [UIColor clearColor].CGColor;
    //    subLayer.masksToBounds=NO;
    subLayer.shadowColor = shadowWithColor.CGColor;//shadowColor阴影颜色
    subLayer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
    subLayer.shadowOpacity = 0.6;//阴影透明度，默认0
    subLayer.shadowRadius = 8;
    //    [self.layer insertSublayer:subLayer atIndex:0];
}


- (CAShapeLayer *)lineLayer{
    CAShapeLayer *lineLayer = objc_getAssociatedObject(self, &lineLayerKey);
    if (!lineLayer) {
        lineLayer = [CAShapeLayer layer];
        [self.layer addSublayer:lineLayer];
        objc_setAssociatedObject(self, &lineLayerKey, lineLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lineLayer;
}

//虚线
- (void)setLineImaginarylineWithPostion:(ViewLinePostion)postion withColor:(UIColor *)color{
    [self setBaseLineWithPostion:postion withColor:color];
    //虚线边框
    self.lineLayer.lineDashPattern = @[@4, @2];
}

- (void)setBaseLineWithPostion:(ViewLinePostion)postion withColor:(UIColor *)color{
    CAShapeLayer *borderLayer = self.lineLayer;
    borderLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (postion == ViewLinePostionAround) {
        path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:0];
    }else if(postion == ViewLinePostionTop){
        [path moveToPoint:(CGPoint){0,0}];
        [path addLineToPoint:(CGPoint){self.width,0}];
    }else if(postion == ViewLinePostionLeft){
        [path moveToPoint:(CGPoint){0,0}];
        [path addLineToPoint:(CGPoint){0,self.height}];
    }else if(postion == ViewLinePostionRight){
        [path moveToPoint:(CGPoint){self.width,0}];
        [path addLineToPoint:(CGPoint){self.width,self.height}];
    }else if(postion == ViewLinePostionBottom){
        [path moveToPoint:(CGPoint){0,self.height}];
        [path addLineToPoint:(CGPoint){self.width,self.height}];
    }
    borderLayer.path = path.CGPath;
    borderLayer.lineWidth = 1;
    //虚线边框
    //    borderLayer.lineDashPattern = @[@4, @2];
    //实线边框
    
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = color.CGColor;
}

//实线
- (void)setLineWithPostion:(ViewLinePostion)postion withColor:(UIColor *)color{
    [self setBaseLineWithPostion:postion withColor:color];
    self.lineLayer.lineDashPattern = nil;
}



@end
