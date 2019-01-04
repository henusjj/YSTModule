//
//  ButtonCodeVC.m
//  ShopCarListDemo
//
//  Created by penglaizhi on 2018/6/13.
//  Copyright © 2018年 决心. All rights reserved.
//

#import "ButtonCodeVC.h"
#import "YSTButtonCode.h"
@interface ButtonCodeVC ()
@property (nonatomic,strong) YSTButtonCode *buttonCode;
@end

@implementation ButtonCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeupButtonCode];
    [self plzForPopAction];

    // Do any additional setup after loading the view.
}
-(void)makeupButtonCode
{
    self.buttonCode = [[YSTButtonCode alloc] init];
    self.buttonCode.frame = CGRectMake(100, 200, 120, 50);
    [self.view addSubview:self.buttonCode];
    self.buttonCode.layer.masksToBounds = YES;
    self.buttonCode.layer.cornerRadius = 10;
    self.buttonCode.layer.borderWidth = 1;
    self.buttonCode.layer.borderColor = [UIColor redColor].CGColor;
    
    [self.buttonCode setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [self.buttonCode setBackgroundColor:[UIColor whiteColor]];
    [self.buttonCode setTitle:@"发送验证码" forState:(UIControlStateNormal)];
    [self.buttonCode addTarget:self action:@selector(buttonActionN) forControlEvents:(UIControlEventTouchUpInside)];
}
-(void)buttonActionN
{
    [self.buttonCode TheGetCodeDown:[UIColor redColor] withSecondColor:[UIColor purpleColor] WithSeconds:10];
}
//返回
-(void)plzForPopAction
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 24, 44);
    //    [button setImage:[UIImage imageNamed:@"back_img"] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [button setTitle:@"返回" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonActionInBase) forControlEvents:(UIControlEventTouchUpInside)];
    //    self.buttonLeft = button;
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    //    button.backgroundColor = [UIColor yellowColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
#pragma mark - 模态返回
-(void)buttonActionInBase
{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
