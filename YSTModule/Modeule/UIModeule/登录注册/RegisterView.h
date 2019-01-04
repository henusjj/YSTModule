//
//  RegisterView.h
//  LCF_Demo
//
//  Created by 李晨芳 on 2018/6/7.
//  Copyright © 2018年 李晨芳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJ_CodeBtn.h"

@protocol RegisterViewDelegate <NSObject>
@optional  //用这个标记  可不实现

/**
 立即登录的方法
 
 @param sender 登录的按钮
 @param phoneNumber 输入的手机号
 @param passWord 输入的密码
 @param code 输入的验证码
 */
-(void)registerBtnDidClick:(UIButton * )sender phoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord code:(NSString *)code;

/**
 三方登录点击事件
 
 @param thirdType 登录的类型 0 微信  1qq
 */
-(void)thirdLoginWithThirdType:(NSInteger )thirdType;


/**
 发送验证码事件
 
 @param sender 按钮
 */
-(void)sendCodeBtnDidClick:(PJ_CodeBtn *)sender;

/**
 返回按钮
 
 @param sender 返回按钮
 */
-(void)backBtnDidClick:(UIButton *)sender;


@end


@interface RegisterView : UIView
/** 代理 */
@property (nonatomic, assign) id<RegisterViewDelegate> delegate;
@end
