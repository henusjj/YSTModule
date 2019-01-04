//
//  PLZQRCodeView.h
//  YSTNewGreatWallMedium
//
//  Created by penglaizhi on 2017/12/14.
//  Copyright © 2017年 zhubiao. All rights reserved.
//我的二维码

#import <UIKit/UIKit.h>
#import "PLZMineM.h"
@interface PLZQRCodeView : UIView
@property (nonatomic,strong) UIButton *buttonMine;//扫一扫按钮
//@property (nonatomic,copy) void (^Summation1)(int b);

@property (nonatomic,strong) DataMine *dataMine;//个人信息，首页传过来的
@end
