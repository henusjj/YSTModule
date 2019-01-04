//
//  PLZQRCodeView.m
//  YSTNewGreatWallMedium
//
//  Created by penglaizhi on 2017/12/14.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "PLZQRCodeView.h"
#import "PLZLabel.h"
#import "SGQRCode.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define SCALE_WIDTH  kScreenWidth/375.f
#define SCALE_HEIGHT  kScreenHeight/667.f

@interface PLZQRCodeView ()

@property (nonatomic,strong) UIImageView *imageV;//底部背景图

@property (nonatomic,strong) UIView *viewMeng;//蒙版

@property (nonatomic,strong) UIView *viewData;//实际显示数据的view

@property (nonatomic,strong) UIButton *buttonIcon;//头像

@property (strong,nonatomic) UILabel *labelName;//名字

@property (nonatomic,strong) UILabel *labelDes;//公司或其他描述

@property (strong,nonatomic) UIImageView *imageVQRCode;//二维码图片

@property (nonatomic,strong) UILabel *labelRemind;//二维码下面的提示

@property (nonatomic,strong) UILabel *labeljob;//职业

@property (nonatomic) int newSum;
@end


@implementation PLZQRCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_makeupViewForQRCodeView];
        
    }
    return self;
}
-(UIButton *)buttonMine
{
    
    if (_buttonMine==nil) {
        _buttonMine = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _buttonMine.frame = CGRectMake(kScreenWidth/2-51, CGRectGetMaxY(self.viewData.frame)+20*SCALE_HEIGHT, 102, 36);
        _buttonMine.layer.masksToBounds = YES;
        _buttonMine.layer.cornerRadius = 18;
        //        _buttonMine.layer.borderColor = [UIColor blueColor].CGColor;
        //        _buttonMine.layer.borderWidth = 1;
        
        _buttonMine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _buttonMine.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buttonMine setTitle:@"扫一扫" forState:(UIControlStateNormal)];
        [_buttonMine setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        //        [_buttonMine addTarget:self action:@selector(buttonMineAction) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _buttonMine;
}
//-(void)buttonMineAction
//{
//    PLZQRCodeViewController *QRCodeVC = [[PLZQRCodeViewController alloc] init];
//    [self.navigationController pushViewController:QRCodeVC animated:YES];
//
//}


-(void)p_makeupViewForQRCodeView
{
    self.imageV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.imageV.image = [UIImage imageNamed:@"Headimg"];
    self.imageV.contentMode = UIViewContentModeScaleAspectFill;
    self.imageV.clipsToBounds = YES;
    
    self.viewMeng = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.viewMeng.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    
    CGFloat widViewData = kScreenWidth-40*SCALE_WIDTH;
    CGFloat heighViewData = kScreenHeight-242*SCALE_HEIGHT;
    self.viewData = [[UIView alloc] initWithFrame:CGRectMake(20*SCALE_WIDTH,64*SCALE_HEIGHT+100*SCALE_WIDTH, widViewData, heighViewData)];
    self.viewData.backgroundColor = [UIColor whiteColor];
    
    self.buttonIcon = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.buttonIcon.frame = CGRectMake(40*SCALE_WIDTH, 30*SCALE_HEIGHT, 70*SCALE_HEIGHT, 70*SCALE_HEIGHT);
    self.buttonIcon.layer.masksToBounds = YES;
    self.buttonIcon.layer.cornerRadius = 35*SCALE_HEIGHT;
    [self.buttonIcon setBackgroundImage:[UIImage imageNamed:@"Headimg"] forState:(UIControlStateNormal)];
    self.buttonIcon.backgroundColor = [UIColor grayColor];
    
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.buttonIcon.frame)+20*SCALE_WIDTH, CGRectGetMinY(self.buttonIcon.frame), widViewData-CGRectGetMaxX(self.buttonIcon.frame)-40*SCALE_WIDTH, 20*SCALE_HEIGHT)];
    self.labelName.text = @"小马";
    self.labelName.font = [UIFont systemFontOfSize:14];
    
    self.labelDes = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.buttonIcon.frame)+20*SCALE_WIDTH, CGRectGetMaxY(self.labelName.frame), widViewData-CGRectGetMaxX(self.buttonIcon.frame)-60*SCALE_WIDTH, 30*SCALE_HEIGHT)];
    self.labelDes.numberOfLines = 0;
    self.labelDes.text = @"计算机科技有限公司";
    self.labelDes.font = [UIFont systemFontOfSize:11];
//    self.labelDes.textColor = [UIColor ColorWithString:@"989898"];
    
    self.labeljob = [PLZLabel creatLabelFontNew:[UIFont systemFontOfSize:11] color:@"989898" title:@"ceo" textAlignment:(NSTextAlignmentLeft) frame:CGRectMake(CGRectGetMaxX(self.buttonIcon.frame)+20*SCALE_WIDTH, CGRectGetMaxY(self.labelDes.frame), widViewData-CGRectGetMaxX(self.buttonIcon.frame)-50*SCALE_WIDTH, 16)];
    //    self.labeljob.backgroundColor = [UIColor yellowColor];
    
    self.imageVQRCode = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.buttonIcon.frame), CGRectGetMaxY(self.buttonIcon.frame)+10*SCALE_HEIGHT, widViewData-80*SCALE_WIDTH, widViewData-80*SCALE_WIDTH)];
    //    self.imageVQRCode.image = [UIImage imageNamed:@"Headimg"];
    //    NSString *strUrl = @"https://www.baidu.com/";
    //        self.imageVQRCode.image = [UIImage imageNamed:@"aboutbg"];
    NSString *strUrl = @"https://itunes.apple.com/us/app/%E5%A4%A9%E6%98%93/id1275454279?l=zh&ls=1&mt=8,memberId=0000123456";
    
    NSLog(@"新的数值 = %ld",[[strUrl substringFromIndex:strUrl.length-10] integerValue]);
    
    self.imageVQRCode.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:strUrl logoImageName:[UIImage imageNamed:@"AppIcon"] logoScaleToSuperView:0.25];
    
    self.labelRemind = [[UILabel alloc] initWithFrame:CGRectMake(40*SCALE_WIDTH, CGRectGetMaxY(self.imageVQRCode.frame)+10, widViewData-80*SCALE_WIDTH, 20*SCALE_HEIGHT)];
    self.labelRemind.text = @"扫一扫上面的二维码图案，加关注";
    self.labelRemind.textColor = [UIColor grayColor];
    self.labelRemind.font = [UIFont systemFontOfSize:12];
    self.labelRemind.textAlignment = NSTextAlignmentCenter;
    
    
    [self.viewData addSubview:self.labeljob];
    [self.viewData addSubview:self.imageVQRCode];
    [self.viewData addSubview:self.labelRemind];
    [self.viewData addSubview:self.labelDes];
    [self.viewData addSubview:self.labelName];
    [self.viewData addSubview:self.buttonIcon];
    
    [self addSubview:self.imageV];
    [self addSubview:self.viewMeng];
    [self addSubview:self.viewData];
    //    [self addSubview:self.buttonMine];
    
    
    
}

//模型传进来赋值
-(void)setDataMine:(DataMine *)dataMine
{
    
    _dataMine = dataMine;
    __weak typeof(self) weakSelf = self;
    
    // MARK:需要集成sd_webimage
//    [self.buttonIcon sd_setBackgroundImageWithURL:[NSURL URLWithString:dataMine.address] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"moren"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//        NSString *strUrl = [NSString stringWithFormat:@"%@:%@/%@?memberId=%@&homePage=%@",NGWM_API_HOST,NGWM_API_PORT,PLZ_API_ShareHomePage,dataMine.memberId,dataMine.homePage];
//        weakSelf.imageVQRCode.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:strUrl logoImageName:image logoScaleToSuperView:0.25];
//        weakSelf.imageV.image = image;
//
//
//    }];
    self.labelName.text = dataMine.memberName;
    self.labelDes.text = dataMine.company;
    self.labeljob.text = dataMine.job;
//    if (dataMine.homePage.length<1) {
//        dataMine.homePage = @"55";
//    }
    //    NSLog(@"新的数值 = %@",strUrl);
    
}

@end
