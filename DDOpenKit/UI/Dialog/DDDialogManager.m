//
//  DDDialogManager.m
//  KaiGua
//
//  Created by DD on 2017/9/7.
//  Copyright © 2017年 戴俊毅. All rights reserved.
//

#import "DDDialogManager.h"
#import <YYCategories/YYCategories.h>
#import "DDOpenKit.h"

#define mixWidth kScreenWidth/2
#define maxWidth kScreenWidth*3/4
#define textLeftAndRightSpace 20
#define textTopSpace 35
#define textBottomSpace 30
#define lineBottomSpace 12
#define bottomSpace 24

#define durtionTime 2

@interface DDDialogManager ()

@property (nonatomic,strong)UIImageView *bgImageView;

@property (nonatomic,strong)UILabel *infoLabel;

@property (nonatomic,strong)UILabel *bottomInfoView;

@property (nonatomic,strong)UIView *lineView;

@property (nonatomic,assign)CGFloat textMaxWidth;

@end

@implementation DDDialogManager

- (CGFloat)textMaxWidth{
    if (_textMaxWidth == 0) {
        _textMaxWidth = maxWidth-textLeftAndRightSpace*2;
    }
    return _textMaxWidth;
}

+ (instancetype)shareInstance{
    static DDDialogManager *sharedMyManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        //从数据库加载用户信息
    });
    
    return sharedMyManager;
}

- (void)showWithText:(NSString *)text{
    [DDDialog dismiss];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
    [self setUpUI];
    [self.bgImageView.layer removeAllAnimations];
    
    
    self.infoLabel.size = CGSizeMake(self.textMaxWidth, CGFLOAT_MAX);
    self.infoLabel.text = text;
    [self.infoLabel sizeToFit];

    CGFloat holderViewWidth = self.infoLabel.width+2*textLeftAndRightSpace;
    holderViewWidth = holderViewWidth < mixWidth ? mixWidth : holderViewWidth;
    
    CGFloat holderViewHeight = textTopSpace+textBottomSpace+lineBottomSpace+bottomSpace;
    holderViewHeight += self.infoLabel.height;
    holderViewHeight += 2;
    holderViewHeight += _bottomInfoView.height;
    
    self.bgImageView.size = CGSizeMake(holderViewWidth, holderViewHeight);
    self.bgImageView.center = CGPointMake(kScreenWidth/2, kScreenHeight/3);
    
    self.infoLabel.centerX = self.bgImageView.width/2;
    self.infoLabel.top = textTopSpace;
    
    self.lineView.top = self.infoLabel.bottom+textBottomSpace;
    self.lineView.centerX = self.infoLabel.centerX;
    
    self.bottomInfoView.centerX = self.infoLabel.centerX;
    self.bottomInfoView.top = self.lineView.bottom+lineBottomSpace;
    if (self.bgImageView.alpha == 0) {
        self.bgImageView.alpha = 1;
        CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        popAnimation.duration = 0.4;
        popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
        popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.bgImageView.layer addAnimation:popAnimation forKey:nil];
    }
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:durtionTime];
}

- (void)dismiss{
    dd_weaktypf(self);
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.bgImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.bgImageView removeFromSuperview];
    }];
}

- (void)setUpUI{
    if (_bgImageView == nil) {
        [self.bgImageView addSubview:self.infoLabel];
        [self.bgImageView addSubview:self.lineView];
        [self.bgImageView addSubview:self.bottomInfoView];
        self.bgImageView.alpha = 0;
    }
    
    if (self.bgImageView.superview == nil) {
        [dd_window addSubview:self.bgImageView];
    }
}

- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [[UIImage imageNamed:@"dialog_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(40, 40, 40, 40) resizingMode:UIImageResizingModeTile];
        _bgImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _bgImageView;
}

- (UILabel *)infoLabel{
    if (_infoLabel == nil) {
        _infoLabel = [UILabel new];
        _infoLabel.textColor = [UIColor blackColor];
        _infoLabel.font = [UIFont AppFontOfSize:13];
        _infoLabel.numberOfLines = 0;
    }
    return _infoLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = dd_appBlueColor;
        _lineView.size = CGSizeMake(22, 2);
    }
    return _lineView;
}

- (UILabel *)bottomInfoView{
    if (_bottomInfoView == nil) {
        _bottomInfoView = [UILabel new];
        _bottomInfoView.font = [UIFont AppFontOfSize:11];
        _bottomInfoView.textColor = [UIColor dd_colorWithHexString:@"999999"];
        _bottomInfoView.text = @"朕已经知道了";
        [_bottomInfoView sizeToFit];
    }
    return _bottomInfoView;
}


@end
