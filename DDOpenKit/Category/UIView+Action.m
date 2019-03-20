//
//  UIView+Action.m
//  TigerSchool
//
//  Created by 红领巾 on 2018/6/22.
//  Copyright © 2018年 百e国际. All rights reserved.
//

#import "UIView+Action.h"
#import <objc/runtime.h>
static char actionBaseViewClickWithBlockKey;

@implementation UIView (Action)

- (void)actionViewClickWithBlock:(void (^)(UIView *view))block{
    objc_setAssociatedObject(self, &actionBaseViewClickWithBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.userInteractionEnabled = true;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBaseViewClick)]];
}

- (void)onBaseViewClick{
    void(^block)(UIView *view) = objc_getAssociatedObject(self, &actionBaseViewClickWithBlockKey);
    if(block){
        block(self);
    }
}
@end
