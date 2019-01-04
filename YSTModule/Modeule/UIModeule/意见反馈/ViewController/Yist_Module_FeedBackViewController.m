//
//  Yist_Module_FeedBackViewController.m
//  YSTModule
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "Yist_Module_FeedBackViewController.h"
#import "UITextView+Placeholder.h"

#define MAXINPUT 200
@interface Yist_Module_FeedBackViewController ()<UITextViewDelegate>

@property (nonatomic, strong)   UITextView *feedBackInput;

@property (nonatomic, strong)   UILabel *textNumber;

@property (nonatomic, strong)   UIButton *senderButton;

@end

@implementation Yist_Module_FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"意见反馈";
    self.view.backgroundColor = [self DefineColorString:@"#eeeeee"];
    UIButton *buttonVack = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [buttonVack setTitle:@"back" forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonVack];
    [buttonVack addTarget:self action:@selector(buttonBackN) forControlEvents:(UIControlEventTouchUpInside)];
    [self addViews];
}

-(void)buttonBackN{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)addViews{
    [self.view addSubview:self.feedBackInput];
    [self.feedBackInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(self.view.mas_top).offset(kNavHeight + 10);
        make.height.mas_equalTo(200);
    }];
    
    [self.view addSubview:self.textNumber];
    [self.textNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(self.feedBackInput.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview: self.senderButton];
    [self.senderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.textNumber.mas_bottom).offset(20);
    }];
}

-(UITextView *)feedBackInput{
    if (!_feedBackInput) {
        _feedBackInput = [UITextView new];
        _feedBackInput.delegate = self;
        _feedBackInput.layer.borderWidth = 1;
        _feedBackInput.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
        [_feedBackInput setFont:[UIFont systemFontOfSize:16]];
        _feedBackInput.placeholder = @"请在此输入您的反馈意见";
        _feedBackInput.returnKeyType = UIReturnKeyDone;
    }
    return _feedBackInput;
}

-(UILabel *)textNumber{
    if (!_textNumber) {
        _textNumber = [UILabel new];
        _textNumber.font = [UIFont systemFontOfSize:16];
        _textNumber.textAlignment = NSTextAlignmentRight;
        _textNumber.text = [NSString stringWithFormat:@"还可输入 %d 字", MAXINPUT];
    }
    return _textNumber;
}

-(UIButton *)senderButton{
    if (!_senderButton) {
        
        _senderButton = [self createBtnTitle:@"提 交" Selector:@selector(senderButtonAction) target:self normalColor:[self DefineColorString:@"#FC471E"] HighlightedColor:[self DefineColorString:@"#FC471E"] titleColor:[UIColor whiteColor]];
        
        self.senderButton.enabled = NO;
    }
    return _senderButton;
}

-(void)senderButtonAction{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString: @"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    //把空字符串替换掉,空格不许提交
    NSString *feedbackString = [self.feedBackInput.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([feedbackString length] > 0) {
        self.senderButton.enabled = YES;
    }else
    {
        self.senderButton.enabled = NO;
    }
    
    if (textView.text.length > MAXINPUT)
    {
        textView.text = [textView.text substringToIndex:MAXINPUT];
    }
    self.textNumber.text = [NSString stringWithFormat:@"还可输入 %lu 字", MAXINPUT - textView.text.length];
    //    self.feedBackInput.attributedText = [NSString NSStringBetweenChangeFontAndColor:self.numberOfWord.text andBefore:@"入" andAfterString:@"字" andXColor:kColorRGB(80, 144, 250) andXFont:14];
}

/**
 快速创建一个按钮       纯色
 */
- (UIButton *)createBtnTitle:(NSString *)title Selector:(SEL)selector  target:(id)target normalColor:(UIColor *)normalColor HighlightedColor:(UIColor *)HighlightedColor titleColor:(UIColor *)titleColor{
    UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[self imageWithColor:normalColor size:CGSizeMake(SCREEN_WIDTH-10*2, 40)] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self imageWithColor:HighlightedColor size:CGSizeMake(SCREEN_WIDTH-10*2, 40)] forState:UIControlStateHighlighted];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    return  btn;
}

/**
 快速创建一个纯色图片
 */
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(UIColor *)DefineColorString: (NSString *) stringToConvert{
    if ([stringToConvert length] <6){//长度不合法
        return [UIColor blackColor];
    }
    NSString *tempString=[stringToConvert lowercaseString];
    if ([tempString hasPrefix:@"0x"]){//检查开头是0x
        tempString = [tempString substringFromIndex:2];
    }else if ([tempString hasPrefix:@"#"]){//检查开头是#
        tempString = [tempString substringFromIndex:1];
    }
    if ([tempString length] !=6){
        return [UIColor blackColor];
    }
    //分解三种颜色的值
    NSRange range;
    range.location =0;
    range.length =2;
    NSString *rString = [tempString substringWithRange:range];
    range.location =2;
    NSString *gString = [tempString substringWithRange:range];
    range.location =4;
    NSString *bString = [tempString substringWithRange:range];
    //取三种颜色值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString]scanHexInt:&r];
    [[NSScanner scannerWithString:gString]scanHexInt:&g];
    [[NSScanner scannerWithString:bString]scanHexInt:&b];
    return [UIColor colorWithRed:((float) r /255.0f)
                           green:((float) g /255.0f)
                            blue:((float) b /255.0f)
                           alpha:1.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
