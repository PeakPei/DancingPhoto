//
//  ModelController.h
//  DancingPhoto
//
//  Created by liang on 2018/7/16.
//  Copyright © 2018 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义 4 种不同的布局方式
extern NSString * const kPageTypeFrame;
extern NSString * const kPageTypeAnchor;
extern NSString * const kPageTypeVFL;
extern NSString * const kPageTypeMasonry;

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end

