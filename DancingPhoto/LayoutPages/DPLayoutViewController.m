//
//  DPLayoutViewController.m
//  DancingPhoto
//
//  Created by liang on 2018/7/16.
//  Copyright © 2018 liang. All rights reserved.
//

#import "DPLayoutViewController.h"
#import "UIView+ColorOfPoint.h"

#import <AVFoundation/AVFoundation.h>

@interface DPLayoutViewController (){
    
    NSTimer *_recordTimer;
    
    AVAudioPlayer *_audioPlayer;
}


@end

@implementation DPLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.pageType.length > 0) {
        UILabel *t = [UILabel new];
        t.text = self.pageType;
        [self.view addSubview:t];
        t.backgroundColor = [UIColor whiteColor];
        [t sizeToFit];
        
        [t mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).mas_offset(30);
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];
    }
    
    NSLog(@"View name = %@", self.pageType);
}

#pragma mark - play music
- (void)startWave
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Derezzed-16432761" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSLog(@"url is %@", url);
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    NSLog(@"player is %@", _audioPlayer);
    // LiMo Linux Mobile
    
    [_audioPlayer setMeteringEnabled:YES];
    // 通过setMeteringEnabled:YES] 开启波形
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
    

    [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(refreshWaveView:) userInfo:nil repeats:YES];
}


#define XMAX    20.0f
- (void) refreshWaveView:(id) arg{
    [_audioPlayer updateMeters];

    // 通知audioPlayer 说我们要去平均波形和最大波形

    float aa = pow(10, (0.05 * [_audioPlayer averagePowerForChannel:0]));
    float pp = pow(10, (0.05 * [_audioPlayer peakPowerForChannel:0]));
    
    NSLog(@"average2 is %f peak %f", aa, pp);
    if ([self respondsToSelector:@selector(onMusicPowerChange:peak:)]) {
        [self onMusicPowerChange:aa peak:pp];
    }
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

- (void)onMusicPowerChange:(float)average peak:(float)peak {
    //
    NSLog(@"not yet");
}



@end
