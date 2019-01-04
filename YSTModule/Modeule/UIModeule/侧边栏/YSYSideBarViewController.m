//
//  YSYSideBarViewController.m
//  YSTModule
//
//  Created by YSTQZY on 2018/6/15.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "YSYSideBarViewController.h"
#import "UIView+leoAdd.h"
#import "PSDrawerManager.h"
#import "LeftView.h"

@interface YSYSideBarViewController ()

@end

@implementation YSYSideBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    LeftView *leftView = [[LeftView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width * (1 - kLeftWidthScale), 0, self.view.frame.size.width, self.view.frame.size.height)];

    [[PSDrawerManager instance] installCenterViewController:self leftView:leftView];
    
//    UIButton *buttonVack = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    [buttonVack setTitle:@"back" forState:(UIControlStateNormal)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonVack];
//    [buttonVack addTarget:self action:@selector(buttonBackN) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)buttonBackN
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
