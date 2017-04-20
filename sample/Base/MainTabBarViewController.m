//
//  MainTabBarViewController.m
//  sample
//
//  Created by Liyu on 2017/4/20.
//  Copyright © 2017年 liyu. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "BaseNavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "UIColor+YYAdd.h"

@interface MainTabBarViewController ()

@property(nonatomic,assign)NSInteger indexFlag;

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
    self.selectedIndex = 0;
    self.indexFlag = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.selectedViewController endAppearanceTransition];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition:YES animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.selectedViewController endAppearanceTransition];
}

- (void)setupViewController {
    FirstViewController *firstVC = [[FirstViewController alloc]init];
    UINavigationController *firstNavigationViewController = [[BaseNavigationController alloc]initWithRootViewController:firstVC];
    UITabBarItem *item1 = [self creatTabBarItemWithTitle:@"微信" image:@"tabbar_mainframe" selectedImage:@"tabbar_mainframeHL" tag:0];
    firstNavigationViewController.tabBarItem = item1;
    
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    UINavigationController *secondNavigationViewController = [[BaseNavigationController alloc]initWithRootViewController:secondVC];
    UITabBarItem *item2 = [self creatTabBarItemWithTitle:@"通讯录" image:@"tabbar_contacts" selectedImage:@"tabbar_contactsHL" tag:1];
    secondNavigationViewController.tabBarItem = item2;
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc]init];
    UINavigationController *thirdNavigationViewController = [[BaseNavigationController alloc]initWithRootViewController:thirdVC];
    UITabBarItem *item3 = [self creatTabBarItemWithTitle:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discoverHL" tag:2];
    thirdNavigationViewController.tabBarItem = item3;
    
    ForthViewController *forthVC = [[ForthViewController alloc]init];
    UINavigationController *forthNavigationViewController = [[BaseNavigationController alloc]initWithRootViewController:forthVC];
    UITabBarItem *item4 = [self creatTabBarItemWithTitle:@"我" image:@"tabbar_me" selectedImage:@"tabbar_meHL" tag:3];
    forthNavigationViewController.tabBarItem = item4;
    self.viewControllers = @[firstNavigationViewController, secondNavigationViewController, thirdNavigationViewController, forthNavigationViewController];
    [self customizeAppearance];
}

- (UITabBarItem *)creatTabBarItemWithTitle:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName tag:(NSInteger)tag {
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imageName] tag:tag];
    tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return tabBarItem;
}

- (void)customizeAppearance {
    NSDictionary *attr = @{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:12]};
    [[UITabBarItem appearance] setTitleTextAttributes:attr forState:UIControlStateNormal];
    
    NSDictionary *selectedAttr = @{NSForegroundColorAttributeName:[UIColor colorWithRGB:0x1FB922], NSFontAttributeName:[UIFont systemFontOfSize:12]};
    [[UITabBarItem appearance] setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
}

#pragma mark - 给tabBar添加动画

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (self.indexFlag != index) {
        [self animationWithIndex:index];
    }
}

- (void)animationWithIndex:(NSInteger)index {
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.1;
    animation.repeatCount = 1;
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0.7];
    animation.toValue = [NSNumber numberWithFloat:1.2];
    [[tabBarButtonArray[index] layer] addAnimation:animation forKey:nil];
    self.indexFlag = index;
}

@end
