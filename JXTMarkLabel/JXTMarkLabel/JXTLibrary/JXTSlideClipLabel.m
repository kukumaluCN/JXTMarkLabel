//
//  JXTSlideClipLabel.m
//  JXTMarkLabel
//
//  Created by JXT on 16/3/8.
//  Copyright © 2016年 JXT. All rights reserved.
//
//  ***
//  *   GitHub:https://github.com/kukumaluCN/JXTMarkLabel
//  *   博客:http://www.jianshu.com/users/c8f8558a4b1d/latest_articles
//  *   邮箱:1145049339@qq.com
//  ***

#import "JXTSlideClipLabel.h"

@interface JXTSlideClipLabel ()

//顶层View
@property(nonatomic,strong) UIView * showView;
//中间层View
@property(nonatomic,strong) UIView * clipView;

@end


@implementation JXTSlideClipLabel

- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArr
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat _width = self.frame.size.width / titleArr.count;
        
        //添加最里层Label
        for (int i = 0;i < titleArr.count ; i++)
        {
            [self addSubview:[self createLabel:titleArr[i] andFrame:CGRectMake(i*_width, 0, _width, self.frame.size.height) andColor:[UIColor whiteColor]]];
        }
        
        //滑块
        _clipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, self.frame.size.height)];
        _clipView.backgroundColor = [UIColor whiteColor];
        //设置不显示超出的部分
        _clipView.clipsToBounds = YES;
        _clipView.userInteractionEnabled = YES;
        [self addSubview:_clipView];
        
        //显示
        _showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        for (int i = 0; i < titleArr.count ; i++)
        {
            [_showView addSubview:[self createLabel:titleArr[i] andFrame:CGRectMake(i*_width, 0, _width, self.frame.size.height) andColor:[UIColor blackColor]]];
        }
        [_clipView addSubview:_showView];
        
        //添加拖动手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView:)];
        [_clipView addGestureRecognizer:pan];
    }
    return self;
}

-(void)panView:(UIPanGestureRecognizer *)sender
{
    CGPoint pt = [sender translationInView:self];
    
    CGPoint clipCenter = _clipView.center;
    CGPoint showCenter = _showView.center;
    
    clipCenter.x += pt.x;
    showCenter.x -= pt.x; //退行
    
    _clipView.center = clipCenter;
    _showView.center = showCenter;
    
    [sender setTranslation:CGPointZero inView:self];
}

- (UILabel *)createLabel:(NSString *)title andFrame:(CGRect)rect andColor:(UIColor *)color
{
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = color;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


@end
