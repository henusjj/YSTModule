//
//  FourButtonVC.m
//  ShopCarListDemo
//
//  Created by penglaizhi on 2018/6/13.
//  Copyright © 2018年 决心. All rights reserved.
//

#import "FourButtonVC.h"
#import "YSTDirectionButton.h"

@interface FourButtonVC ()

@end

@implementation FourButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self plzForPopAction];
    [self makeupViewForTest];
    // Do any additional setup after loading the view.
}
-(void)makeupViewForTest
{
    for (int i = 1; i<5; i++) {
        YSTDirectionButton *testButton = [[YSTDirectionButton alloc] initWithFrame:CGRectMake(10, 100*i, 200, 40)];
        testButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [testButton setBackgroundColor:[UIColor greenColor]];
        [testButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        testButton.spaceIL = 5;
        [testButton setTitle:[NSString stringWithFormat:@"第%d个按钮",i] forState:UIControlStateNormal];
        [testButton setImage:[UIImage imageNamed:@"购物车_选中"] forState:UIControlStateNormal];
        [self.view addSubview:testButton];
        testButton.type = i;

    }
}
//返回
-(void)plzForPopAction
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 24, 44);
    [button setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [button setTitle:@"返回" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonActionInBase) forControlEvents:(UIControlEventTouchUpInside)];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
#pragma mark - 模态返回
-(void)buttonActionInBase
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
