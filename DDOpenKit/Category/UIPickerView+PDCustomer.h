//
//  UIPickerView+PDCustomer.h
//  PandaChallenge
//
//  Created by 裴烨烽 on 16/3/21.
//  Copyright © 2016年 PandaOL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^pickDldSelectedBlock)(NSInteger comment ,NSInteger row);

@interface UIPickerView (PDCustomer)<UIPickerViewDelegate,UIPickerViewDataSource>
+(UIPickerView *)pickerViewWithDataSource:(NSArray *)dataSource block:(pickDldSelectedBlock)block;
@end
