//
//  UITextField+DDAdd.m
//  NewStar
//
//  Created by DD on 2017/2/17.
//  Copyright © 2017年 DD. All rights reserved.
//

#import "UITextField+DDAdd.h"
#import <objc/runtime.h>
static char dd_maxLengthkey;

static NSString * const DDPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (DDAdd)
- (void)setDd_placeholderColor:(UIColor *)dd_placeholderColor{
    // 提前设置占位文字, 目的 : 让它提前创建placeholderLabel
    NSString *oldPlaceholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = oldPlaceholder;
    
    // 恢复到默认的占位文字颜色
    if (dd_placeholderColor == nil) {
        dd_placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:dd_placeholderColor forKeyPath:DDPlaceholderColorKey];
}

//- (void)setPlaceholderColor:(UIColor *)placeholderColor
//{
//    // 提前设置占位文字, 目的 : 让它提前创建placeholderLabel
//    if (self.placeholder.length == 0) {
//        self.placeholder = @" ";
//    }
//
//    [self setValue:placeholderColor forKeyPath:XMGPlaceholderColorKey];
//}

- (UIColor *)dd_placeholderColor
{
    return [self valueForKeyPath:DDPlaceholderColorKey];
}

- (void)setDd_maxLength:(NSInteger)dd_maxLength{
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    objc_setAssociatedObject(self, &dd_maxLengthkey, [[NSNumber alloc] initWithInteger:dd_maxLength], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)textFieldDidChange:(UITextField *)textField
{
    NSInteger length = self.dd_maxLength;
    if (length != 0 && textField.text.length > length) {
        UITextRange *markedRange = [textField markedTextRange];
   　　　if (markedRange) {
        　　 return;
  　　　 }
        //Emoji占2个字符，如果是超出了半个Emoji，用15位置来截取会出现Emoji截为2半
        //超出最大长度的那个字符序列(Emoji算一个字符序列)的range
        NSRange range = [textField.text rangeOfComposedCharacterSequenceAtIndex:length];
        textField.text = [textField.text substringToIndex:range.location];
    }
}

- (NSInteger)dd_maxLength{
    NSNumber *number = objc_getAssociatedObject(self, &dd_maxLengthkey);
    if (number) {
        return number.integerValue;
    }else{
        return 0;
    }
}

@end
