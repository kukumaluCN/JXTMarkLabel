//
//  ParallaxView.m
//  JXTMarkLabel
//
//  Created by JXT on 16/3/27.
//  Copyright © 2016年 JXT. All rights reserved.
//
//  ***
//  *   GitHub:https://github.com/kukumaluCN/JXTMarkLabel
//  *   博客:http://www.jianshu.com/users/c8f8558a4b1d/latest_articles
//  *   邮箱:1145049339@qq.com
//  ***

#import "ParallaxView.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ParallaxView ()

//顶层View
@property(nonatomic,strong) UIImageView * showView;
//中间层View
@property (nonatomic,strong) UIView * clipView;

@end

@implementation ParallaxView

- (instancetype)initWithImageName:(NSString *)name
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        
        self.frame = [UIScreen mainScreen].bounds;
        
        //滑块
        _clipView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, size.width, 100)];
        _clipView.backgroundColor = [UIColor whiteColor];
        //设置不显示超出的部分
        _clipView.clipsToBounds = YES;
        _clipView.userInteractionEnabled = YES;
        [self addSubview:_clipView];
        
        //显示
        _showView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        _showView.image = [UIImage imageNamed:name];
        [_clipView addSubview:_showView];
        
        //添加拖动手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView:)];
        [_clipView addGestureRecognizer:pan];
    }
    return self;
}

- (instancetype)initMagnifyingGlassWithImageName:(NSString *)name
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        
        self.frame = [UIScreen mainScreen].bounds;
        
        //滑块
        _clipView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 100, 100)];
        _clipView.backgroundColor = [UIColor whiteColor];
        _clipView.layer.cornerRadius = 50;
        _clipView.layer.masksToBounds = YES;
        //设置不显示超出的部分
        _clipView.clipsToBounds = YES;
        _clipView.userInteractionEnabled = YES;
        [self addSubview:_clipView];
        
        //显示
        _showView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        _showView.image = [UIImage imageNamed:name];

        [_clipView addSubview:_showView];
        
        //添加拖动手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView:)];
        [_clipView addGestureRecognizer:pan];
    }
    return self;
}

- (void)panView:(UIPanGestureRecognizer *)sender
{
    CGPoint pt = [sender translationInView:self];
    
    CGPoint clipCenter = _clipView.center;
    CGPoint showCenter = _showView.center;
    
    clipCenter.x += pt.x;
    clipCenter.y += pt.y;
    showCenter.x -= pt.x; //退行
    showCenter.y -= pt.y;
    
    _clipView.center = clipCenter;
    _showView.center = showCenter;
    
    [sender setTranslation:CGPointZero inView:self];
}

@end
