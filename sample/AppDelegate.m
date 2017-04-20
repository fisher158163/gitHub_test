//
//  AppDelegate.m
//  sample
//
//  Created by Liyu on 2017/4/19.
//  Copyright © 2017年 liyu. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+YYAdd.h"
#import "MainTabBarViewController.h"
#import "MusicViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    MainTabBarViewController *tabBarController = [[MainTabBarViewController alloc] init];
    self.window.rootViewController = tabBarController;
    tabBarController.selectedIndex = 0;
    [self.window makeKeyAndVisible];
    [self setupAppearance];
    [self setup3DTouch];
    return YES;
}

#pragma mark - setupAppearance

- (void)setupAppearance {
    // 导航栏全局属性设置：背景、左右标题的文字、标题文字
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRGB:0x36363B]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    NSDictionary *titleTextAttrs = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                     NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttrs];
   
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    UIImage *backImage = [UIImage imageNamed:@"NavigationBarBackBlackIcon"];
    [[UINavigationBar appearance] setBackIndicatorImage:backImage];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backImage];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - setup3DTouch

- (void)setup3DTouch {
    if ([[[UIDevice currentDevice] systemVersion]floatValue] >= 9.0) {
        
        UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc]initWithType:@"music" localizedTitle:@"点击播放" localizedSubtitle:@"电音之王" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay] userInfo:nil];
        
        UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc]initWithType:@"second" localizedTitle:@"添加" localizedSubtitle:@"新的心跳" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];
        
        UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc]initWithType:@"third" localizedTitle:@"分享" localizedSubtitle:@"迷迭香" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare] userInfo:nil];
        
        UIApplicationShortcutItem *item4 = [[UIApplicationShortcutItem alloc]initWithType:@"forth" localizedTitle:@"返回主页" localizedSubtitle:@"主页" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] userInfo:nil];
        NSArray *arr = [[NSArray alloc]initWithObjects:item4, item3, item2, item1, nil];
        [[UIApplication sharedApplication] setShortcutItems:arr];
    }
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = tabBarVC.viewControllers[0];
    if ([shortcutItem.type isEqualToString:@"music"]) {
        MusicViewController *musicVC = [[MusicViewController alloc]init];
        [nav pushViewController:musicVC animated:YES];
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
