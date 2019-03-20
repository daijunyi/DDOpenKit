//
//  UIView+PDPrompt.h
//  PandaChallenge
//
//  Created by 盼达 on 16/3/23.
//  Copyright © 2016年 PandaOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PDPrompt)

- (UIView *)showPromptWithBlock:(void(^)(void))block;

- (UIView *)showPrompt:(NSString *)promptString withImage:(UIImage *)promptImage tapBlock:(void(^)(void))tapBlock;

- (void)dismissPrompt;

- (UIView *)showPromptWithButtonName:(NSString *)buttonName withImage:(UIImage *)promptImage tapBlock:(void(^)(void))tapBlock;

- (UIView *)showPromptWithButtonNoDataWithTapBlock:(void(^)(void))tapBlock;

@end
