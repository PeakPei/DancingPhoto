//
//  DPWelcomeViewController.m
//  DancingPhoto
//
//  Created by liang on 2018/7/17.
//  Copyright © 2018 liang. All rights reserved.
//

#import "DPWelcomeViewController.h"

@interface DPWelcomeViewController ()
{
    UILabel *_tip;
}

@end

@implementation DPWelcomeViewController

- (void)viewDidLoad {
    self.pageType = kPageWelcome;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITextView *t = [UITextView new];
    t.font = [UIFont systemFontOfSize:14.f weight:UIFontWeightBold];
    t.text = @"本 demo 意在展示多种不同的布局方式的性能差异\n\
    1. frame 直接布局\n\
    2. 使用 VFL 语句布局\n\
    3. 使用 layoutAnchor 布局\n\
    4. 使用 masonry 布局\n\n\
    点击下面的按钮，获取图片资源，然后左右滑动";

    [self.view addSubview:t];
    
    t.translatesAutoresizingMaskIntoConstraints = NO;
    [t.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    [t.heightAnchor constraintEqualToConstant:140].active = YES;
    [t.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:15].active = YES;
    [t.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-15].active = YES;
    
    UIButton *load = [UIButton new];
    [load setTitle:@"预先加载图片资源" forState:UIControlStateNormal];
    [load setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [load addTarget:self action:@selector(preload:) forControlEvents:UIControlEventTouchUpInside];
    load.layer.borderColor = [UIColor lightTextColor].CGColor;
    load.layer.borderWidth = ONE_PIXEL;
    load.layer.cornerRadius = 1.5f;
    
    [load sizeToFit];
    [self.view addSubview:load];
    
    load.translatesAutoresizingMaskIntoConstraints = NO;
    [load.topAnchor constraintEqualToAnchor:t.bottomAnchor constant:60.f].active = YES;
    [load.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    // 提示
    UILabel *l = [UILabel new];
    l.text = @"未加载";
    l.textColor = [UIColor lightGrayColor];
    [l sizeToFit];
    _tip = l;
    [self.view addSubview:l];
    
    l.translatesAutoresizingMaskIntoConstraints = NO;
    [l.topAnchor constraintEqualToAnchor:load.bottomAnchor constant:20].active = YES;
    [l.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
}

#pragma mark - event

- (void)preload:(UIButton *)button
{
    _tip.text = @"开始加载~";
    [_tip sizeToFit];
    [self.class colorMatrix];
    _tip.text = @"加载完毕";
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
