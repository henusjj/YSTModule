//
//  PJ_Textfield.h
//  PuJiTown
//
//  Created by 李晨芳 on 2018/2/23.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJ_Textfield : UITextField


/**
 设置textfield的左边图片的姓名
 
 @param img 图片名字
 */
-(void)setLeftImg:(NSString *)img;

/**
 设置textfield的左边label的文字
 
 @param title 文字
 */
-(void)setLeftTitle:(NSString *)title;
@end
