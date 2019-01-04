//
//  RegisterView.m
//  LCF_Demo
//
//  Created by 李晨芳 on 2018/6/7.
//  Copyright © 2018年 李晨芳. All rights reserved.
//

#import "RegisterView.h"
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例
#define SCALE_HEIGHT  kScreenHeight/667.f //适配比例
#define TextFieldBackGroundColor  [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
//颜色的宏
#define COLOR_RGB_ALPHA(R,G,B,a) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:a]


@interface RegisterView()
/** 手机号输入框*/
@property (nonatomic,strong)UITextField * phoneTextField;
/** 密码输入框*/
@property (nonatomic,strong)UITextField * passwordTextField;
/** 验证码输入框*/
@property (nonatomic,strong)UITextField * codeTextField;
/** 发送验证码按钮*/
@property (nonatomic,strong)PJ_CodeBtn * codeBtn;
/**  免密码登录 / 账号密码登录*/
@property (nonatomic,strong) UIButton * quickLogInBtn;
/**  忘记密码按钮*/
@property (nonatomic,strong) UIButton * forgetBtn;
/** 是否为快速登录*/
@property (nonatomic,assign) BOOL isQuickLogIn;

/** 微信三方登录参数*/
@property (nonatomic,strong) NSMutableDictionary * wechatDict;
/** QQ三方登录参数*/
@property (nonatomic,strong) NSMutableDictionary * qqDict;
/** 三方登录类型*/
@property (nonatomic,strong) NSString * thirdPartyType;
/** 是否能同意*/
@property(nonatomic,strong) UIButton * agreementBtn;

@end

@implementation RegisterView


-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame ]) {
        [self initUI];
    }
    return self;
}


/**
 初始化界面
 */
-(void)initUI{
    __weak __typeof(&*self)weakSelf = self;
    //头部背景视图
    UIImageView * headerImgView = [[UIImageView alloc]init];
    [headerImgView setImage:[UIImage imageNamed:@"headerImage"]];
    [self addSubview:headerImgView];
    [headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(268*SCALE_WIDTH);
        
    }];
    headerImgView.userInteractionEnabled = YES;
    //中间logo
    UIImageView * logoImgView = [[UIImageView alloc]init];
    [logoImgView setImage:[UIImage imageNamed:@"logoImg"]];
    [headerImgView addSubview:logoImgView];
    logoImgView.layer.masksToBounds = YES;
    logoImgView.layer.cornerRadius = 10;
    [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(85*SCALE_WIDTH, 85*SCALE_WIDTH));
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(58*SCALE_WIDTH);
    }];
    
    //返回按钮
    UIButton * leftBtn = [[UIButton alloc]init];
    [leftBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [headerImgView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@40);
        make.top.mas_equalTo(@44);
        make.left.mas_equalTo(@20);
    }];
    
    //中间背景View
    UIView * bgView = [[UIView alloc]init];
    bgView.layer.cornerRadius = 10.0;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth-20);
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.top.equalTo(logoImgView.mas_bottom).offset(43*SCALE_WIDTH);
    }];
    
    //MARK:手机号输入框
    self.phoneTextField = [[UITextField alloc]init];
    self.phoneTextField.font = [UIFont systemFontOfSize:14];
    self.phoneTextField.placeholder = @"请输入手机号";
    self.phoneTextField.backgroundColor = [UIColor colorWithRed:243/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    self.phoneTextField.layer.cornerRadius =21*SCALE_WIDTH;
    self.phoneTextField.layer.masksToBounds = YES;
    [bgView addSubview:self.phoneTextField];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(42*SCALE_HEIGHT);
        make.width.mas_equalTo(bgView).offset(-40);
        make.height.mas_equalTo(42*SCALE_WIDTH);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(20);
    }];
    
    //左边图标
    self.phoneTextField.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    UIView * phoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    UIImageView *phoneImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phoneIcon"]];
    [phoneView addSubview:phoneImgView];
    self.phoneTextField.leftView = phoneView;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [bgView addSubview:self.phoneTextField];
    [phoneImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    
    
    //MARK:短信验证码输入框
    self.codeTextField = [[UITextField alloc]init];
    self.codeTextField.placeholder = @"短信验证码";
    self.codeTextField.font = [UIFont systemFontOfSize:14];
    self.codeTextField.backgroundColor = TextFieldBackGroundColor;
    self.codeTextField.hidden = NO;
    self.codeTextField.layer.cornerRadius  = 21*SCALE_WIDTH;
    self.codeTextField.layer.masksToBounds = YES;
    [bgView addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.phoneTextField.mas_bottom).offset(10);
        make.width.mas_equalTo(bgView).offset(-40);
        make.height.mas_equalTo(42*SCALE_WIDTH);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(20);
    }];

    UIView * codeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    UIImageView * codeImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"safeIcon"]];
    [codeView addSubview:codeImgView];
    self.codeTextField.leftView = codeView;
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
    self.codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeTextField.secureTextEntry = YES;
    [bgView addSubview:self.codeTextField];
    [codeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
    }];


    //MARK:验证码按钮
    UIView * codeRightView = [[UIView alloc]init];
    self.codeBtn = [[PJ_CodeBtn alloc]init];
    self.codeBtn.backgroundColor = [UIColor redColor];
    [self.codeBtn setTitleColor:COLOR_RGB_ALPHA(34, 34, 34, 1) forState:UIControlStateNormal];
    self.codeBtn.backgroundColor =  [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn addTarget:self action:@selector(sendCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [codeRightView addSubview:self.codeBtn];
    self.codeTextField.rightViewMode = UITextFieldViewModeAlways;
    self.codeTextField.rightView =codeRightView;
    [self.codeTextField layoutIfNeeded];

    [codeRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.codeTextField);
        make.height.mas_equalTo(weakSelf.codeTextField);
        make.width.equalTo(weakSelf.codeTextField).multipliedBy(0.35f);
    }];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(codeRightView);
        make.height.mas_equalTo(codeRightView);
        make.center.mas_equalTo(0);
    }];


    //MARK:密码输入框
    self.passwordTextField = [[UITextField alloc]init];
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.layer.cornerRadius =21*SCALE_WIDTH;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.font = [UIFont systemFontOfSize:14];
    self.passwordTextField.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    [bgView addSubview:self.passwordTextField];

    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.codeTextField.mas_bottom).offset(10);
        make.width.mas_equalTo(bgView).offset(-40);
        make.height.mas_equalTo(42*SCALE_WIDTH);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(20);
    }];

    //密码左边图标
    UIView * passView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    UIImageView *passwordImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"passwordImg"]];
    [passView addSubview:passwordImgView];
    self.passwordTextField.leftView = passView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.secureTextEntry = YES;
    [passwordImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];


    //     明文暗文切换
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightBtn addTarget:self action:@selector(seePassWordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
    [rightView addSubview:rightBtn];
    self.passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.rightView =rightView;
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    
    
    //是否同意
    self.agreementBtn = [[UIButton alloc]init];
//    [QuickControlTool createButtonWithFrame:CGRectMake(self.passwordTextField.left, self.passwordTextField.bottom+10*SCALE_HEIGHT,100*SCALE_WIDTH, 25*SCALE_HEIGHT) backgroundImage:nil target:self action:@selector(agreementBtnClick:)];
    [self.agreementBtn addTarget:self action:@selector(agreementBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.agreementBtn setTitle:@" 已阅读并同意" forState:UIControlStateNormal];
    self.agreementBtn.tag = 1000;
    self.agreementBtn.selected = YES;
    [self.agreementBtn setImage:[UIImage imageNamed:@"yixuanzhong"] forState:UIControlStateNormal];
    [self.agreementBtn setTitleColor:COLOR_RGB_ALPHA(34, 34, 34, 1) forState:UIControlStateNormal];
    self.agreementBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:self.agreementBtn];
    [self.agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(10);
        make.left.mas_equalTo(self.passwordTextField.mas_left);
    }];
    
    //用户协议
    UIButton * protolBtn = [[UIButton alloc]init];
//    [QuickControlTool createButtonWithFrame:CGRectMake(agreementBtn.right,agreementBtn.top,130, 30) backgroundImage:nil target:self action:@selector(protolBtnClick:)];
    [protolBtn addTarget:self action:@selector(protolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [protolBtn setTitle:@"《用户服务协议》" forState:UIControlStateNormal];
    [protolBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    protolBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:protolBtn];
    [protolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(10);
        make.left.mas_equalTo(self.agreementBtn.mas_right);
    }];
    
    //MARK:立即注册按钮
    UIButton * logInBtn = [[UIButton alloc]init];
    logInBtn.backgroundColor = COLOR_RGB_ALPHA(237, 84, 82, 1);
    [logInBtn setTitle:@"注册" forState:UIControlStateNormal];
    logInBtn.titleLabel.font  = [UIFont systemFontOfSize:15];
    logInBtn.layer.cornerRadius = 21*SCALE_WIDTH;
    logInBtn.layer.masksToBounds = YES;
    [logInBtn addTarget:self action:@selector(registerBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:logInBtn];
    [logInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.agreementBtn.mas_bottom).offset(40*SCALE_WIDTH);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(bgView).offset(-40*SCALE_WIDTH);
        make.height.mas_equalTo(42*SCALE_WIDTH);
    }];

    
    //MARK:还没有账号 现在去注册
    UIButton * registerBtn = [[UIButton alloc]init];
    [registerBtn addTarget:self action:@selector(goToLogInBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"已有账号直接登录" forState:UIControlStateNormal];
    [registerBtn setTitleColor:COLOR_RGB_ALPHA(102, 102, 102, 1) forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc] initWithString:@"已有账号直接登录"];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, 2)];
    //设置字体属性 大小
    registerBtn.titleLabel.attributedText = attributedString;
    [bgView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(logInBtn);
        make.height.mas_equalTo(25*SCALE_WIDTH);
        make.top.mas_equalTo(logInBtn.mas_bottom).offset(10);
        make.centerX.mas_equalTo(logInBtn);
    }];
    
    //MARK:三方登录
    UILabel * noticeLabel = [[UILabel alloc]init];
    noticeLabel.textColor  = COLOR_RGB_ALPHA(102, 102, 102, 1);
    noticeLabel.font = [UIFont systemFontOfSize:12];
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    noticeLabel.text = @"第三方登录";
    [bgView addSubview:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.width.mas_equalTo(80*SCALE_WIDTH);
        make.height.mas_equalTo(25*SCALE_WIDTH);
        make.bottom.mas_equalTo(bgView.mas_bottom).offset(-75*SCALE_WIDTH);
    }];
    
    UIView * line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    [bgView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.mas_equalTo(bgView);
        make.centerY.mas_equalTo(noticeLabel);
        make.right.mas_equalTo(noticeLabel.mas_left);
    }];
    
    UIView * line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    [bgView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.right.mas_equalTo(bgView.mas_right);
        make.centerY.mas_equalTo(noticeLabel);
        make.left.mas_equalTo(noticeLabel.mas_right);
    }];
    
    //三方登录按钮
    UIButton * wechatBtn = [[UIButton alloc]init];
    [bgView addSubview:wechatBtn];
    [wechatBtn setImage:[UIImage imageNamed:@"Wechat@2x_03"] forState:UIControlStateNormal];
    [wechatBtn addTarget:self action:@selector(wechatLogBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(35*SCALE_WIDTH);
        make.top.mas_equalTo(noticeLabel.mas_bottom).offset(16*SCALE_WIDTH);
        make.right.mas_equalTo(noticeLabel.mas_centerX).offset(-20);
    }];
    
    UIButton * qqBtn = [[UIButton alloc]init];
    [bgView addSubview:qqBtn];
    [qqBtn setImage:[UIImage imageNamed:@"qq@3x"] forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(qqLogBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(35*SCALE_WIDTH);
        make.top.mas_equalTo(noticeLabel.mas_bottom).offset(16*SCALE_WIDTH);
        make.left.mas_equalTo(noticeLabel.mas_centerX).offset(20);
    }];
}

#pragma mark ----按钮的点击方法

//明暗文切换
-(void)seePassWordBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"eye2"] forState:UIControlStateNormal];
        self.passwordTextField.secureTextEntry = NO;
    }else{
        [sender setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
        self.passwordTextField.secureTextEntry = YES;
    }
}
//发送验证码
-(void)sendCodeBtnClick:(PJ_CodeBtn *)sender{
    if ([self.delegate respondsToSelector:@selector(sendCodeBtnDidClick:)]) {
        [self.delegate sendCodeBtnDidClick:self.codeBtn];
    }
}

//立即注册
-(void)registerBtnDidClick:(UIButton * )sender{
    
    if ([self.delegate respondsToSelector:@selector(registerBtnDidClick: phoneNumber: passWord: code:)]) {
        [self.delegate registerBtnDidClick:sender phoneNumber:self.phoneTextField.text passWord:self.passwordTextField.text code:self.codeTextField.text];
    }
}
//去登录按钮
-(void)goToLogInBtnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(backBtnDidClick:)]) {
        [self.delegate backBtnDidClick:sender];
    }
}
//返回按钮
-(void)backBtnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(backBtnDidClick:)]) {
        [self.delegate backBtnDidClick:sender];
    }
}

//是否同意
-(void)agreementBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"yixuanzhong"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    }
}
//用户协议的按钮
-(void)protolBtnClick:(UIButton *)sender{
    
}
#pragma mark  --- 三方登录
-(void)wechatLogBtnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(thirdLoginWithThirdType:)]) {
        [self.delegate thirdLoginWithThirdType:0];
    }
}
-(void)qqLogBtnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(thirdLoginWithThirdType:)]) {
        [self.delegate thirdLoginWithThirdType:1];
    }
}


#pragma mark  ---  收键盘
//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
@end
