//
//  AlertPopViewController.m
//  YSTModule
//
//  Created by 李晨芳 on 2018/7/5.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "AlertPopViewController.h"
#import "AlertPopView.h"
@interface AlertPopViewController ()

/**
 alert弹出框
 */
@property (nonatomic,strong) AlertPopView * alertView;

/**
 返回按钮
 */
@property (nonatomic,strong) UIButton *buttonBack;

@end

@implementation AlertPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Alert弹出框";
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100,100,200,45 )];
    btn.backgroundColor = [UIColor purpleColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents: UIControlEventTouchUpInside];
    [btn setTitle:@"点击弹出alert" forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

/**
 弹框出现
 */
-(void)btnClick{
    /**
     弹框使用方法
     
     @param clickIndex 点击标签左右按钮
     @return 弹框
     */
    self.alertView = [[AlertPopView alloc]initWithTitle:@"温馨提示" subTile:@"您的余额已不足，请充值！" leftBtnTitle:@"取消" rightBtnTitle:@"确定" clickBlock:^(NSInteger clickIndex) {
        if (clickIndex == 0) {
            NSLog(@"点击了左边按钮");
        }else{
            NSLog(@"点击了右边按钮");
        }
    }];
    [self.alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
