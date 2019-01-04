//
//  PJ_CodeBtn.h
//  PuJiTown
//
//  Created by 李晨芳 on 2018/2/23.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJ_CodeBtn : UIButton

/**
 设置发送验证码的按钮

 @param titleColor 重新发送字体的颜色
 @param color 倒数描述字体的颜色
 @param TotalSeconds 总共的秒数
 */
-(void)TheGetCodeDown:(UIColor *)titleColor withSecondColor:(UIColor *)color WithSeconds:(NSInteger)TotalSeconds;

@end
