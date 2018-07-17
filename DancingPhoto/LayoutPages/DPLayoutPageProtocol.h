//
//  DPLayoutPageProtocol.h
//  DancingPhoto
//
//  Created by liang on 2018/7/16.
//  Copyright © 2018 liang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 定义 4 种不同的布局方式
extern NSString * const kPageTypeFrame;
extern NSString * const kPageTypeAnchor;
extern NSString * const kPageTypeVFL;
extern NSString * const kPageTypeMasonry;

extern NSString * const kPageWelcome;
//获取设备的物理高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define ONE_PIXEL (1 / [UIScreen mainScreen].scale)

@protocol DPLayoutPageProtocol <NSObject>

@property (nonatomic, strong) NSString *pageType;

/**
 返回当前音乐的 power 值。
 这些值都是经过处理的，最大是 1，最小是 0

 @param average 平均值
 @param peak 峰值
 */
- (void)onMusicPowerChange:(float)average peak:(float)peak;

@end

NS_ASSUME_NONNULL_END
