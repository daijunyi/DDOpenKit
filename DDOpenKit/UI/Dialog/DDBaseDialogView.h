//
//  TSBaseDialogView.h
//  TigerSchool
//
//  Created by 红领巾 on 2018/6/19.
//  Copyright © 2018年 百e国际. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDBaseDialogViewDelegate <NSObject>

@optional
/**在动画调用之前，可以用来调整dialog控件的一些初始化的位置*/
-(void)onShowAnimationBeforeCallBack;
-(void)onShowAnimationCallBack;
-(void)onHiddenAnimationCallBack;

-(void)onViewBgClickCallBack;
-(void)onContainerViewClickCallBack;
@end

typedef enum : NSUInteger {
    TSBaseDialogViewStyleBottom,
    TSBaseDialogViewStyleMiddle,
} TSBaseDialogViewStyle;

@interface DDBaseDialogView : UIView<DDBaseDialogViewDelegate>

@property (nonatomic,strong)IBOutlet UIView *containerView;
@property (nonatomic,assign)float bgAlphaComponent;
/**默认是底部弹框*/
@property (nonatomic,assign)TSBaseDialogViewStyle style;
/**动画时间  默认是0.2*/
@property (nonatomic,assign)float duration;
/**隐藏动画时间 默认是0.2*/
@property (nonatomic,assign)float hiddenDuration;
/**开启键盘监听*/
@property (nonatomic,assign)BOOL keyboradListening;

/**如果要更改容器点击事件的拦截控件可以调用此方法*/
- (void)chageContainerViewActionWithView:(UIView *)view;
/**直接显示在window上*/
- (void)show;
/**显示在某个控件上*/
- (void)showWithSuperView:(UIView *)superView;
/**隐藏*/
- (void)hidden;

- (void)onHiddenCallBackWithBlock:(void(^)(void))block;

- (void)onBackgroundClickWithBlock:(void(^)(void))block;

@end
