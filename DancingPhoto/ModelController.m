//
//  ModelController.m
//  DancingPhoto
//
//  Created by liang on 2018/7/16.
//  Copyright © 2018 liang. All rights reserved.
//

#import "ModelController.h"
#import "DPLayoutViewController.h"
#import "DPLayoutFrameController.h"
/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


NSString * const kPageTypeFrame = @"kPageTypeFrame";
NSString * const kPageTypeAnchor = @"kPageTypeAnchor";
NSString * const kPageTypeVFL = @"kPageTypeVFL";
NSString * const kPageTypeMasonry = @"kPageTypeMasonry";

@interface ModelController ()

@property (readonly, strong, nonatomic) NSArray *pageData;
@end

@implementation ModelController

- (instancetype)init {
    self = [super init];
    if (self) {
        // Create the data model.
        _pageData = @[kPageTypeFrame, kPageTypeAnchor, kPageTypeVFL, kPageTypeMasonry];
    }
    return self;
}

- (DPLayoutViewController *)viewControllerAtIndex:(NSUInteger)index {
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    NSString *pageType = self.pageData[index];
    if (pageType == kPageTypeFrame) {
        return [DPLayoutFrameController new];
    }
    
    DPLayoutViewController *vc = [DPLayoutViewController new];
    vc.pageType = pageType;
    return vc;
}


- (NSUInteger)indexOfViewController:(DPLayoutViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.pageType];
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DPLayoutViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DPLayoutViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

@end
