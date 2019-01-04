//
//  ForgetPwdViewController.m
//  YSTModule
//
//  Created by 李晨芳 on 2018/6/22.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "ForgetPwdView.h"
@interface ForgetPwdViewController ()

@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
    ForgetPwdView * forgetView = [[ForgetPwdView alloc]initWithFrame:CGRectMake(0,64 , ScreenWidth, self.view.frame.size.height-64)];
    [self.view addSubview:forgetView];
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
