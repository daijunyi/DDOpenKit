//
//  DDBarView.m
//  YunTaiXin
//
//  Created by DD on 2018/11/15.
//  Copyright © 2018 DD. All rights reserved.
//

#import "DDBarView.h"
#import <Masonry/Masonry.h>
#import "DDShotcut.h"

#define ktitleFontSize 14
#define kRightAndLeftFontSize 14

@interface DDBarView ()

@end

@implementation DDBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDDupUI];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setDDupUI];
}

- (void)setDDupUI{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (UILabel *)titleView{
    if (!_titleView) {
        _titleView = [[UILabel alloc] init];
        _titleView.font = [UIFont systemFontOfSize:ktitleFontSize];
        _titleView.text = @"标题";
        [self addSubview:_titleView];
        [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(dd_SystemNavHeight);
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.equalTo(self);
        }];
    }
    return _titleView;
}

- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setTitle:@"左键" forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:kRightAndLeftFontSize];
        [_leftBtn setTitle:@"" forState:UIControlStateNormal];
        [self addSubview:_leftBtn];
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_equalTo(3);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_greaterThanOrEqualTo(dd_SystemNavHeight);
            make.height.mas_equalTo(dd_SystemNavHeight);
        }];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setTitle:@"右键" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:kRightAndLeftFontSize];
        [_rightBtn setTitle:@"" forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_equalTo(-self.rightBtnRightSpace);
            make.bottom.equalTo(self.mas_bottom);
            if (self.rightBtnRightSpace != 0) {
                make.width.mas_greaterThanOrEqualTo(0);
            }else{
                make.width.mas_greaterThanOrEqualTo(dd_SystemNavHeight);
            }
            
            make.height.mas_equalTo(dd_SystemNavHeight);
        }];
    }
    return _rightBtn;
}

- (void)setRightBtnRightSpace:(CGFloat)rightBtnRightSpace{
    _rightBtnRightSpace = rightBtnRightSpace;
    if (_rightBtn && _rightBtn.superview) {
        [_rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_equalTo(-self.rightBtnRightSpace);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_greaterThanOrEqualTo(0);
            make.height.mas_equalTo(dd_SystemNavHeight);
        }];
    }
}

- (UIImageView *)backgroundImageView{
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] init];
//        UIImage *backGroundImage = [UIImage imageNamed:@"my_head_bj"];
        [self addSubview:_backgroundImageView];
        //移动到最底部
        [self sendSubviewToBack:_backgroundImageView];
//        CGFloat height = (backGroundImage.size.height/backGroundImage.size.width)*kScreenWidth;
        [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(self.mas_height);
        }];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backgroundImageView;
}

@end
