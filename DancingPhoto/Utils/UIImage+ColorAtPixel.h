//
//  UIImage+ColorAtPixel.h
//  DancingPhoto
//
//  Created by liang on 2018/7/16.
//  Copyright © 2018 liang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN
//https://blog.csdn.net/shouqiangwei/article/details/25324017
@interface UIImage (ColorAtPixel)

- (UIColor *)colorAtPixel:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
