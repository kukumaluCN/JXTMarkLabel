//
//  JXTProgressLabel.m
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

#import "JXTProgressLabel.h"

@interface JXTProgressLabel ()

@property (nonatomic, strong) UILabel  * foregroundLabel;
@property (nonatomic, strong) UILabel  * backgroundLabel;

@property (nonatomic, strong) UIView * clipView;

@end

@implementation JXTProgressLabel

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {//需要先获取frame
        [self addSubview:self.backgroundLabel];
        [self.clipView addSubview:self.foregroundLabel];
        [self addSubview:self.clipView];
    }
    return self;
}

#pragma mark - 不支持下面的初始化方法
- (instancetype)init
{
    return nil;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return nil;
}

#pragma mark - 设置前景、背景label
- (UILabel *)foregroundLabel
{
    if (!_foregroundLabel) {
        _foregroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    }
    return _foregroundLabel;
}
- (UILabel *)backgroundLabel
{
    if (!_backgroundLabel) {
        _backgroundLabel = [[UILabel alloc] initWithFrame:self.bounds];
    }
    return _backgroundLabel;
}

#pragma mark - 设置进度控制view
- (UIView *)clipView
{
    if (!_clipView) {
        _clipView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 0, self.bounds.size.height)];
        _clipView.clipsToBounds = YES;
        _clipView.backgroundColor = [UIColor clearColor];
    }
    return _clipView;
}

#pragma mark - 进度控制视图宽度
- (void)setClipWidth:(CGFloat)clipWidth
{
    CGRect rect = self.clipView.frame;
    rect.size.width = clipWidth;
    self.clipView.frame = rect;
}
- (CGFloat)clipWidth
{
    return self.clipView.frame.size.width;
}

#pragma mark - 显示进度，小数
- (void)setDispProgress:(CGFloat)dispProgress
{
    CGRect rect = self.clipView.frame;
    rect.size.width = dispProgress * self.bounds.size.width;
    self.clipView.frame = rect;
}
- (CGFloat)dispProgress
{
    return self.clipView.frame.size.width / self.bounds.size.width;
}

#pragma mark - 前景、背景字体颜色
- (void)setBackgroundTextColor:(UIColor *)backgroundTextColor
{
    self.backgroundLabel.textColor = backgroundTextColor;
}
- (void)setForegroundTextColor:(UIColor *)foregroundTextColor
{
    self.foregroundLabel.textColor = foregroundTextColor;
}

#pragma mark - label相关设置
- (void)setFont:(UIFont *)font
{
    self.foregroundLabel.font = font;
    self.backgroundLabel.font = font;
}
- (void)setText:(NSString *)text
{
    self.foregroundLabel.text = text;
    self.backgroundLabel.text = text;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    self.foregroundLabel.textAlignment = textAlignment;
    self.backgroundLabel.textAlignment = textAlignment;
}

@end
