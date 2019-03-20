//
//  DDBarView.h
//  YunTaiXin
//
//  Created by DD on 2018/11/15.
//  Copyright © 2018 DD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface DDBarView : UIView

@property (nonatomic,strong)UIButton *leftBtn;

@property (nonatomic,strong)UILabel *titleView;

@property (nonatomic,strong)UIButton *rightBtn;

@property (nonatomic,assign)CGFloat rightBtnRightSpace;

@property (strong,nonatomic)UIImageView *backgroundImageView;

@end

NS_ASSUME_NONNULL_END
