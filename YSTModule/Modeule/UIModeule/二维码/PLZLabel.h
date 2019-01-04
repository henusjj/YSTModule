//
//  PLZLabel.h
//  YSTNewGreatWallMedium
//
//  Created by penglaizhi on 2017/12/14.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLZLabel : UILabel
@property (nonatomic, assign) UIEdgeInsets textInsets; // 控制字体与控件边界的间隙

#pragma mark--创建加粗的label
+ (UILabel *)creatLabelBoldFont:(CGFloat )font color:(NSString *)color title:(NSString *)title;

#pragma mark--创建普通的label
+ (UILabel *)creatLabelFont:(CGFloat )font color:(NSString *)color title:(NSString *)title;

#pragma mark--带背景色的label
+(UILabel *)creatLabelFont:(CGFloat )font backGroundColor:(NSString *)backGroundColor color:(NSString *)color title:(NSString *)title;

#pragma mark--带行间距的label
+(UILabel *)creatLineSizeLabelFont:(CGFloat )font color:(NSString *)color title:(NSString *)title spacing:(CGFloat)spacing;

#pragma mark--带frame与居中方式的label
//+(UILabel *)creatLabelFont:(CGFloat )font color:(NSString *)color title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment frame:(CGRect)frame;

#pragma mark--带frame与居中方式的label包括字体和大小
+(UILabel *)creatLabelFont:(CGFloat )size fontText:(NSString *)FontText color:(NSString *)color title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment frame:(CGRect)frame;

#pragma mark--带frame与居中方式的label包括字体和大小---(传font)
+(UILabel *)creatLabelFontNew:(UIFont *)font color:(NSString *)color title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment frame:(CGRect)frame;

//#pragma mark - 创建标签label
//+(UILabel *)creatTagLabelFont:(CGFloat )font fontText:(NSString *)FontText color:(NSString *)color title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment frame:(CGRect)frame;
//

@end
