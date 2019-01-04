//
//  TradePasswordAlertView.m
//  EquityTradingPlatform
//
//  Created by 冯亮亮 on 2018/5/23.
//  Copyright © 2018年 冯亮亮. All rights reserved.
//
#define W 270*SCALE_WIDTH
#define H 135*SCALE_HEIGHT
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例
#define SCALE_HEIGHT  kScreenHeight/667.f //适配比例
//屏幕的宽高
//#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
//#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)
//字体适配宏
#define FONT(A,IFBOLD)       IFBOLD ? [UIFont boldSystemFontOfSize:kScreenWidth > 320 ? A : A/1.3]: [UIFont systemFontOfSize:kScreenWidth > 320 ? A : A/1.3]

#import "TradePasswordAlertView.h"

@interface TradePasswordAlertView()<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *backView;//透明背景View
@property(nonatomic,strong)UIImageView *backImageView;//密码下面的空白
@property(nonatomic,strong)UILabel *titleLabel;//名字
@property(nonatomic,strong)UIImageView *cancelImageView;//取消按钮
@property(nonatomic,strong)UIImageView *makeSureImageView;//确定按钮
@property(nonatomic,copy)void(^btnClickBlock)(NSString *password);
@property (nonatomic,copy) NSString *passwordStr;
@end
@implementation TradePasswordAlertView

- (instancetype)initWithTitle:(NSString *)title BackImage:(NSString *)backImage cancelImage:(NSString *)cancelImage makeSureImage:(NSString *)makeSureImage clickBlock:(void(^)(NSString *password))btnClickBlock
{
    self.userInteractionEnabled = YES;
    self.btnClickBlock = btnClickBlock;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self addGestureRecognizer:singleTap];
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    if (self) {
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - W/2, kScreenHeight/2 - H/2, W, H)];
        self.backView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped1:)];
        [self.backView addGestureRecognizer:singleTap1];
        [self addSubview:self.backView];
        
        
        
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270 * SCALE_WIDTH, 95 * SCALE_HEIGHT)];
        self.backImageView.userInteractionEnabled = YES;
        self.backImageView.image = [UIImage imageNamed:backImage];
        [self.backView addSubview:self.backImageView];
        
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 * SCALE_HEIGHT, self.backImageView.bounds.size.width, 20 * SCALE_HEIGHT)];
        self.titleLabel.textColor = [UIColor colorWithRed:0.30f green:0.30f blue:0.30f alpha:1.00f];
        self.titleLabel.font = FONT(14, 0);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = title;
        [self.backImageView addSubview:self.titleLabel];
        
        
    
        ///  TF
        _TF = [[UITextField alloc]init];
        _TF.frame = CGRectMake(0, 0, 0, 0);
        _TF.delegate = self;
        _TF.keyboardType=UIKeyboardTypeNumberPad;
        [_TF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_TF];
        
        
        
        
        ///  假的输入框
        _view_box = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.backImageView.frame) + 43 * SCALE_WIDTH,CGRectGetMaxY(self.titleLabel.frame) + 18 * SCALE_HEIGHT, boxWidth, boxWidth)];
        [_view_box.layer setBorderWidth:1.0];
        _view_box.layer.borderColor = [[UIColor grayColor]CGColor];
        [self.backView addSubview:_view_box];
        
        
        _view_box2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.backImageView.frame) +53* SCALE_WIDTH+boxWidth*1, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box2.layer setBorderWidth:1.0];
        _view_box2.layer.borderColor = [[UIColor grayColor]CGColor];
        [self.backView addSubview:_view_box2];
        
        
        _view_box3 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.backImageView.frame) +63* SCALE_WIDTH+boxWidth*2, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box3.layer setBorderWidth:1.0];
        _view_box3.layer.borderColor = [[UIColor grayColor]CGColor];
        [self.backView addSubview:_view_box3];
        
        
        _view_box4 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.backImageView.frame) +73* SCALE_WIDTH+boxWidth*3, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box4.layer setBorderWidth:1.0];
        _view_box4.layer.borderColor = [[UIColor grayColor]CGColor];
        [self.backView addSubview:_view_box4];
        
        
        _view_box5 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.backImageView.frame) +83* SCALE_WIDTH+boxWidth*4, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box5.layer setBorderWidth:1.0];
        _view_box5.layer.borderColor = [[UIColor grayColor]CGColor];
        [self.backView addSubview:_view_box5];
        
        
        _view_box6 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.backImageView.frame) +93* SCALE_WIDTH+boxWidth*5, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box6.layer setBorderWidth:1.0];
        _view_box6.layer.borderColor = [[UIColor grayColor]CGColor];
        [self.backView addSubview:_view_box6];
        
        
        ///   密码点
        _lable_point = [[UILabel alloc]init];
        _lable_point.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10 * SCALE_WIDTH)/2, 10 * SCALE_WIDTH, 10 * SCALE_HEIGHT);
        [_lable_point.layer setCornerRadius:5 * SCALE_WIDTH];
        [_lable_point.layer setMasksToBounds:YES];
        _lable_point.backgroundColor = [UIColor blackColor];
        [_view_box addSubview:_lable_point];
        
        _lable_point2 = [[UILabel alloc]init];
        _lable_point2.frame = CGRectMake((_view_box.frame.size.width-10 * SCALE_WIDTH)/2, (_view_box.frame.size.width-10)/2, 10 * SCALE_WIDTH, 10 * SCALE_HEIGHT);
        [_lable_point2.layer setCornerRadius:5 * SCALE_WIDTH];
        [_lable_point2.layer setMasksToBounds:YES];
        _lable_point2.backgroundColor = [UIColor blackColor];
        [_view_box2 addSubview:_lable_point2];
        
        
        _lable_point3 = [[UILabel alloc]init];
        _lable_point3.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10 * SCALE_WIDTH, 10 * SCALE_HEIGHT);
        [_lable_point3.layer setCornerRadius:5 * SCALE_WIDTH];
        [_lable_point3.layer setMasksToBounds:YES];
        _lable_point3.backgroundColor = [UIColor blackColor];
        [_view_box3 addSubview:_lable_point3];
        
        _lable_point4 = [[UILabel alloc]init];
        _lable_point4.frame = CGRectMake((_view_box.frame.size.width-10 * SCALE_WIDTH)/2, (_view_box.frame.size.width-10 *SCALE_WIDTH)/2, 10 * SCALE_WIDTH, 10 * SCALE_HEIGHT);
        [_lable_point4.layer setCornerRadius:5 * SCALE_WIDTH];
        [_lable_point4.layer setMasksToBounds:YES];
        _lable_point4.backgroundColor = [UIColor blackColor];
        [_view_box4 addSubview:_lable_point4];
        
        _lable_point5 = [[UILabel alloc]init];
        _lable_point5.frame = CGRectMake((_view_box.frame.size.width-10 * SCALE_WIDTH)/2, (_view_box.frame.size.width-10 * SCALE_WIDTH)/2, 10 * SCALE_WIDTH, 10 * SCALE_HEIGHT);
        [_lable_point5.layer setCornerRadius:5 * SCALE_WIDTH];
        [_lable_point5.layer setMasksToBounds:YES];
        _lable_point5.backgroundColor = [UIColor blackColor];
        [_view_box5 addSubview:_lable_point5];
        
        _lable_point6 = [[UILabel alloc]init];
        _lable_point6.frame = CGRectMake((_view_box.frame.size.width-10 * SCALE_WIDTH)/2, (_view_box.frame.size.width-10 * SCALE_WIDTH)/2, 10 * SCALE_WIDTH, 10 * SCALE_HEIGHT);
        [_lable_point6.layer setCornerRadius:5 * SCALE_WIDTH];
        [_lable_point6.layer setMasksToBounds:YES];
        _lable_point6.backgroundColor = [UIColor blackColor];
        [_view_box6 addSubview:_lable_point6];
        
        _lable_point.hidden=YES;
        _lable_point2.hidden=YES;
        _lable_point3.hidden=YES;
        _lable_point4.hidden=YES;
        _lable_point5.hidden=YES;
        _lable_point6.hidden=YES;
    
        

        self.cancelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.backImageView.frame), CGRectGetMaxY(self.backImageView.frame), self.backImageView.frame.size.width/2, 40 * SCALE_HEIGHT)];
        self.cancelImageView.userInteractionEnabled = YES;
        self.cancelImageView.image = [UIImage imageNamed:cancelImage];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self.cancelImageView addGestureRecognizer:singleTap];
        [self.backView addSubview:self.cancelImageView];
        
        self.makeSureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.backImageView.frame), CGRectGetMaxY(self.backImageView.frame), self.backImageView.frame.size.width/2, 40 * SCALE_HEIGHT)];
        self.makeSureImageView.userInteractionEnabled = YES;
        self.makeSureImageView.image = [UIImage imageNamed:makeSureImage];
        UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeSure)];
        [self.makeSureImageView addGestureRecognizer:singleTap2];
        [self.backView addSubview:self.makeSureImageView];
        
    }
    return self;
}
#pragma mark -  确定按钮
-(void)makeSure
{
    if (self.btnClickBlock) {
        self.btnClickBlock(self.passwordStr);
    }
    
//    [self dismiss];
}
#pragma mark - 出现
-(void)show
{   //成为第一响应者。弹出键盘
    [_TF becomeFirstResponder];
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    self.backView.alpha = 0;
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.backView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void) textFieldDidChange:(id) sender
{

    UITextField *_field = (UITextField *)sender;
    switch (_field.text.length) {
        case 0:
        {
            _lable_point.hidden=YES;
            _lable_point2.hidden=YES;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 1:
        {
            _lable_point.hidden=NO;
            _lable_point2.hidden=YES;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 2:
        {
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 3:
        {
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 4:
        {
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 5:
        {
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            _lable_point5.hidden=NO;
            _lable_point6.hidden=YES;
        }
            break;
        case 6:
        {
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            _lable_point5.hidden=NO;
            _lable_point6.hidden=NO;
        }
            break;
            
        default:
            break;
    }
    
    if (_field.text.length==6)
    {
       self.passwordStr = _field.text;
    }
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self endEditing:YES];
//    //成为第一响应者。弹出键盘
//    [_TF becomeFirstResponder];
//}
-(void)fingerTapped:(UITapGestureRecognizer *)sender
{
    [self dismiss];
}
-(void)fingerTapped1:(UITapGestureRecognizer *)sender
{
    [_TF becomeFirstResponder];
}
@end
