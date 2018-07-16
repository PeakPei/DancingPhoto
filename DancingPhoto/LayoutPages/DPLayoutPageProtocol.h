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

//获取设备的物理高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define ONE_PIXEL (1 / [UIScreen mainScreen].scale)

@protocol DPLayoutPageProtocol <NSObject>

@property (nonatomic, strong) NSString *pageType;

@end

NS_ASSUME_NONNULL_END
