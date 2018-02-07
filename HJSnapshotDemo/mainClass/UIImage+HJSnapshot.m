//
//  UIImage+HJSnapshot.m
//  HJSnapshotDemo
//
//  Created by WHJ on 2018/1/10.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import "UIImage+HJSnapshot.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <Photos/Photos.h>


@implementation UIImage (HJSnapshot)

+ (UIImage *)snapshotViewFromRect:(CGRect)rect withView:(UIView *)view saveToAlbum:(BOOL)save {
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(currentContext, - CGRectGetMinX(rect), - CGRectGetMinY(rect));
    [view.layer renderInContext:currentContext];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (save) {//保存截图到相册
        
        CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
   
        if (systemVersion<10.0f) {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library writeImageToSavedPhotosAlbum:[snapshotImage CGImage] orientation:(ALAssetOrientation)[snapshotImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
                if (error) {
                    
                } else {
                    
                }
            }];
        }else{
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
    
                [PHAssetChangeRequest creationRequestForAssetFromImage:snapshotImage];
    
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                
                NSLog(@"success = %d, error = %@", success, error);
            }];
        }
    }

    return snapshotImage;
}



//竖直拼接
+ (UIImage *)combineWithImages:(NSArray *)images withMargin:(NSInteger)margin{
    
    if(images && images.count==0){
        return nil;
    }
    
    //获取画布宽高
    __block CGFloat totalH = 0;
    __block CGFloat totalW = 0;
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *image = (UIImage *)obj;
        totalH = totalH + image.size.height + margin;
        totalW = image.size.width;
    }];
    
    CGSize totalSize = CGSizeMake(totalW, totalH);
    
    //构造画布大小
    UIGraphicsBeginImageContextWithOptions(totalSize, NO, [UIScreen mainScreen].scale);
    
    __block CGFloat currentH = 0;
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *image = (UIImage *)obj;
        CGRect rect = CGRectMake(0, currentH, totalW, image.size.height);
        [image drawInRect:rect];
        currentH = currentH + image.size.height + margin;
    }];
    
    //生成图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}






@end
