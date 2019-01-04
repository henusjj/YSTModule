//
//  RegisterViewController.m
//  LCF_Demo
//
//  Created by 李晨芳 on 2018/6/7.
//  Copyright © 2018年 李晨芳. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"
@interface RegisterViewController ()<RegisterViewDelegate>
@property(nonatomic,strong)RegisterView * registerView;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.registerView = [[RegisterView alloc]initWithFrame:self.view.bounds];
    self.registerView.backgroundColor =  [UIColor colorWithRed:243/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    self.registerView.delegate = self;
    [self.view addSubview:self.registerView];
    
}


#pragma mark ---- delegate
-(void)backBtnDidClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"77777");
}
-(void)registerBtnDidClick:(UIButton *)sender phoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord code:(NSString *)code{
    NSLog(@"%@---%@---%@",phoneNumber,passWord,code);
}

-(void)sendCodeBtnDidClick:(PJ_CodeBtn *)sender{
   [sender TheGetCodeDown:[UIColor colorWithRed:34/255.0f green:34/255.0f blue:34/255.0f alpha:1] withSecondColor:[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1] WithSeconds:60];
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
