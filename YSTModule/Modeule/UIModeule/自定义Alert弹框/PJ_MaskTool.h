//
//  LFYMaskTool.h
//  专卖商城 - iOS
//
//  Created by YSTLFY on 2017/5/27.
//  Copyright © 2017年 重庆易耀通科技股份有限公司. All rights reserved.
//  在window上添加蒙版

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PJ_MaskTool : NSObject<UIGestureRecognizerDelegate>
+(void)addMaskToView:(UIView *)view  alpha:(CGFloat)alpha;
/*
 添加蒙板在window
 */
+ (UIView *)addMaskToWindow;
/*
 移除模板
 */
+ (void)removeMaskFromWindow;
//隐藏
+ (void)hideMaskInWindow;

@end
