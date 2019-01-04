//
//  AnimationGroup.m
//  AnimationDemo
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "AnimationGroupVC.h"

@interface AnimationGroupVC (){
    UIImageView *goodsView;
}

@end

@implementation AnimationGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    //商品图片
    goodsView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon1"]];
//    goodsView.backgroundColor = [UIColor grayColor];
    goodsView.frame = CGRectMake(0, 64, 50, 50);
    [self.view addSubview:goodsView];
    
    //点击加入购物车
    UIButton * beginBtn = [Tools createBtnTitle:@"加入购物车" Selector:@selector(animationBegin) target:self];
    [self.view addSubview:beginBtn];
    [beginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(100);
        make.top.equalTo(@375);
    }];
    
    //购物车图片
    UIImageView * shoppingIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ShoppingCartIcon"]];
    [self.view addSubview:shoppingIcon];
    [shoppingIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(70);
        make.top.equalTo(@375);
        make.left.equalTo(@265);
    }];

}

-(void)animationBegin{
    //贝塞尔曲线路径
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:CGPointMake(0.0, 64.0)];
    [movePath addQuadCurveToPoint:CGPointMake(300, 400) controlPoint:CGPointMake(400, 200)];
    
    //关键帧动画（设置位置）
    CAKeyframeAnimation * posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.path = movePath.CGPath;
    posAnim.removedOnCompletion = YES;
    
    //缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 1.0)];
    
    //旋转动画
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//围绕Y轴方向旋转
    rotationAnimation.duration = 0.2;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(M_PI);//旋转一周
    rotationAnimation.removedOnCompletion = YES;
    
    //透明度动画
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.6];
    opacityAnim.removedOnCompletion = YES;

    //动画组
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:posAnim, scaleAnimation,rotationAnimation, opacityAnim,nil];
    animGroup.duration = 1;
    animGroup.autoreverses = YES;
    animGroup.fillMode = kCAFillModeForwards;
    [goodsView.layer addAnimation:animGroup forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
