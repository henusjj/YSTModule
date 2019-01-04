//
//  ProgressVC.m
//  AnimationDemo
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "ProgressVC.h"

@interface ProgressVC ()

@end

@implementation ProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     self.tabBarController.tabBar.hidden = YES;
    self.title = @"Type效果展示";
    [self setBeginBtn];
}

-(void)setBeginBtn{
    UIButton * beginBtn = [Tools createBtnTitle:@"开始" Selector:@selector(animationBegin) target:self];
    [self.view addSubview:beginBtn];
    [beginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(-100);
    }];
}

-(void)animationBegin{
    UILabel * label1 = [[UILabel alloc]init];
    label1.backgroundColor = [UIColor blueColor];
    label1.text = @"label1";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    [self.view addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc]init];
    label2.text = @"label2";
    label2.backgroundColor = [UIColor blueColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    [self.view addSubview:label2];
    
    //label1的的动画
    CATransition *animation1 = [CATransition animation];
    animation1.duration = 5.0f;
    animation1.type =  kCATransitionPush;
    animation1.subtype = kCATransitionFromBottom;
    [animation1 setStartProgress:0.5];//设置动画起点（匀速过渡动画路径的百分比0.5处开始）
    [animation1 setEndProgress:0.8];//设置动画终点（匀速过渡动画路径的百分比0.8结束）
    [label1.layer addAnimation:animation1 forKey:@"animation"];
    
    //label2的的动画
    CATransition *animation2 = [CATransition animation];
    animation2.duration = 5.0f;
    animation2.type =  kCATransitionPush;
    animation2.subtype = kCATransitionFromBottom;
    [label2.layer addAnimation:animation2 forKey:@"animation"];
    
    
    //设置label约束
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@180);
        make.width.height.mas_equalTo(100);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.top.equalTo(@180);
        make.width.height.mas_equalTo(100);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
