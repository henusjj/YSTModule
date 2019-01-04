//
//  YSTIdentificationView.h
//  YSTViewsDemo
//
//  Created by penglaizhi on 2018/6/7.
//  Copyright © 2018年 决心. All rights reserved.
//实名认证的view

#import <UIKit/UIKit.h>
typedef void (^buttonForOKBlock)(NSMutableDictionary *dicMessage);
typedef void (^buttonForCodeBlock)(NSMutableDictionary *dicCode);

@interface YSTIdentificationView : UIView
#pragma mark - 以下为必传或必须实现
/*手机号，不可修改*/
@property (nonatomic,copy) NSString *strPhone;
/*字数限制的数组（textfield允许输入多少字，不知道传一万也可以，必传）*/
@property (nonatomic,strong) NSArray *arrCountNum;
/*标题的数组（必传）*/
@property (nonatomic,strong) NSArray *arrTitle;
/*占位符数组（必传）*/
@property (nonatomic,strong) NSArray *arrPlaceholder;
/*点击提交信息的block,必须回调*/
@property (nonatomic,copy) buttonForOKBlock okBlock;
/*点击发送验证码的block，必须回调*/
@property (nonatomic,copy) buttonForCodeBlock codeBlock;

#pragma mark - 以下为可选实现或非必传
/*提示语字体*/
@property (strong,nonatomic) UIFont *fontRemind;
/*提示语颜色*/
@property (nonatomic,strong) UIColor *colorRemind;
/*按钮背景图*/
@property (nonatomic,strong) UIImage *imageButton;

@end
