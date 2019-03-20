//
//  UIView+Action.h
//  TigerSchool
//
//  Created by 红领巾 on 2018/6/22.
//  Copyright © 2018年 百e国际. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Action)

- (void)actionViewClickWithBlock:(void(^)(UIView *view))block;

@end
