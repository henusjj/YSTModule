//
//  SecondViewController.m
//  1111111111
//
//  Created by penglaizhi on 2018/6/4.
//  Copyright © 2018年 决心. All rights reserved.
//  实名认证

#import "SecondViewController.h"
#import "YSTIdentificationView.h"

@interface SecondViewController ()

@property (nonatomic,strong) YSTIdentificationView *viewID;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    self.view.backgroundColor = [UIColor purpleColor];
    UIButton *buttonVack = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [buttonVack setTitle:@"back" forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonVack];
    [buttonVack addTarget:self action:@selector(buttonBackN) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    [self p_makeupViewForViewID];
    // Do any additional setup after loading the view.
}
#pragma mark - 初始化身份认证的view并传入相关参数
-(void)p_makeupViewForViewID
{
    self.viewID = [[YSTIdentificationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.viewID];
    //    self.viewID.arrTitle = @[@"手机号：",@"学历",@"家庭地址",@"真实姓名",@"身份证",@"验证码"];
    //    self.viewID.arrCountNum = @[@"11",@"10",@"30",@"8",@"20",@"6"];
    //    self.viewID.arrPlaceholder = @[@"请输入手机号",@"请输入学历",@"请输入地址",@"请输入真实姓名",@"请输入身份证",@"请输入验证码"];
    self.viewID.arrTitle = @[@"手机号：",@"真实姓名",@"身份证",@"验证码"];
    self.viewID.arrCountNum = @[@"11",@"8",@"20",@"6"];
    self.viewID.arrPlaceholder = @[@"请输入手机号",@"请输入真实姓名",@"请输入身份证",@"请输入验证码"];
    
    self.viewID.strPhone = @"16601108795";
    self.viewID.okBlock = ^(NSMutableDictionary *dicMessage) {
        NSLog(@"dicMessage = %@",dicMessage);//调用提交信息验证接口
    };
    
    self.viewID.codeBlock = ^(NSMutableDictionary *dicCode) {
        NSLog(@"dicCode = %@",dicCode);//调用获取验证码接口
    };
    
}

-(void)buttonBackN
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
