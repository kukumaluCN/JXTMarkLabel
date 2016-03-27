//
//  JXTHollowOutLabel.m
//  MySegmentController
//
//  Created by JXT on 16/1/14.
//  Copyright © 2016年 JXT. All rights reserved.
//
//  ***
//  *   GitHub:https://github.com/kukumaluCN/JXTMarkLabel
//  *   博客:http://www.jianshu.com/users/c8f8558a4b1d/latest_articles
//  *   邮箱:1145049339@qq.com
//  ***

#import "JXTHollowOutLabel.h"

@implementation JXTHollowOutLabel
{
    NSString * _text;
    UIFont * _font;
    UIColor * _backgroundColor;
    CGRect _frame;
}

#pragma mark - 重写对应的set方法
- (void)setText:(NSString *)text
{
    _text = text;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
}

//这个方法会出问题，因而重写置空
- (void)sizeToFit
{
    
}

- (instancetype)init//禁止使用此方法初始化
{
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _frame = frame;
    }
    return self;
}

#pragma mark - 绘制
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawSubtractedText:_text inRect:_frame inContext:context];
}

- (void)drawSubtractedText:(NSString *)text inRect:(CGRect)rect inContext:(CGContextRef)context
{
    //将当前图形状态推入堆栈
    CGContextSaveGState(context);
    
    //设置混合色
    CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
    
    //label上面添加label
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.font = _font;
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = _backgroundColor;
    
    [label.layer drawInContext:context];
    
    //把堆栈顶部的状态弹出，返回到之前的图形状态
    CGContextRestoreGState(context);
}


@end
