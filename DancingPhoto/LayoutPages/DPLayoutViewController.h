//
//  DPLayoutViewController.h
//  DancingPhoto
//
//  Created by liang on 2018/7/16.
//  Copyright © 2018 liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPLayoutPageProtocol.h"
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

// 横坐标，竖坐标在 画面上的间隔
static NSInteger xStepPixel = 3;
static NSInteger yStepPixel = 3;

@interface DPLayoutViewController : UIViewController <DPLayoutPageProtocol>

@property (nonatomic, strong) NSArray<UIView *> *dots;

@property (nonatomic, strong) NSString *pageType;

- (void)startWave;

// 保存了图片在平面的隔行扫描后的结果，是个二位数组
+ (NSArray<NSArray *> *)colorMatrix;

@end

NS_ASSUME_NONNULL_END
