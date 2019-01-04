//
//  ForgetPwdView.m
//  YSTModule
//
//  Created by 李晨芳 on 2018/6/22.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "ForgetPwdView.h"
#import "PJ_Textfield.h" //输入框
#import "PJ_CodeBtn.h" //验证码按钮

@interface ForgetPwdView()
/**手机号输入框*/
@property(nonatomic,strong)PJ_Textfield * phoneTextField;
/**验证码输入框*/
@property(nonatomic,strong)PJ_Textfield * codeTextField;
/**密码输入框*/
@property(nonatomic,strong)PJ_Textfield * passwordTextField;
/**验证码按钮 */
@property(nonatomic,strong)PJ_CodeBtn * codeBtn;
@end


@implementation ForgetPwdView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}


/**
 初始化界面
 */
-(void)initUI{
    //手机号
    self.phoneTextField = [[PJ_Textfield alloc]initWithFrame:CGRectMake(16,1,kScreenWidth-32 , 45)];
    [self.phoneTextField setLeftImg:@"phoneIcon"];
    self.phoneTextField.font = [UIFont systemFontOfSize:14];
    self.phoneTextField.placeholder = @"请输入您的手机号";
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.phoneTextField];
    
    //line1
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(16, 45,kScreenWidth-32 , 1)];
    line1.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [self addSubview:line1];
    
    //验证码
    self.codeTextField = [[PJ_Textfield alloc]initWithFrame:CGRectMake(16,46,kScreenWidth-32 , 45)];
    [self.codeTextField setLeftImg:@"safeIcon"];
    self.codeTextField.font = [UIFont systemFontOfSize:14];
    self.codeTextField.placeholder = @"请输入验证码";
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.codeTextField];
    
    //验证码按钮
    self.codeBtn = [[PJ_CodeBtn alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
    self.codeBtn.centerY = self.codeTextField.centerY;
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:94/255.0 blue:87/255.0 alpha:1] forState:UIControlStateNormal];
    self.codeBtn.right = kScreenWidth-15;
    self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.codeBtn.layer.borderWidth = 1.0;
    self.codeBtn.layer.borderColor = [UIColor colorWithRed:217/255.0 green:94/255.0 blue:87/255.0 alpha:1].CGColor;
    self.codeBtn.layer.cornerRadius = 4.0;
    self.codeBtn.layer.masksToBounds = YES;
    [self.codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.codeBtn];
    
    //line2
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(16, 91,kScreenWidth-32 , 1)];
    line2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [self addSubview:line2];
    
    //新密码
    self.passwordTextField = [[PJ_Textfield alloc]initWithFrame:CGRectMake(16,line2.bottom,kScreenWidth-32 , 45)];
    [self.passwordTextField setLeftImg:@"passwordImg"];
    self.passwordTextField.font = [UIFont systemFontOfSize:14];
    self.passwordTextField.placeholder = @"请输入您的新密码";
    [self addSubview:self.passwordTextField];
    
    //line2
    UIView * line3 = [[UIView alloc]initWithFrame:CGRectMake(16, 136,kScreenWidth-32 , 1)];
    line3.backgroundColor =[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [self addSubview:line3];
    
    //确认按钮
    UIButton * sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 137+50,kScreenWidth-32 , 50)];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setBackgroundColor:[UIColor colorWithRed:217/255.0 green:94/255.0 blue:87/255.0 alpha:1]];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 6.0;
    sureBtn.layer.masksToBounds = YES;
    sureBtn.tag = 1000;
    [self addSubview:sureBtn];
    
}

#pragma mark ----验证码
-(void)codeBtnClick:(PJ_CodeBtn *)sender{
     [sender TheGetCodeDown:[UIColor colorWithRed:217/255.0 green:94/255.0 blue:87/255.0 alpha:1] withSecondColor:[UIColor colorWithRed:217/255.0 green:94/255.0 blue:87/255.0 alpha:1] WithSeconds:60];
}

#pragma mark ---- 确认按钮
-(void)sureBtnClick:(UIButton *)btn{

}


@end
