//
//  DPLayoutFrameController.m
//  DancingPhoto
//
//  Created by liang on 2018/7/16.
//  Copyright © 2018 liang. All rights reserved.
//

#import "DPLayoutFrameController.h"

@interface DPLayoutFrameController ()

@end

@implementation DPLayoutFrameController

- (void)viewDidLoad {
    self.pageType = kPageTypeFrame;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray<NSArray *> *colorMatrix = [self.class colorMatrix];
    
    // dots 保存所有的 view，在后面做动画时调用。
    NSMutableArray<UIView *> *dots = [NSMutableArray arrayWithCapacity:300 *100];
    // 将这些颜色画到界面
    // 颜色的矩阵不会大于整个 view 的尺寸，因为采样的时候已经保证了这一点
    // 前提：间距和元素尺寸一样
    
    // 先计算 y 的步进和起步偏移
    NSInteger yLen = colorMatrix.count;
    CGFloat yStep = SCREEN_HEIGHT / (2 * yLen + 1);
    CGFloat yStartOffset = yStep;
    [colorMatrix enumerateObjectsUsingBlock:^(NSArray * _Nonnull xColors, NSUInteger yIdx, BOOL * _Nonnull stop) {
        
        // 计算横行步进。因为采样的长度是不足于屏幕的尺寸的
        NSInteger xLen = xColors.count;
        CGFloat xStep = SCREEN_WIDTH / (2 * xLen + 1);
        CGFloat xStartOffset = xStep;
        for (NSInteger i = 0; i < xLen; i++) {
            // 第一种使用 frame 来布局
            UIView *dot = [UIView new];
            dot.frame = CGRectMake(xStartOffset + 2 * xStep * i, yStartOffset + yIdx * 2 * yStep, xStep, yStep);
            
            dot.backgroundColor = [xColors objectAtIndex:i];
            [dots addObject:dot];
            
            [self.view addSubview:dot];
        }
    }];
}

@end
