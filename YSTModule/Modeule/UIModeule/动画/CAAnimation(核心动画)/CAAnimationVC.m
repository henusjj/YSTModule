//
//  ViewController.m
//  AnimationDemo
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "CAAnimationVC.h"
#import "CATransitionVC.h"
#import "BasicAnimationVC.h"
#import "KeyFrameAnimation.h"
#import "AnimationGroupVC.h"


@interface CAAnimationVC ()

@end

@implementation CAAnimationVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = NO;
    self.title = @"CAAnimation";
    [self initCAAnimation];
}


-(void)initCAAnimation{
    
    /**
     CAAnimation动画
     **/
    NSArray * titleArr = @[@"CATransition",@"CABasicAnimation",@"KeyFrameAnimation",@"CAAnimationGroup"];
    for (int i=0; i<4; i++) {
        UIButton *btn = [Tools createBtnTitle:[titleArr objectAtIndex:i] Selector:@selector(CAAnimationClick:) target:self];
        btn.frame = CGRectMake(gap, 100+i*(btnHeight+20), SCREEN_WIDTH-gap*2, btnHeight);
        btn.tag = i+1;
        [self.view addSubview:btn];
    }
}



-(void)CAAnimationClick:(UIButton *)btn{
    switch (btn.tag) {
        case 1:{
            [self.navigationController pushViewController:[CATransitionVC new] animated:YES];
        }
            break;
        case 2:
            [self.navigationController pushViewController:[BasicAnimationVC new] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[KeyFrameAnimation new] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[AnimationGroupVC new] animated:YES];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
