//
//  LoginViewController.m
//  YSTModule
//
//  Created by 朱标 on 2018/6/8.
//  Copyright © 2018年 zhubiao. All rights reserved.
//  登录注册

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LogInView.h"
#import "PJ_CodeBtn.h"
#import "ForgetPwdViewController.h"

#define COLOR_RGB_ALPHA(R,G,B,a) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:a]

@interface LoginViewController ()<LogInViewDelegate>
@property(nonatomic,strong)LogInView * logInView;

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar .hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar .hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.logInView = [[LogInView alloc]initWithFrame:self.view.bounds];
    self.logInView.backgroundColor =  [UIColor colorWithRed:243/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    self.logInView.delegate = self;
    [self.view addSubview:self.logInView];
    UIButton *buttonVack = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [buttonVack setTitle:@"back" forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonVack];
    [buttonVack addTarget:self action:@selector(buttonBackN) forControlEvents:(UIControlEventTouchUpInside)];

}
-(void)buttonBackN
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---- 代理方法 delegate
//发送验证码
-(void)sendCodeBtnDidClick:(PJ_CodeBtn *)sender{
    NSLog(@"发送验证码");
    [sender TheGetCodeDown:COLOR_RGB_ALPHA(34, 34, 34, 1) withSecondColor:COLOR_RGB_ALPHA(153, 153, 153, 1) WithSeconds:60];
}
//立即登录
-(void)loginBtnDidClick:(UIButton * )sender withLoginType:(BOOL)type phoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord code:(NSString *)code{
    NSLog(@"立即登录%@，%@  %@ 是否为快捷登录：%d",phoneNumber,passWord,code,type);
}
//三方登录
-(void)thirdLoginWithThirdType:(NSInteger)thirdType{
    if (thirdType == 0) {
        NSLog(@"微信登录");
    }else{
        NSLog(@"QQ登录");
    }
}
//返回
-(void)backBtnDidClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//注册
-(void)registerBtnDidClick:(UIButton *)sender{
    RegisterViewController * vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)forgetpwdDidClick:(UIButton *)sender{
    ForgetPwdViewController * vc = [[ForgetPwdViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
