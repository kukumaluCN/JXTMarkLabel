//
//  JXTProgressLabel.h
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


#import <UIKit/UIKit.h>

@interface JXTProgressLabel : UIView

@property (nonatomic, assign) CGFloat  clipWidth;             //进度控制视图宽度
@property (nonatomic, assign) CGFloat  dispProgress;          //显示进度(0,1)

@property (nonatomic, strong) UIColor  * foregroundTextColor; //前景label字体颜色
@property (nonatomic, strong) UIColor  * backgroundTextColor; //背景label字体颜色

@property (nonatomic, copy  ) NSString * text;                //label内容
@property (nonatomic, strong) UIFont   * font;                //label字体
@property (nonatomic, assign) NSTextAlignment textAlignment;  //label对齐模式

@end
