//
//  TradePasswordController.m
//  YSTModule
//
//  Created by 冯亮亮 on 2018/7/9.
//  Copyright © 2018年 zhubiao. All rights reserved.
// 用法
/**
1:
 导入 #import "TradePasswordAlertView.h"
2:
 self.tradePasswoordAlert = [[TradePasswordAlertView alloc] initWithTitle:@"请输入交易密码" BackImage:@"pop_kongbai" cancelImage:@"upDateCancel" makeSureImage:@"upDateSure" clickBlock:^(NSString *password) {
 
 self.tradeLabel.text = password;
 }];
 [self.tradePasswoordAlert show];
 */


#import "TradePasswordController.h"
#import "TradePasswordAlertView.h"
@interface TradePasswordController ()
@property(nonatomic,strong)TradePasswordAlertView *tradePasswoordAlert;

@property(nonatomic,strong)UILabel *tradeLabel;
@end

@implementation TradePasswordController

- (void)viewDidLoad {
    self.view.userInteractionEnabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    UIButton *mybutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    mybutton.backgroundColor = [UIColor greenColor];
    mybutton.frame = CGRectMake(100, 100,100,50);
    [mybutton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [mybutton setTitle:@"交易密码" forState:(UIControlStateNormal)];
    [mybutton addTarget:self action:@selector(tradePassword) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:mybutton];
    
    
    self.tradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 170, self.view.frame.size.width, 50)];
    self.tradeLabel.backgroundColor = [UIColor yellowColor];
    self.tradeLabel.textColor = [UIColor redColor];
    self.tradeLabel.textAlignment = NSTextAlignmentCenter;
    self.tradeLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.tradeLabel];
    // Do any additional setup after loading the view.
}
-(void)tradePassword
{
    self.tradeLabel.text = [NSString stringWithFormat:@"输入的交易密码是:"];

    self.tradePasswoordAlert = [[TradePasswordAlertView alloc] initWithTitle:@"请输入交易密码" BackImage:@"pop_kongbai" cancelImage:@"upDateCancel" makeSureImage:@"upDateSure" clickBlock:^(NSString *password) {
        [self.tradePasswoordAlert dismiss];
        self.tradeLabel.text = [NSString stringWithFormat:@"输入的交易密码是:%@",password];
    }];
    [self.tradePasswoordAlert show];

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
