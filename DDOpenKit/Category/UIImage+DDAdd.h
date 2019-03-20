//
//  UIImage+DDAdd.h
//  NewStar
//
//  Created by DD on 2017/2/18.
//  Copyright © 2017年 DD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface UIImage (DDAdd)

////获得圆形头像
//+ (UIImage *)dd_circleImageWithImage:(UIImage *)image size:(CGSize)size borderWith:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)dd_imageWithColor:(UIColor*)color;

/**保存图片*/
- (NSString *)dd_saveImageToDiskWithNSSearchPathDirectory:(NSSearchPathDirectory)dir;

- (NSString *)dd_saveImageToDiskWithNSSearchPathDirectory:(NSSearchPathDirectory)dir compressionQuality:(CGFloat)compressionQuality;

+ (UIImage *)dd_drawImageCenter:(CGSize)size imageName:(NSString *)imageName;
/**获取可拉伸的图片*/
+ (UIImage *)resizableImageWithName:(NSString *)name;

/**保存图片到系统相册 y以自己app名称为名字*/
- (void)saveToAblumWithcompletion:(void (^)(BOOL success, PHAsset *asset))completion;
@end
