//
//  UIImage+HJSnapshot.h
//  HJSnapshotDemo
//
//  Created by WHJ on 2018/1/10.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBelowIOS10    ([[[UIDevice currentDevice] systemVersion] floatValue]<10.0)


@interface UIImage (HJSnapshot)

+ (UIImage *)snapshotViewFromRect:(CGRect)rect withView:(UIView *)view saveToAlbum:(BOOL)save;

+ (UIImage *)combineWithImages:(NSArray *)images withMargin:(NSInteger)margin;

@end
