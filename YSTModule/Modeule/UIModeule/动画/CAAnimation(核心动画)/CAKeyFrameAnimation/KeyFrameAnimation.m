//
//  KeyFrameAnimation.m
//  AnimationDemo
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "KeyFrameAnimation.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface KeyFrameAnimation (){
    UIView * imageView;
}

@end

@implementation KeyFrameAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIButton *btn1 = [Tools createBtnTitle:@"Values" Selector:@selector(AnimationClick:) target:self];
    btn1.tag = 0;
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = [Tools createBtnTitle:@"Path" Selector:@selector(AnimationClick:) target:self];
    btn2.tag = 1;
    [self.view addSubview:btn2];

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
    
    imageView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-10, 320, 20, 20)];
    imageView.backgroundColor = [UIColor blackColor];
    imageView.layer.cornerRadius = 10;
    [self.view addSubview:imageView];

}

-(void)AnimationClick:(UIButton *)button{
    switch (button.tag) {
            //Values实现
        case 0:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            
            //动画路径的values
            NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(100, 250)];
            
            NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(200, 250)];
            
            NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(200, 300)];
            
            NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(100, 300)];
            
            NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(100, 400)];
            
            NSValue *value6=[NSValue valueWithCGPoint:CGPointMake(200, 400)];
            
            animation.values=@[value1,value2,value3,value4,value5,value6];
            
            //重复次数
            animation.repeatCount=MAXFLOAT;
            
            //设置是否原路返回
            animation.autoreverses = YES;
            
            //设置移动速度，越小越快
            animation.duration = 4.0f;
            
            animation.removedOnCompletion = NO;
            
            animation.fillMode = kCAFillModeForwards;
            
            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [imageView.layer addAnimation:animation forKey:nil];
            
        }
            break;
            
            //通过Path方式
        case 1:{
            //创建动画对象
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            
            //创建一个CGPathRef对象，就是动画的路线
            CGMutablePathRef path = CGPathCreateMutable();
            
            //设置开始位置
            CGPathMoveToPoint(path,NULL,100,250);
            
            //沿直线移动
            CGPathAddLineToPoint(path,NULL, 200, 250);
            
            CGPathAddLineToPoint(path,NULL, 200, 300);
            
            CGPathAddLineToPoint(path,NULL, 100, 300);
            
            CGPathAddLineToPoint(path,NULL, 100, 400);
            
            CGPathAddLineToPoint(path,NULL, 200, 400);
            
            //沿着曲线移动
            CGPathAddCurveToPoint(path,NULL,200.0,500.0,250.0,500.0,250.0,400.0);
            
            CGPathAddCurveToPoint(path,NULL,250.0,500.0,300.0,500.0,300.0,400.0);
            
            //自动沿着弧度移动
            
            CGPathAddEllipseInRect(path, NULL, CGRectMake(300, 400, 70, 100));
            
            animation.path=path;
            
            CGPathRelease(path);
            
            animation.autoreverses = YES;
            
            animation.repeatCount=1;
            
            animation.removedOnCompletion = NO;
            
            animation.fillMode = kCAFillModeForwards;
            
            animation.duration = 8.0f;
            
            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            [imageView.layer addAnimation:animation forKey:nil];
            
            //绘制出动画路径，方便观察
            CAShapeLayer *line = [[CAShapeLayer alloc]init];
            
            line.fillColor = [UIColor clearColor].CGColor;
            
            line.borderWidth = 1;
            
            line.strokeColor = [UIColor redColor].CGColor;
            
            line.path = path;
            
            [self.view.layer addSublayer:line];
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
