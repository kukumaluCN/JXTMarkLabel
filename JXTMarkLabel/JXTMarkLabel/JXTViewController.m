//
//  JXTViewController.m
//  JXTMarkLabel
//
//  Created by JXT on 16/3/6.
//  Copyright © 2016年 JXT. All rights reserved.
//
//  ***
//  *   GitHub:https://github.com/kukumaluCN/JXTMarkLabel
//  *   博客:http://www.jianshu.com/users/c8f8558a4b1d/latest_articles
//  *   邮箱:1145049339@qq.com
//  ***

#import "JXTViewController.h"

#import "JXTProgressLabel.h"
#import "JXTHollowOutLabel.h"
#import "JXTSlideClipLabel.h"
#import "ParallaxView.h"

#import "ParallaxViewController.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface JXTViewController ()

@property (nonatomic, strong) JXTProgressLabel * progressLabel;
@property (nonatomic, strong) JXTProgressLabel * progressLabel2;

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) NSTimer * timer2;
@property (nonatomic, strong) NSTimer * timer3;

@property (nonatomic, strong) JXTHollowOutLabel * hollowOutLabel;
@property (nonatomic, strong) UIView * hollowBkView;


@end

@implementation JXTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  1.
    [self createProgressLabel];
    
    //  2.
    [self createHollowPutLabel];
    
    //  3.
    [self createSlideClipLabel];
    
    //  4.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(gotoNext)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(gotoNext2)];
}
- (void)gotoNext
{
    ParallaxViewController * parallaxVC = [[ParallaxViewController alloc] init];
    parallaxVC.style = 1;
    [self.navigationController pushViewController:parallaxVC animated:YES];
}
- (void)gotoNext2
{
    ParallaxViewController * parallaxVC = [[ParallaxViewController alloc] init];
    parallaxVC.style = 2;
    [self.navigationController pushViewController:parallaxVC animated:YES];
}

#pragma mark - 切边字
- (void)createSlideClipLabel
{
    NSArray * titleArr = @[@"水星", @"金星", @"地球", @"火星", @"木星", @"土星"];

    JXTSlideClipLabel * label = [[JXTSlideClipLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_hollowBkView.frame) + 80, self.view.frame.size.width, 80) andTitleArray:titleArr];
    label.backgroundColor = [UIColor blackColor];
    [self.view addSubview:label];
}

#pragma mark - 镂空字label
- (void)createHollowPutLabel
{
    _hollowBkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 60)];
    _hollowBkView.center = CGPointMake(ScreenWidth / 2., CGRectGetMaxY(_progressLabel2.frame) + 100);
    _hollowBkView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_hollowBkView];
    
    _hollowOutLabel = [[JXTHollowOutLabel alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
    _hollowOutLabel.text = @"这是一行镂空文字";
    _hollowOutLabel.backgroundColor = [UIColor blackColor];
//    _hollowOutLabel.alpha = 0.7;
    _hollowOutLabel.font = [UIFont boldSystemFontOfSize:20];
    _hollowOutLabel.textAlignment = NSTextAlignmentCenter;
    [_hollowBkView addSubview:_hollowOutLabel];
    
    UIButton * start = [UIButton buttonWithType:UIButtonTypeCustom];
    [start setTitle:@"变色" forState:UIControlStateNormal];
    [start setTitle:@"停止" forState:UIControlStateSelected];
    [start setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [start setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [start addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    start.bounds = CGRectMake(0, 0, 80, 40);
    start.backgroundColor = [UIColor orangeColor];
    start.center = CGPointMake(ScreenWidth / 2, CGRectGetMaxY(_hollowBkView.frame) + 30);
    [self.view addSubview:start];
}
- (void)changeColor:(UIButton *)btn
{
    btn.selected = !btn.selected;
    static BOOL flag = 0;
    flag = !flag;
    if (flag) {
        [_timer3 invalidate];
        _timer3 = nil;
        _timer3 = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(randomColor) userInfo:nil repeats:YES];
    }
    else {
        [_timer3 invalidate];
        _timer3 = nil;
    }
}
- (void)randomColor
{
    _hollowBkView.backgroundColor = [UIColor colorWithRed:arc4random()%256/255. green:arc4random()%256/255. blue:arc4random()%256/255. alpha:0.6];
}


#pragma mark - progressLabel的使用
- (void)createProgressLabel
{
    _progressLabel = [[JXTProgressLabel alloc] initWithFrame:CGRectMake(0, 0, 220, 50)];
    _progressLabel.center = CGPointMake(ScreenWidth / 2, 50 + 64);
    _progressLabel.backgroundColor = [UIColor lightGrayColor];
    _progressLabel.backgroundTextColor = [UIColor whiteColor];
    _progressLabel.foregroundTextColor = [UIColor orangeColor];
    _progressLabel.text = @"显示一句话，看着像歌词";
    _progressLabel.textAlignment = NSTextAlignmentLeft;
    _progressLabel.font = [UIFont systemFontOfSize:20];
//    _progressLabel.clipWidth = 47;
    [self.view addSubview:_progressLabel];
    
    _progressLabel2 = [[JXTProgressLabel alloc] initWithFrame:CGRectMake(0, 0, 220, 50)];
    _progressLabel2.center = CGPointMake(ScreenWidth / 2, 105 + 64);
    _progressLabel2.backgroundColor = [UIColor lightGrayColor];
    _progressLabel2.backgroundTextColor = [UIColor whiteColor];
    _progressLabel2.foregroundTextColor = [UIColor redColor];
    _progressLabel2.text = @"显示一句话，看着像歌词";
    _progressLabel2.textAlignment = NSTextAlignmentLeft;
    _progressLabel2.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_progressLabel2];
    
    UIButton * start = [UIButton buttonWithType:UIButtonTypeCustom];
    [start setTitle:@"模式1" forState:UIControlStateNormal];
    [start setTitle:@"进行中" forState:UIControlStateSelected];
    [start setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [start setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [start addTarget:self action:@selector(model_1:) forControlEvents:UIControlEventTouchUpInside];
    start.bounds = CGRectMake(0, 0, 80, 40);
    start.backgroundColor = [UIColor yellowColor];
    start.center = CGPointMake(ScreenWidth / 2 - 80, CGRectGetMaxY(_progressLabel2.frame) + 30);
    [self.view addSubview:start];
    
    UIButton * start2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [start2 setTitle:@"模式2" forState:UIControlStateNormal];
    [start2 setTitle:@"进行中" forState:UIControlStateSelected];
    [start2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [start2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [start2 addTarget:self action:@selector(model_2:) forControlEvents:UIControlEventTouchUpInside];
    start2.bounds = CGRectMake(0, 0, 80, 40);
    start2.backgroundColor = [UIColor yellowColor];
    start2.center = CGPointMake(ScreenWidth / 2 + 80, CGRectGetMaxY(_progressLabel2.frame) + 30);
    [self.view addSubview:start2];
}

- (void)model_1:(UIButton *)btn
{
    btn.selected = !btn.selected;
    static BOOL flag = 0;
    flag = !flag;
    if (flag) {
        [_timer invalidate];
        _timer = nil;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(progress1) userInfo:nil repeats:YES];
    }
    else {
        [_timer invalidate];
        _timer = nil;
    }
}
- (void)model_2:(UIButton *)btn
{
    btn.selected = !btn.selected;
    static BOOL flag = 0;
    flag = !flag;
    if (flag) {
        [_timer2 invalidate];
        _timer2 = nil;
        _timer2 = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(progress2) userInfo:nil repeats:YES];
    }
    else {
        [_timer2 invalidate];
        _timer2 = nil;
    }
}
- (void)progress1
{
    static BOOL flag;
    
    if (!flag) {
        _progressLabel.clipWidth ++;
        if (_progressLabel.clipWidth > _progressLabel.frame.size.width) {
            flag = !flag;
        }
    }
    else {
        _progressLabel.clipWidth --;
        if (_progressLabel.clipWidth == 0) {
            flag = !flag;
        }
    }
}
- (void)progress2
{
    _progressLabel2.dispProgress += 0.01;
    if (_progressLabel2.dispProgress >= 1) {
        _progressLabel2.dispProgress = 0;
    }
}


- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
    [_timer2 invalidate];
    _timer2 = nil;
    [_timer3 invalidate];
    _timer3 = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
