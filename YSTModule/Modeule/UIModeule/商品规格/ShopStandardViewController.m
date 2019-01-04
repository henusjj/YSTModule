//
//  ShopStandardViewController.m
//  YSTModule
//
//  Created by 节庆霞 on 2018/7/6.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "ShopStandardViewController.h"
#import "ShopStandard.h"
@interface ShopStandardViewController ()<shopStandardDelegate>
@property (nonatomic,strong)UILabel *standLabel;

@end

@implementation ShopStandardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 200, 100, 50)];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"选择规格" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(ButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.standLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, button.bottom, SCREEN_WIDTH - 40, 40)];
    self.standLabel.font = [UIFont systemFontOfSize:15];
    self.standLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.standLabel];
    
    
}
#pragma mark - 选择规格
- (void)ButtonAction
{
    ShopStandard *shopview = [[ShopStandard alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) productId:@"1"];
    shopview.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:shopview];
    
}

- (void)selectedDic:(NSDictionary *)dic selectedStr:(NSString *)str
{
    self.standLabel.text = str;
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
