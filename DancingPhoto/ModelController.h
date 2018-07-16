//
//  ModelController.h
//  DancingPhoto
//
//  Created by liang on 2018/7/16.
//  Copyright © 2018 liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPLayoutViewController.h"

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DPLayoutViewController *)viewControllerAtIndex:(NSUInteger)index;

- (NSUInteger)indexOfViewController:(DPLayoutViewController *)viewController;

@end

