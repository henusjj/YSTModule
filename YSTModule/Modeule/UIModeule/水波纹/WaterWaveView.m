
//
//  WaterWaveView.m
//  YSTModule
//
//  Created by 李晨芳 on 2018/6/26.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "WaterWaveView.h"

@interface WaterWaveView()
/** 开始颜色 */
@property (nonatomic, strong) UIColor *startColor;
/** 结束颜色 */
@property (nonatomic, strong) UIColor *endColor;
/** 画水波图 */
@property (nonatomic, strong) CAShapeLayer *shapeLayerOne;
/** 画水波图 */
@property (nonatomic, strong) CAShapeLayer *shapeLayerTwo;
/** 让我们以屏幕刷新率相同的频率将内容画到屏幕上的定时器 */
@property (nonatomic, strong) CADisplayLink *displayLink;
/** 渐变特效 */
@property (nonatomic, strong) CAGradientLayer *gradientLayerOne;
/** 渐变特效 */
@property (nonatomic, strong) CAGradientLayer *gradientLayerTwo;
@end

@implementation WaterWaveView
- (instancetype)initWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    if (self = [super initWithFrame:frame]) {
        _startColor = startColor;
        _endColor = endColor;
        self.backgroundColor = [UIColor whiteColor];
        //进行裁剪
        self.layer.masksToBounds = YES;
        //配置波浪参数
        [self ConfigParams];
        //加载水波
        [self LoadWaterWaves];
    }
    return self;
}
#pragma mark 配置参数
- (void)ConfigParams{
    if (!_waveWidth) {
        _waveWidth = self.frame.size.width;
    }
    if (!_waveHeight) {
        _waveHeight = 10;
    }
    if (!_waveColor) {
        _waveColor = [UIColor whiteColor];
    }
    if (!_waveSpeed) {
        _waveSpeed = 2.5f;
    }
    if (!_waveOffsetX) {
        _waveOffsetX = 0;
    }
    if (!_wavePointY) {
        _wavePointY = 44;
    }
    if (!_waveAmplitude) {
        _waveAmplitude = 10;
    }
    if (!_waveCycle) {
        _waveCycle =  1.29 * M_PI / _waveWidth;
    }
}
#pragma mark 加载水波Layer ，绑定到runloop的NSRunLoopCommonModes模式中，用于刷新帧动画
- (void)LoadWaterWaves{
    [self.layer addSublayer:self.shapeLayerOne];
    [self.layer addSublayer:self.shapeLayerTwo];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
#pragma mark - 帧动画
- (void)getCurrentWave{
    //增加x的偏移
    _waveOffsetX += _waveSpeed;
    //改变第一条的路径
    [self changeFirstWaveLayerPath];
    //改变第二条的路径
    [self changeSecondWaveLayerPath];
    
    [self.layer addSublayer:self.gradientLayerOne];
    self.gradientLayerOne.mask = _shapeLayerOne;
    
    [self.layer addSublayer:self.gradientLayerTwo];
    self.gradientLayerTwo.mask = _shapeLayerTwo;
}
#pragma mark - 路径
- (void)changeFirstWaveLayerPath {
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = _wavePointY;
    
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <= _waveWidth; x ++) {
        y = _waveAmplitude * 1.6 * sin((250 / _waveWidth) * (x * M_PI / 180) - _waveOffsetX * M_PI / 270) + _wavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, _waveWidth, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    CGPathCloseSubpath(path);
    
    _shapeLayerOne.path = path;
    CGPathRelease(path);
}
- (void)changeSecondWaveLayerPath {
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = _wavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <= _waveWidth; x ++) {
        
        y = _waveAmplitude * 1.6 * sin((250 / _waveWidth) * (x * M_PI / 180) - _waveOffsetX * M_PI / 180) + _wavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, _waveWidth, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    CGPathCloseSubpath(path);
    
    _shapeLayerTwo.path = path;
    
    CGPathRelease(path);
}
#pragma mark 懒加载
//水波图
- (CAShapeLayer *)shapeLayerOne {
    if (!_shapeLayerOne) {
        _shapeLayerOne = [CAShapeLayer layer];
    }
    return _shapeLayerOne;
}
//水波图
- (CAShapeLayer *)shapeLayerTwo {
    if (!_shapeLayerTwo) {
        _shapeLayerTwo = [CAShapeLayer layer];
    }
    return _shapeLayerTwo;
}
//刷新定时器
- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    }
    return _displayLink;
}
- (CAGradientLayer *)gradientLayerOne {
    if (!_gradientLayerOne) {
        _gradientLayerOne = [CAGradientLayer layer];
        _gradientLayerOne.frame = self.bounds;
        _gradientLayerOne.colors = @[(__bridge id)self.startColor.CGColor,
                                     (__bridge id)self.endColor.CGColor];
        _gradientLayerOne.locations = @[@0, @1.0];
        _gradientLayerOne.startPoint = CGPointMake(0, 0);
        _gradientLayerOne.endPoint = CGPointMake(1.0, 0);
    }
    return _gradientLayerOne;
}

- (CAGradientLayer *)gradientLayerTwo {
    if (!_gradientLayerTwo) {
        _gradientLayerTwo = [CAGradientLayer layer];
        _gradientLayerTwo.frame = self.bounds;
        _gradientLayerTwo.colors = @[(__bridge id)self.startColor.CGColor,
                                     (__bridge id)self.endColor.CGColor];
        _gradientLayerTwo.locations = @[@0, @1.0];
        _gradientLayerTwo.startPoint = CGPointMake(0, 0);
        _gradientLayerTwo.endPoint = CGPointMake(1.0, 0);
    }
    return _gradientLayerTwo;
}

- (void)dealloc {
    [_displayLink invalidate];
    _displayLink = nil;
}

@end
