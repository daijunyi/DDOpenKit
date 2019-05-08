//
//  DDViewController.m
//  YunTaiXin
//
//  Created by DD on 2018/11/13.
//  Copyright © 2018 DD. All rights reserved.
//

#import "DDViewController.h"
#import <objc/runtime.h>
#import "DDNavigationViewController.h"
#import "DDShotcut.h"
static char onViewDidLoadWithBlockKey;

@interface DDViewController ()

@end

@implementation DDViewController

- (void)viewDidLoad {
    
    Log(@"进入页面:%@",NSStringFromClass(self.class));
    
    [super viewDidLoad];
    [self setDDBasePageSetting];
    [self setDDBaseView];
    [self onViewDidLoad];
}

- (void)onViewDidLoad{
    void(^block)(id viewController) = objc_getAssociatedObject(self, &onViewDidLoadWithBlockKey);
    if (block) {
        block(self);
    }
}

- (void)onViewDidLoadWithBlock:(void (^)(id viewController))block{
    objc_setAssociatedObject(self, &onViewDidLoadWithBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (instancetype)initFromNib{
    return [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (instancetype)newFromNib{
    return [[[self class] alloc] initFromNib];
}

//页面信息
- (void)setDDBasePageSetting{
    self.automaticallyAdjustsScrollViewInsets = false;
}

//界面
- (void)setDDBaseView{

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setCancelLeftTouch:self.cancelLeftTouch];
}

- (void)setCancelLeftTouch:(BOOL)cancelLeftTouch{
    _cancelLeftTouch = cancelLeftTouch;
    UINavigationController *con = self.navigationController;
    if ([con isKindOfClass:[DDNavigationViewController class]]) {
        DDNavigationViewController *nav = (DDNavigationViewController *)con;
        nav.pan.enabled = !cancelLeftTouch;
    }
}

- (void)dealloc{
    Log(@"销毁了：%@",NSStringFromClass(self.class));
}

#pragma mark-  删除页面中的一些页面
- (void)removeController:(NSArray<Class> *)classs{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    NSMutableArray<UIViewController *> *removes = [NSMutableArray array];
    for (int i=0; i<tmpArray.count; i++) {
        UIViewController *tmpCon = [tmpArray objectAtIndex:i];
        for (Class class in classs) {
            if ([tmpCon isKindOfClass:class]) {
                [removes addObject:tmpCon];
                break;
            }
        }
    }
    for (UIViewController *tmpCon in removes) {
        [tmpArray removeObject:tmpCon];
    }
    [self.navigationController setViewControllers:tmpArray animated:true];
}

@end
