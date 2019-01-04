//
//  PLZQRCodeViewController.m
//  YSTNewGreatWallMedium

//  Created by penglaizhi on 2017/12/14.
//  Copyright © 2017年 zhubiao. All rights reserved.
//我的二维码（简单）

#import "PLZQRCodeViewController.h"
#import "PLZQRCodeView.h"
#import "PLZScanQrcodeVC.h"

@interface PLZQRCodeViewController ()

@property (nonatomic,strong) PLZQRCodeView *QRCodeView;



@end

@implementation PLZQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_makeupViewForQRCodeVC];
    [self p_makeupDataForQRCodeVC];
    // Do any additional setup after loading the view.
}

-(void)p_makeupViewForQRCodeVC
{
    self.title = @"我的二维码";
    self.QRCodeView = [[PLZQRCodeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.QRCodeView];
    
//    [self PlzBaseMakeUpViewForButtonRight];
//    [self.buttonRight setTitle:@"扫一扫" forState:(UIControlStateNormal)];
//    [self.buttonRight setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//    [self.buttonRight addTarget:self action:@selector(buttonMineAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}
//跳转到扫一扫
-(void)buttonMineAction
{
    PLZScanQrcodeVC *QRCodeVC = [[PLZScanQrcodeVC alloc] init];
//    self.QRCodeView.Summation1(QRCodeVC.new11111);
    [self.navigationController pushViewController:QRCodeVC animated:YES];
    
}

-(void)p_makeupDataForQRCodeVC
{
    self.QRCodeView.dataMine = self.datMine;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
