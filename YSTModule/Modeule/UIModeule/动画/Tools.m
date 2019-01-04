//
//  Tools.m
//  AnimationDemo
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+(UIButton *)createBtnTitle:(NSString *)title Selector:(SEL)selector  target:(id)target{
    UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[Tools imageWithColor:[UIColor clearColor] size:CGSizeMake(ScreenWidth-gap*2, btnHeight)] forState:UIControlStateNormal];
    [btn setBackgroundImage:[Tools imageWithColor:[UIColor yellowColor] size:CGSizeMake(ScreenWidth-gap*2, btnHeight)] forState:UIControlStateHighlighted];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.layer.cornerRadius = 5;
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    return  btn;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
