//
//  FirstViewController.m
//  sample
//
//  Created by Liyu on 2017/4/20.
//  Copyright © 2017年 liyu. All rights reserved.
//

#import "FirstViewController.h"
#import "MusicViewController.h"
#import <AVFoundation/AVFoundation.h>

#define kDEGRE_TO_RADIANS(angel)  ((angel)/180*M_PI) 

typedef NS_ENUM(NSInteger, RotateState){
    RotateStateStop = 0,
    RotateStateRun
};

@interface FirstViewController () {
    //旋转角度
    CGFloat imageAngel;
    //旋转图片
    UIImageView *rotateImage;
    //旋转状态
    RotateState rotateState;
}

//音乐播放器
@property(nonatomic,strong)AVAudioPlayer *audioPlayer;

@end

@implementation FirstViewController

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"微信";
    [self setupRightBarButtonItem];
}

#pragma mark - setupRightBarButtonItem

- (void)setupRightBarButtonItem {
    rotateImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rightBarButtonImg"]];
    rotateImage.autoresizingMask = UIViewAutoresizingNone;
    rotateImage.contentMode = UIViewContentModeScaleToFill;
    rotateImage.bounds = CGRectMake(0, 0, 30, 30);
    rotateImage.layer.cornerRadius = 15;
    rotateImage.layer.masksToBounds = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button addSubview:rotateImage];
    rotateImage.center = button.center;
    [button addTarget:self action:@selector(runAnimation) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

#pragma mark - button target

- (void)runAnimation {
    if (rotateState == RotateStateStop) {
        rotateState = RotateStateRun;
        [self rotateAnimate];
        [self playMusic];
    } else {
        rotateState = RotateStateStop;
        [self stopMusic];
    }
}

#pragma mark - 旋转动画

- (void)rotateAnimate {
    imageAngel += 60;
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        rotateImage.transform = CGAffineTransformMakeRotation(kDEGRE_TO_RADIANS(imageAngel));
    } completion:^(BOOL finished) {
        if (rotateState == RotateStateRun) {
            [self rotateAnimate];
        }
    }];
}

#pragma mark - 开始播放音乐

- (void)playMusic {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"电音之王" ofType:@"mp3"];
    NSURL *musicUrl = [[NSURL alloc]initFileURLWithPath:filePath];
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicUrl error:nil];
    [_audioPlayer prepareToPlay];
    //循环次数，-1为无限循环
    _audioPlayer.numberOfLoops = -1;
    [_audioPlayer play];
}

#pragma mark - 关闭音乐

- (void)stopMusic {
    [_audioPlayer stop];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[MusicViewController new] animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
