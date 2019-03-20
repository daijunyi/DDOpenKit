//
//  UIImage+DDAdd.m
//  NewStar
//
//  Created by DD on 2017/2/18.
//  Copyright © 2017年 DD. All rights reserved.
//

#import "UIImage+DDAdd.h"
#import "NSDate+DDAdd.h"
#import <AVFoundation/AVFoundation.h>
#import "DDShotcut.h"

@implementation UIImage (DDAdd)
//+ (UIImage *)dd_circleImageWithImage:(UIImage *)image size:(CGSize)size borderWith:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
//    image = [image yy_imageByResizeToSize:size contentMode:UIViewContentModeScaleAspectFill];
//    return [image yy_imageByRoundCornerRadius:size.width borderWidth:borderWidth borderColor:borderColor];;
//}


+ (UIImage *)dd_imageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)dd_drawImageCenter:(CGSize)size imageName:(NSString *)imageName{
    CGRect rect=CGRectMake(0,0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    UIImage *defalutImage = [UIImage imageNamed:imageName];
    

    
    CGRect drawRect;
    if (defalutImage.size.width < rect.size.width && defalutImage.size.height <  rect.size.height) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = 0;
        CGFloat height = 0;
        x = (rect.size.width-defalutImage.size.width)/2;
        y = (rect.size.height-defalutImage.size.height)/2;
        width = defalutImage.size.width;
        height = defalutImage.size.height;
        drawRect = CGRectMake(x, y, width, height);
    }else{
        drawRect = rect;
    }
//    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, drawRect, defalutImage.CGImage);
//    CGContextDrawTiledImage(<#CGContextRef  _Nullable c#>, <#CGRect rect#>, <#CGImageRef  _Nullable image#>)
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (NSString *)dd_saveImageToDiskWithNSSearchPathDirectory:(NSSearchPathDirectory)dir{
    return [self dd_saveImageToDiskWithNSSearchPathDirectory:dir compressionQuality:1.0];
}

- (NSString *)dd_saveImageToDiskWithNSSearchPathDirectory:(NSSearchPathDirectory)dir compressionQuality:(CGFloat)compressionQuality{
    if(self == nil){
        return @"";
    }
    UIImage *m_imgFore = self;
    
    NSData *imagedata = UIImageJPEGRepresentation(m_imgFore,compressionQuality);
    
    NSArray*paths=NSSearchPathForDirectoriesInDomains(dir,NSUserDomainMask,YES);
    
    NSString *documentsDirectory=[paths objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[NSDate dd_timestamp]];
    
    NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:fileName];
    
    [imagedata writeToFile:savedImagePath atomically:YES];
    return savedImagePath;
}


+ (UIImage *)resizableImageWithName:(NSString *)name{
    // 加载图片
    UIImage *image = [UIImage imageNamed:name];
    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.49;
    CGFloat left = image.size.width * 0.49;
    CGFloat bottom = image.size.height * 0.49;
    CGFloat right = image.size.width * 0.49;
    
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    return newImage;
}


- (void)saveToAblumWithcompletion:(void (^)(BOOL success, PHAsset *asset))completion
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        if (completion) completion(NO, nil);
    } else if (status == PHAuthorizationStatusRestricted) {
        if (completion) completion(NO, nil);
    } else {
        __block PHObjectPlaceholder *placeholderAsset=nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *newAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self];
            placeholderAsset = newAssetRequest.placeholderForCreatedAsset;
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (!success) {
                if (completion) completion(NO, nil);
                return;
            }
            PHAsset *asset = [self getAssetFromlocalIdentifier:placeholderAsset.localIdentifier];
            PHAssetCollection *desCollection = [self getDestinationCollection];
            if (!desCollection) completion(NO, nil);
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:desCollection] addAssets:@[asset]];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (completion) completion(success, asset);
            }];
        }];
    }
}

- (void)saveVideoToAblum:(NSURL *)url completion:(void (^)(BOOL, PHAsset *))completion
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        if (completion) completion(NO, nil);
    } else if (status == PHAuthorizationStatusRestricted) {
        if (completion) completion(NO, nil);
    } else {
        __block PHObjectPlaceholder *placeholderAsset=nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *newAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
            placeholderAsset = newAssetRequest.placeholderForCreatedAsset;
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (!success) {
                if (completion) completion(NO, nil);
                return;
            }
            PHAsset *asset = [self getAssetFromlocalIdentifier:placeholderAsset.localIdentifier];
            PHAssetCollection *desCollection = [self getDestinationCollection];
            if (!desCollection) completion(NO, nil);
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:desCollection] addAssets:@[asset]];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (completion) completion(success, asset);
            }];
        }];
    }
}

- (PHAsset *)getAssetFromlocalIdentifier:(NSString *)localIdentifier{
    if(localIdentifier == nil){
        NSLog(@"Cannot get asset from localID because it is nil");
        return nil;
    }
    PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:@[localIdentifier] options:nil];
    if(result.count){
        return result[0];
    }
    return nil;
}

//获取自定义相册
- (PHAssetCollection *)getDestinationCollection
{
    //找是否已经创建自定义相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:kAPPName]) {
            return collection;
        }
    }
    //新建自定义相册
    __block NSString *collectionId = nil;
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:kAPPName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) {
        NSLog(@"创建相册：%@失败", kAPPName);
        return nil;
    }
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].lastObject;
}

@end
