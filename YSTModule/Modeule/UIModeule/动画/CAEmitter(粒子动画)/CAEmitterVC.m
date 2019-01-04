//
//  CAEmitterVC.m
//  AnimationDemo
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "CAEmitterVC.h"

@interface CAEmitterVC ()

@end

@implementation CAEmitterVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:165.0/255.0 green:225.0/255.0 blue:234.0/255.0 alpha:0.9];
    self.title = @"Emitter（粒子）动画";
    UIButton *btn1 = [Tools createBtnTitle:@"开始" Selector:@selector(EmitterAnimation:) target:self];
    [self.view addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@gap);
        make.right.equalTo(@-gap);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.height.mas_equalTo(btnHeight);
    }];
    

}

-(void)EmitterAnimation:(UIButton *)btn{
    CAEmitterLayer * bubbleEmitterLayer = [CAEmitterLayer layer];
    //粒子发射位置
    bubbleEmitterLayer.emitterPosition = CGPointMake(ScreenWidth/2, ScreenHeight);
    //发射源的尺寸大小
    bubbleEmitterLayer.emitterSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    //发射模式
    bubbleEmitterLayer.emitterMode = kCAEmitterLayerLine;
    //发射源的形状
    bubbleEmitterLayer.emitterShape = kCAEmitterLayerLine;
    //渲染模式
    //    snowEmitterLayer.renderMode = kCAEmitterLayerAdditive;
    
    
    //创建粒子
    CAEmitterCell * snowCell = [CAEmitterCell emitterCell];
    //粒子的内容
    snowCell.contents = (__bridge id)[UIImage imageNamed:@"qipao"].CGImage;
    
    // 缩放比例
    snowCell.scale = 0.05;
    snowCell.scaleRange = 0.2;
    
    // 每秒产生的数量
    snowCell.birthRate = 2;
    snowCell.lifetime = 80;
    
//    // 每秒变透明的速度
    snowCell.alphaSpeed = -0.01;
    
    // 秒速“五”厘米～～
    snowCell.velocity = 50;
    snowCell.velocityRange = 60;
    
    // 掉落的角度范围
    snowCell.emissionRange = M_PI;
    
    
    // 旋转的速度
    snowCell.spin = M_PI_4;
    // 每个cell的颜色
    //    snowCell.color = [[UIColor redColor] CGColor];
    
    // 阴影的 不透明 度
    //    snowEmitterLayer.shadowOpacity = 1;
    // 阴影化开的程度（就像墨水滴在宣纸上化开那样）
    //    snowEmitterLayer.shadowRadius = 8;
    // 阴影的偏移量
    //    snowEmitterLayer.shadowOffset = CGSizeMake(3, 3);
    // 阴影的颜色
    //    snowEmitterLayer.shadowColor = [[UIColor whiteColor] CGColor];

    
    bubbleEmitterLayer.emitterCells = @[snowCell];
    [self.view.layer addSublayer:bubbleEmitterLayer];
    
    [self fishEmitter];
}

-(void)fishEmitter{
    CAEmitterLayer * fishEmitterLayer = [CAEmitterLayer layer];
    fishEmitterLayer.emitterPosition = CGPointMake(ScreenWidth, ScreenHeight);
    fishEmitterLayer.emitterSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    fishEmitterLayer.emitterMode = kCAEmitterLayerOutline;
    fishEmitterLayer.emitterShape = kCAEmitterLayerLine;
    //    snowEmitterLayer.renderMode = kCAEmitterLayerAdditive;

    CAEmitterCell * fishCell = [CAEmitterCell emitterCell];

    fishCell.contents = (__bridge id)[UIImage imageNamed:@"fish"].CGImage;

    fishCell.scale = 0.05;
    fishCell.scaleRange = 0.2;
    
    // 每秒产生的数量
    fishCell.birthRate = 0.5;
    fishCell.lifetime = 80;
    
    // 每秒变透明的速度
//    fishCell.alphaSpeed = -0.01;
    
    // 秒速“五”厘米～～
    fishCell.velocity = 50;
    fishCell.velocityRange = 60;
    
    // 掉落的角度范围
    fishCell.emissionRange = M_LN2;
    
    fishCell.emissionLongitude = -0.8;
    
    fishEmitterLayer.emitterCells = @[fishCell];
    [self.view.layer addSublayer:fishEmitterLayer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
