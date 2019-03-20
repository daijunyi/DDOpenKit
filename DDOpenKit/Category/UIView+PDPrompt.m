//
//  UIView+PDPrompt.m
//  PandaChallenge
//
//  Created by 盼达 on 16/3/23.
//  Copyright © 2016年 PandaOL. All rights reserved.
//

#import "UIView+PDPrompt.h"
#import <objc/runtime.h>
#import <CoreTelephony/CTCellularData.h>
#import <Masonry/Masonry.h>
#import "UIColor+DDAdd.h"
#import "UIFont+DDAdd.h"
#import "UIView+DDAdd.h"
#import <YYCategories/YYCategories.h>

#define PADDING 5.

static char promptKey;
static char tapBlockKey;
@implementation UIView (PDPrompt)

- (UIView *)showPromptWithBlock:(void(^)(void))block{
    return [self showPrompt:@"当前没有数据哦..." withImage:nil tapBlock:block];
}

- (UIView *)showPrompt:(NSString *)promptString withImage:(UIImage *)promptImage tapBlock:(void(^)(void))tapBlock{
    //有网络
    return [self createNoDataUIWithStr:promptString withImage:promptImage tapBlock:tapBlock];

}

- (UIView *)showPromptWithButtonNoDataWithTapBlock:(void (^)(void))tapBlock{
    return [self showPromptWithButtonName:@"重新加载" withImage:[UIImage imageNamed:@"data_load_fail"] tapBlock:tapBlock];
}

- (UIView *)showPromptWithButtonName:(NSString *)buttonName withImage:(UIImage *)promptImage tapBlock:(void(^)(void))tapBlock{
    if(!promptImage){
        promptImage = [UIImage imageNamed:@"data_load_fail"];
    }
    
    objc_setAssociatedObject(self, &tapBlockKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UIView *containerView = objc_getAssociatedObject(self, &promptKey);
    if (containerView) {
        [containerView removeFromSuperview];
    }
    containerView = [[UIView alloc] init];
    [self addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        if ([self isKindOfClass:[UIScrollView class]]) {
            make.width.equalTo(self.mas_width);
            make.height.equalTo(self.mas_height);
        }
    }];
    containerView.userInteractionEnabled = NO;
    containerView.backgroundColor = [UIColor whiteColor];
    
    objc_setAssociatedObject(self, &promptKey, containerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIImageView *promptImageView = nil;
    if (promptImage) {
        promptImageView = [[UIImageView alloc] initWithImage:promptImage];
        [containerView addSubview:promptImageView];
        [promptImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(containerView.mas_centerX);
            make.centerY.equalTo(containerView.mas_centerY).mas_equalTo(-80);
            make.width.equalTo(containerView.mas_width);
            make.width.equalTo(promptImageView.mas_height).multipliedBy(promptImage.size.width/promptImage.size.height);
        }];
    }
    
    UIButton *promptButton = [[UIButton alloc] init];
    promptButton.size = CGSizeMake(190, 44);
    promptButton.backgroundGradientDefaultRadius = 22;
    [promptButton setTitle:buttonName forState:UIControlStateNormal];
    [promptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    promptButton.titleLabel.font = [UIFont AppFontOfSize:16];
    [containerView addSubview:promptButton];
    [promptButton addTarget:self action:@selector(tapManager) forControlEvents:UIControlEventTouchUpInside];
    [promptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (promptImageView) {
            make.top.mas_equalTo(promptImageView.mas_bottom).mas_equalTo(20);
        }else{
            make.centerY.equalTo(containerView.mas_centerY).mas_equalTo(-80);
        }
        make.centerX.equalTo(containerView);
        make.size.mas_equalTo(CGSizeMake(190, 44));
    }];
    
    containerView.userInteractionEnabled = YES;
    // 添加手势
    if (tapBlock){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapManager)];
        [containerView addGestureRecognizer:tap];
    }
    return containerView;
}

- (UIView *)createNoDataUIWithStr:(NSString *)promptString withImage:(UIImage *)promptImage tapBlock:(void(^)(void))tapBlock{
    
    objc_setAssociatedObject(self, &tapBlockKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UIView *containerView = objc_getAssociatedObject(self, &promptKey);
    if (containerView) {
        [containerView removeFromSuperview];
    }
    containerView = [[UIView alloc] init];
    [self addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        if ([self isKindOfClass:[UIScrollView class]]) {
            make.width.equalTo(self.mas_width);
            make.height.equalTo(self.mas_height);
        }
    }];
    containerView.userInteractionEnabled = NO;
    containerView.backgroundColor = [UIColor whiteColor];
    
    objc_setAssociatedObject(self, &promptKey, containerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIImageView *promptImageView = nil;
    if (promptImage) {
        promptImageView = [[UIImageView alloc] initWithImage:promptImage];
        [containerView addSubview:promptImageView];
        [promptImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(containerView.mas_centerX);
            make.centerY.equalTo(containerView.mas_centerY).mas_equalTo(-80);
        }];
    }
    
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    promptLabel.backgroundColor = [UIColor clearColor];
    promptLabel.textColor = [UIColor colorWithHexString:@"e6e4e4"];
    promptLabel.text = promptString;
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.font = [UIFont systemFontOfSize:14.];
    promptLabel.numberOfLines = 0;
    [containerView addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (promptImageView) {
            make.top.mas_equalTo(promptImageView.mas_bottom).mas_equalTo(20);
        }else{
            make.centerY.equalTo(containerView.mas_centerY).mas_equalTo(-80);
        }
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
    }];
    

    containerView.userInteractionEnabled = YES;
    // 添加手势
    if (tapBlock){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapManager)];
        [containerView addGestureRecognizer:tap];
    }
    return containerView;
}

 // 【手势按钮】
-(void)tapManager{
    void(^tapBlock)(void) = objc_getAssociatedObject(self, &tapBlockKey);
    if (tapBlock){
        tapBlock();
    }
}

- (void)dismissPrompt {
    UIView *containerView = objc_getAssociatedObject(self, &promptKey);
    if (containerView) {

        [UIView animateWithDuration:.3f animations:^{
            containerView.alpha = 0;
        } completion:^(BOOL finished) {
            [containerView removeFromSuperview];
        }];
    }
}






@end
