//
//  AppDelegate.m
//  DancingPhoto
//
//  Created by liang on 2018/7/16.
//  Copyright © 2018 liang. All rights reserved.
//

#import "AppDelegate.h"
#import "SEFPS.h"

@interface AppDelegate ()

@property (nonatomic, strong) UIWindow *fpsWin;

@property (nonatomic, strong) SEFPS *fps;

/**
 记录上次拖动的位移，两者做差值，来计算此次拖动的距离。
 */
@property (nonatomic, assign) CGPoint lastOffset;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIWindow *window = [[UIWindow alloc] initWithFrame: CGRectMake(15, 150, 35, 20.f)];
    UIViewController *vc = [[UIViewController alloc] init];
    window.rootViewController = vc;
    window.backgroundColor = [UIColor clearColor];
    window.windowLevel = UIWindowLevelStatusBar + 14;
    window.hidden = NO;
    self.fpsWin = window;
    
    SEFPS *fps = [SEFPS new];
    [fps showInWindow: window];
    
    self.fps = fps;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDragFpsWin:)];//创建手势
    window.userInteractionEnabled = YES;
    [window addGestureRecognizer:pan];
    
    return YES;
}

- (void)handleDragFpsWin:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.lastOffset = CGPointZero;
    }
    // 注意：这里的 offset 是相对于在手势开始之前的位置作为基准，和当前手势做差值得出来的位移
    CGPoint offset = [pan translationInView:self.fpsWin];
    //    SELog(@"drag %@", NSStringFromCGPoint(offset));
    CGRect newFrame = CGRectOffset(self.fpsWin.frame, offset.x - self.lastOffset.x, offset.y - self.lastOffset.y);
    //    SELog(@"drag new %@", NSStringFromCGRect(newFrame));
    self.fpsWin.frame = newFrame;
    
    self.lastOffset = offset;
    
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateFailed) {
        self.lastOffset = CGPointZero;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
