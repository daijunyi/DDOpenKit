//
//  TSBaseDialogView.m
//  TigerSchool
//
//  Created by 红领巾 on 2018/6/19.
//  Copyright © 2018年 百e国际. All rights reserved.
//

#import "DDBaseDialogView.h"
#import <objc/runtime.h>
#import <YYCategories/YYCategories.h>
#import <Masonry/Masonry.h>
static char containerViewGesKey;
static char onHiddenCallBackKey;
static char onBackgroundClickWithBlockkey;

@interface DDBaseDialogView ()

@property (nonatomic,assign)BOOL isNeedAddContraint;

@end

@implementation DDBaseDialogView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBaseupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.isNeedAddContraint = true;
    return [super initWithCoder:aDecoder];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setBaseupUI];
}

- (void)setBaseupUI{
    self.style = TSBaseDialogViewStyleBottom;
    self.duration = 0.2;
    self.hiddenDuration = 0.2;
    
    self.userInteractionEnabled = true;
    [self addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onViewBgClick)]];
    if (!self.containerView) {
        self.containerView = [[UIView alloc] init];
        [self addSubview:self.containerView];
    }
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.userInteractionEnabled = true;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBottomViewClick)];
    objc_setAssociatedObject(self.containerView, &containerViewGesKey, ges, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.containerView addGestureRecognizer:ges];
}

#pragma mark- 添加广播

- (void)addnotification{
    if (!self.keyboradListening) {
        return;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    // 取出系统传过的键盘信息，是一个字典
    
    NSDictionary *keyboardDict = note.userInfo;
    
    // 字典里有keyboard的取出键盘变化之后的frame
    CGRect keyboardFrame = [keyboardDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 移动控制器view
    //有了键盘的纵坐标 就可以动态控制
    self.top = keyboardFrame.origin.y-kScreenHeight;
}


- (void)chageContainerViewActionWithView:(UIView *)view{
    UITapGestureRecognizer *ges = objc_getAssociatedObject(self.containerView, &containerViewGesKey);
    if(ges){
        [self.containerView removeGestureRecognizer:ges];
        objc_removeAssociatedObjects(ges);
    }
    view.userInteractionEnabled = true;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBottomViewClick)]];
}

- (void)onBottomViewClick{
    if([self respondsToSelector:@selector(onContainerViewClickCallBack)]){
        [self onContainerViewClickCallBack];
    }
}

- (void)onViewBgClick{
    if([self respondsToSelector:@selector(onViewBgClickCallBack)]){
        [self onViewBgClickCallBack];
    }else{
        [self hidden];
        void(^block)() = objc_getAssociatedObject(self, &onBackgroundClickWithBlockkey);
        if (block) {
            block();
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (float)bgAlphaComponent{
    if(_bgAlphaComponent == 0){
        _bgAlphaComponent = 0.6;
    }
    return _bgAlphaComponent;
}

- (void)show{
    [self showWithSuperView:nil];
}

- (void)showWithSuperView:(UIView *)superView{
    if(!self.superview){
        if(superView){
            [superView addSubview:self];
        }else{
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            if(window){
                [window addSubview:self];
            }
        }
    }
    if([self respondsToSelector:@selector(onShowAnimationBeforeCallBack)]){
        [self onShowAnimationBeforeCallBack];
    }else{
        if (self.style == TSBaseDialogViewStyleBottom) {
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            self.containerView.top = self.height;
        }else if(self.style == TSBaseDialogViewStyleMiddle){
            self.containerView.left = (self.width-self.containerView.width)/2;
            self.containerView.centerY = self.height/2;
        }
    }

    [self addnotification];
    if([self respondsToSelector:@selector(onShowAnimationCallBack)]){
        //自定义动画
        [self onShowAnimationCallBack];
        return;
    }
    
    if (self.style == TSBaseDialogViewStyleBottom) {
        [UIView animateWithDuration:self.duration animations:^{
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:self.bgAlphaComponent];
            self.containerView.top = self.height-self.containerView.height;
        }];
    }else if(self.style == TSBaseDialogViewStyleMiddle){
        [UIView animateWithDuration:self.duration animations:^{
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:self.bgAlphaComponent];
        }];
        [self.containerView.layer removeAllAnimations];
        self.containerView.transform = CGAffineTransformMakeScale(1, 1);
        self.containerView.alpha = 1;
        //中间显示
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
        animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        animation.duration = self.duration;
        [self.containerView.layer addAnimation:animation forKey:@"bouce"];
    }

}

- (void)hidden{
    void(^block)(void) = objc_getAssociatedObject(self, &onHiddenCallBackKey);
    if (block) {
        block();
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self endEditing:true];
    if([self respondsToSelector:@selector(onHiddenAnimationCallBack)]){
        //自定义动画
        [self onHiddenAnimationCallBack];
        return;
    }
    if (self.style == TSBaseDialogViewStyleBottom) {
        [UIView animateWithDuration:self.hiddenDuration animations:^{
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            self.containerView.top = self.height;
        } completion:^(BOOL finished) {
            self.top = 0;
            [self removeFromSuperview];
        }];
    }else if(self.style == TSBaseDialogViewStyleMiddle){
        //中间显示
        //TODO:
        [UIView animateWithDuration:self.hiddenDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            self.containerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            self.containerView.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)onHiddenCallBackWithBlock:(void (^)(void))block{
    objc_setAssociatedObject(self, &onHiddenCallBackKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)onBackgroundClickWithBlock:(void (^)(void))block{
    objc_setAssociatedObject(self, &onBackgroundClickWithBlockkey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (self.superview) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.superview);
        }];
    }
}

@end
