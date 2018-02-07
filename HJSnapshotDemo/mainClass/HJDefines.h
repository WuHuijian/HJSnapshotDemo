//
//  HJDefines.h
//  HJSnapshotDemo
//
//  Created by WHJ on 2018/1/12.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#ifndef HJDefines_h
#define HJDefines_h
#import <Foundation/Foundation.h>



/**********************   CONSTS  ***********************/

#define kFrame                       [UIScreen mainScreen].bounds
#define kScreenSize                  [UIScreen mainScreen].bounds.size
#define kScreenWidth                 [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                [UIScreen mainScreen].bounds.size.height
#define kNavigationBarHeight            (kScreenHeight == 812.f ? 88:64)
#define kTabBarHeight                   49
#define kCellDefaultHeight              44
#define iphoneX                      (kScreenHeight == 812.f)


#define kAppDelegate                ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define KIOSVersion                       [[UIDevice currentDevice].systemVersion floatValue]

#define kAboveIOS7                        ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define kAboveIOS8                        ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f)
#define kAboveIOS9                        ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0f)
#define kAboveIOS10                       ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0f)
#define kAboveIOS11                       ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0f)



#define HJNotificationCenter         [NSNotificationCenter defaultCenter]
#define HJUserDefaults               [NSUserDefaults standardUserDefaults]



/**********************   Methods  ***********************/

/**
 * NSLog
 */

#ifdef DEBUG
//打印简单信息
#define WLog(format, ...) printf("\n[%s] %s\n", __TIME__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
//打印详情
#define HJLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else

#define WLog(format, ...)
#define HJLog(format, ...)

#endif
/**
 *  屏幕适配
 */
#define RatioHeight [UIScreen mainScreen].bounds.size.height / 667.f-0.001
#define RatioWidth [UIScreen mainScreen].bounds.size.width / 375.f-0.001
#define Ratio_X(x) (x * RatioWidth)
#define Ratio_Y(y) (y * RatioHeight)

/**
 *  weakSelf
 */
#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self


#endif /* HJDefines_h */
