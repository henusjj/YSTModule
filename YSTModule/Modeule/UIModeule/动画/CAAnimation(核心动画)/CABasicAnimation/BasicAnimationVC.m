//
//  BasicAnimationVC.m
//  AnimationDemo
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.//

#import "BasicAnimationVC.h"

@interface BasicAnimationVC (){
    UIView * imageView;
}

@end

@implementation BasicAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 = [Tools createBtnTitle:@"移动" Selector:@selector(AnimationClick:) target:self];
    btn1.tag = 0;
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = [Tools createBtnTitle:@"旋转" Selector:@selector(AnimationClick:) target:self];
    btn2.tag = 1;
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [Tools createBtnTitle:@"缩放" Selector:@selector(AnimationClick:) target:self];
    btn3.tag = 2;
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [Tools createBtnTitle:@"平移" Selector:@selector(AnimationClick:) target:self];
    btn4.tag = 3;
    [self.view addSubview:btn4];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@gap);
        make.right.equalTo(@-gap);
        make.top.equalTo(self.view.mas_top).offset(80);
        make.height.mas_equalTo(btnHeight);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.mas_bottom).offset(20);
        make.left.equalTo(@gap);
        make.right.equalTo(@-gap);
        make.height.mas_equalTo(btnHeight);
    }];

    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn2.mas_bottom).offset(20);
        make.left.equalTo(@gap);
        make.right.equalTo(@-gap);
        make.height.mas_equalTo(btnHeight);
    }];
    
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn3.mas_bottom).offset(20);
        make.left.equalTo(@gap);
        make.right.equalTo(@-gap);
        make.height.mas_equalTo(btnHeight);
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    imageView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 350, 100, 100)];
    imageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:imageView];

}

-(void)AnimationClick:(UIButton *)button{
    switch (button.tag) {
            //移动动画
        case 0:
        {
            CABasicAnimation *Animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
            Animation.duration = 0.6f;//动画时长
            Animation.fromValue = @(imageView.center.y);// 起始帧
            Animation.toValue = @(imageView.center.y+50);//终止帧
            Animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];//速度控制方式：匀速线性
            Animation.repeatCount = 1;//重复次数
            Animation.removedOnCompletion = NO;
            Animation.fillMode = kCAFillModeForwards;//动画结束后,layer会一直保持着动画最后的状态
            [imageView.layer addAnimation:Animation forKey:@"AnimationMoveY"];
        }
            break;
            
            //旋转动画:x、y、z三个方向
        case 1:{
            CABasicAnimation *Animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];//围绕Y轴方向旋转
            Animation.duration = 1.0f;
            Animation.repeatCount = 1;
            Animation.fromValue = @(0);
            Animation.toValue = @(M_PI);//旋转一周
            Animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [imageView.layer addAnimation:Animation forKey:@"RotationY"];
        }
            break;
            
            // 缩放动画:x、y、z
        case 2:{
            CABasicAnimation *Animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"]; // 设定为缩放
            Animation.duration = 1.0f;
            Animation.repeatCount = 1;
            Animation.autoreverses = YES; // 动画结束时执行逆动画，回到起始帧
            Animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
            Animation.toValue = [NSNumber numberWithFloat:2.0]; // 结束时的倍率
//            Animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//            Animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 1.0)];
            [imageView.layer addAnimation:Animation forKey:@"scale-layer"];
        }
            break;
            
            //平移动画:必须设定方向
        case 3:{
            CABasicAnimation *Animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
            
            Animation.duration = 1;
            
            Animation.repeatCount = 0;
            
            Animation.removedOnCompletion = FALSE;
            
            Animation.fillMode = kCAFillModeForwards;
            
            Animation.autoreverses = YES;
            
            Animation.fromValue = [NSNumber numberWithFloat:0];
            
            Animation.toValue = [NSNumber numberWithFloat:60];
            
            [imageView.layer addAnimation:Animation forKey:@"animateLayer"];
        }
            break;
        default:
            break;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
