//
//  CATransitionVC.m
//  AnimationDemo
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "CATransitionVC.h"
#import "TypeVC.h"
#import "ProgressVC.h"

@interface CATransitionVC (){
    float seconds;
}

@end

@implementation CATransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;

    NSArray * titleArr = @[@"Type属性",@"Progress属性"];
    for (int i=0; i<2; i++) {
        UIButton *btn = [Tools createBtnTitle:[titleArr objectAtIndex:i] Selector:@selector(CAAnimationClick:) target:self];
        btn.frame = CGRectMake(gap, 100+i*(btnHeight+20), SCREEN_WIDTH-gap*2, btnHeight);
        btn.tag = i;
        [self.view addSubview:btn];
    }
}


-(void)CAAnimationClick:(UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self.navigationController pushViewController:[TypeVC new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[ProgressVC new] animated:YES];
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
