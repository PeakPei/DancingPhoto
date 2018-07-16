//
//  DPLayoutViewController.m
//  DancingPhoto
//
//  Created by liang on 2018/7/16.
//  Copyright © 2018 liang. All rights reserved.
//

#import "DPLayoutViewController.h"
#import "UIView+ColorOfPoint.h"

@interface DPLayoutViewController ()

@end

@implementation DPLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *t = [UILabel new];
    if (self.pageType.length > 0) {
        t.text = self.pageType;
    } else {
        t.text = @"demo 2 83";
    }
    [self.view addSubview:t];
    t.frame = CGRectMake(0, 100, 200, 30);
    
}

// 保存了图片在平面的隔行扫描后的结果，是个二位数组
+ (NSArray<NSArray *> *)colorMatrix
{
    static NSMutableArray *matrix = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        matrix = [NSMutableArray arrayWithCapacity:200];
        
        UIImage *tron = [UIImage imageNamed:@"img-source"];
        NSLog(@"开始处理了，有点慢先等等，图片尺寸是%@", NSStringFromCGSize(tron.size));
        long long startTime = [[NSDate date] timeIntervalSince1970];

        UIImageView *imgView = [[UIImageView alloc] initWithImage:tron];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.frame = CGRectMake(0, 0, MIN(SCREEN_WIDTH, tron.size.width), MIN(tron.size.height, SCREEN_HEIGHT));
        
        // 两层循环，先 x 轴，再 y 轴
        for (NSInteger j = 0; j < CGRectGetHeight(imgView.bounds); j += yStepPixel) {
            NSMutableArray *xColors = [NSMutableArray arrayWithCapacity:100];
            for (NSInteger i = 0; i < CGRectGetWidth(imgView.bounds); i += xStepPixel) {
                CGPoint point = CGPointMake(i, j);
                [xColors addObject:[imgView colorOfPoint:point]];
            }
            [matrix addObject:xColors];
        }
        
        NSLog(@"处理结束，耗时：%f", [[NSDate date] timeIntervalSince1970] - startTime);
    });
    
    return matrix;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
