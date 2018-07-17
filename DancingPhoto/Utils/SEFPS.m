//
//  SEFPS.m
//  SauronEye
//
//  Created by liang on 2018/6/22.
//  Copyright © 2018 liang. All rights reserved.
//

#import "SEFPS.h"

@interface SEFPS ()

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation SEFPS {
    NSUInteger _count;
    NSTimeInterval _lastTime;
}

- (void)showInWindow:(UIWindow *)win
{
    if (self.label.superview == nil) {
        self.label.frame = win.bounds;

        [win.rootViewController.view addSubview:self.label];

        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)tick:(CADisplayLink *)link
{
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }

    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) {
        return;
    }

    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;

    self.label.text = [NSString stringWithFormat:@"%0.0f", fps];

    if (fps < 55) {
        self.label.textColor = [UIColor redColor];
        self.label.alpha = 0.97f;
    } else {
        self.label.textColor = [UIColor whiteColor];
        self.label.alpha = 0.4f;
    }
}

- (void)removeFromSuperView
{
    [self.label removeFromSuperview];
    [self.link invalidate];
    self.link = nil;
}

- (void)dealloc
{
    self.label = nil;
}

#pragma mark - getter

- (UILabel *)label
{
    if (_label == nil) {
        _label = [UILabel new];
        _label.tag = 1023;
        _label.alpha = 0.8f;
        _label.layer.cornerRadius = 5;
        _label.clipsToBounds = YES;
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:14.f];

        _label.textAlignment = NSTextAlignmentCenter;
        _label.userInteractionEnabled = NO;
        _label.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    }
    return _label;
}
@end
