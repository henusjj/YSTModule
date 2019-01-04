//
//  YSTButtonCode.h
//  ShopCarListDemo
//
//  Created by penglaizhi on 2018/6/13.
//  Copyright © 2018年 决心. All rights reserved.
//发送验证码

#import <UIKit/UIKit.h>

@interface YSTButtonCode : UIButton
/**
 设置发送验证码的按钮
 
 @param titleColor 重新发送字体的颜色
 @param color 倒数描述字体的颜色
 @param TotalSeconds 总共的秒数
 */
-(void)TheGetCodeDown:(UIColor *)titleColor withSecondColor:(UIColor *)color WithSeconds:(NSInteger)TotalSeconds;
@end
