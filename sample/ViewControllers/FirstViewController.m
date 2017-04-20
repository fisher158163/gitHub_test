//
//  FirstViewController.m
//  sample
//
//  Created by Liyu on 2017/4/20.
//  Copyright © 2017年 liyu. All rights reserved.
//

#import "FirstViewController.h"
#import "MusicViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"微信";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[MusicViewController new] animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
