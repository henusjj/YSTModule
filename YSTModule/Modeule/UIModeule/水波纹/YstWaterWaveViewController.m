//
//  YstWaterWaveViewController.m
//  YSTModule
//
//  Created by 李晨芳 on 2018/6/27.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "YstWaterWaveViewController.h"
#import "WaterWaveView.h"
//RGB
#define RGBA(r, g, b, a) ([UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a])
@interface YstWaterWaveViewController ()

@end

@implementation YstWaterWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    WaterWaveView *waterView = [[WaterWaveView alloc] initWithFrame:(CGRect){0, 100, CGRectGetWidth(self.view.bounds), 200} startColor:RGBA(19, 176, 238, 0.3) endColor:RGBA(19, 176, 238, 0.7)];
    waterView.wavePointY = 180;
    [self.view addSubview:waterView];
    
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
