//
//  PJ_Textfield.m
//  PuJiTown
//
//  Created by 李晨芳 on 2018/2/23.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "PJ_Textfield.h"
#define COLOR_RGB_ALPHA(R,G,B,a) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:a]
@implementation PJ_Textfield

-(void)setLeftImg:(NSString *)img{
    self.textColor = COLOR_RGB_ALPHA(102, 102, 102, 1);
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *leftImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:img]];
    leftImgView.centerX = leftView.width / 2;
    leftImgView.centerY = leftView.height / 2;
    [leftView addSubview:leftImgView];
    self.leftView = leftView;
}

-(void)setLeftTitle:(NSString *)title{
    self.backgroundColor = [UIColor whiteColor];
    self.textColor = COLOR_RGB_ALPHA(102, 102, 102, 1);
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.leftViewMode = UITextFieldViewModeAlways;
    UILabel * leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 84, 30)];
    leftLabel.font = [UIFont systemFontOfSize:14];
    leftLabel.textColor = COLOR_RGB_ALPHA(34, 34, 34, 1);
    leftLabel.text = title;
    leftLabel.left = 16;
    leftLabel.centerY = leftView.height / 2;
    [leftView addSubview:leftLabel];
    self.leftView = leftView;
}
@end
