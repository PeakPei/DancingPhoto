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
    self.dots = dots;
    // 将这些颜色画到界面
    // 颜色的矩阵不会大于整个 view 的尺寸，因为采样的时候已经保证了这一点
    // 前提：间距 为 1 像素，元素尺寸需要计算
    CGFloat oneUnit = ONE_PIXEL;
    // 先计算 y 的步进和起步偏移
    NSInteger yLen = colorMatrix.count;
    CGFloat yGap = oneUnit;
    CGFloat yStep = (SCREEN_HEIGHT - yGap * (yLen + 1)) /  yLen ;
    CGFloat yStartOffset = 1;
    
    NSLog(@"开始画图");
    long long startTime = [[NSDate date] timeIntervalSince1970];
    
    [colorMatrix enumerateObjectsUsingBlock:^(NSArray * _Nonnull xColors, NSUInteger yIdx, BOOL * _Nonnull stop) {
        
        // 计算横行步进。因为采样的长度是不足于屏幕的尺寸的
        NSInteger xLen = xColors.count;
        CGFloat xGap = oneUnit;
        CGFloat xStep = (SCREEN_WIDTH - xGap * (xLen + 1) ) / xLen;
        CGFloat xStartOffset = 1;
        for (NSInteger i = 0; i < xLen; i++) {
            // 第一种使用 frame 来布局
            UIView *dot = [UIView new];
            dot.frame = CGRectMake(xStartOffset + (xGap + xStep) * i, yStartOffset + yIdx * (yStep + yGap), xStep, yStep);
            
            dot.backgroundColor = [xColors objectAtIndex:i];
            // 用投机取巧的方式保存最原始的 center；
            dot.accessibilityValue = [NSString stringWithFormat:@"%f-%f", dot.center.x, dot.center.y];
            
            [dots addObject:dot];
            
            [self.view addSubview:dot];
        }
    }];
    
    NSLog(@"画图结束，耗时：%f", [[NSDate date] timeIntervalSince1970] - startTime);
    
//    //  播放按钮
//    UIButton *play = [UIButton new];
//    [play setTitle:@"播放动画" forState:UIControlStateNormal];
//    [play setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    play.backgroundColor = [UIColor whiteColor];
//    play.frame = CGRectMake(15, 80, 0, 0);
//    [play sizeToFit];
//    [self.view addSubview:play];
//
//    [play addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - event

- (void)play:(id)sender
{
    [self startWave];
}

static NSInteger kActiveGroupSize = 200;
static NSInteger kActiveOffset = 0;
- (void)onMusicPowerChange:(float)average peak:(float)peak
{
    
    CGFloat amplitudeDistance = 20.f;
    kActiveOffset += kActiveGroupSize;
    NSInteger len = self.dots.count;
    
    NSInteger offset = kActiveOffset % len;
    kActiveOffset = offset;
    
    [[self.dots subarrayWithRange:NSMakeRange(offset, MIN(kActiveGroupSize, len - offset))]  enumerateObjectsUsingBlock:^(UIView * _Nonnull dot, NSUInteger idx, BOOL * _Nonnull stop) {
       // 只做 y 轴上的震荡
        NSArray *accArr = [dot.accessibilityValue componentsSeparatedByString:@"-"];
        if (accArr.count == 2) {
            CGPoint original = CGPointMake([[accArr firstObject] floatValue], [[accArr lastObject] floatValue]);
            dot.center = CGPointMake(original.x, original.y + amplitudeDistance * peak);
        }
    }];
}

@end
