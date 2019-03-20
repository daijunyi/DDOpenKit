//
//  UIPickerView+PDCustomer.m
//  PandaChallenge
//
//  Created by 裴烨烽 on 16/3/21.
//  Copyright © 2016年 PandaOL. All rights reserved.
//

#import "UIPickerView+PDCustomer.h"
#import <objc/runtime.h>
static char dataSourceKey;
static char didSelectedKey;             // 选中方法抛出
@implementation UIPickerView (PDCustomer)

#pragma mark - createPickerView
+(UIPickerView *)pickerViewWithDataSource:(NSArray *)dataSource block:(pickDldSelectedBlock)block{
    // 绑定数据
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.backgroundColor = [UIColor clearColor];
    pickerView.dataSource = pickerView;
    pickerView.delegate = pickerView;
    objc_setAssociatedObject(pickerView, &dataSourceKey, dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(pickerView, &didSelectedKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return pickerView;
}

#pragma mark - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    NSArray *dataSourceArr = objc_getAssociatedObject(self, &dataSourceKey);
    return dataSourceArr.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *dataSourceArr = objc_getAssociatedObject(self, &dataSourceKey);
    NSArray *componentOfArr = [dataSourceArr objectAtIndex:component];
    return componentOfArr.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *dataSourceArr = objc_getAssociatedObject(self, &dataSourceKey);
    NSArray *rowArr = [dataSourceArr objectAtIndex:component];
    if ([[rowArr objectAtIndex:row] isKindOfClass:[NSString class]]){
        return [rowArr objectAtIndex:row];
    } else {
        return @"";
    }
}

#pragma mark - UIPickerViewDelegte
// 执行选中方法
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    void(^pickDldSelectedBlock)(NSInteger comment ,NSInteger row) = objc_getAssociatedObject(self, &didSelectedKey);
    if (pickDldSelectedBlock){
        pickDldSelectedBlock(component,row);
    }
}






@end
