//
//  DDNavigationViewController.m
//  NewStar
//
//  Created by DD on 2017/2/11.
//  Copyright © 2017年 DD. All rights reserved.
//

#import "DDNavigationViewController.h"

@interface DDNavigationViewController () <UIGestureRecognizerDelegate>

@end

@implementation DDNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = true;
    
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    self.pan = pan;
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    // 侧滑手势触发位置
    CGPoint location = [gestureRecognizer locationInView:self.view];
    CGPoint offSet = [gestureRecognizer translationInView:gestureRecognizer.view];
    BOOL ret = (0 < offSet.x && location.x <= 40);
    // NSLog(@"%@ %@",NSStringFromCGPoint(location),NSStringFromCGPoint(offSet));
    return ret;
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)ges{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count == 1){
        viewController.hidesBottomBarWhenPushed = true;
    }
    [super pushViewController:viewController animated:animated];
}

@end
