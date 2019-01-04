//
//  WaterWaveView.h
//  YSTModule
//
//  Created by 李晨芳 on 2018/6/26.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterWaveView : UIView

/** 波浪的宽（默认为屏幕宽度） */
@property (nonatomic, assign) CGFloat waveWidth;
/** 波浪的高（默认为10） */
@property (nonatomic, assign) CGFloat waveHeight;
/** 波浪背景颜色（默认为白色） */
@property (nonatomic, strong) UIColor *waveColor;
/** 速度（默认为2.5f） */
@property (nonatomic, assign) CGFloat waveSpeed;
/** 波浪x位移（默认为0）*/
@property (nonatomic, assign) CGFloat waveOffsetX;
/** 波浪Y值（默认为44）*/
@property (nonatomic, assign) CGFloat wavePointY;
/** 振幅（默认为10） */
@property (nonatomic, assign) CGFloat waveAmplitude;
/** 周期 */
@property (nonatomic, assign) CGFloat waveCycle;

/*
 *初始化方法
 *frame      尺寸
 *startColor 开始颜色
 *endColor   结束颜色
 */
- (instancetype)initWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor;
@end
