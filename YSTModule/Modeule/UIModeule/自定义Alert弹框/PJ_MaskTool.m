//
//  LFYMaskTool.m
//  专卖商城 - iOS
//
//  Created by YSTLFY on 2017/5/27.
//  Copyright © 2017年 重庆易耀通科技股份有限公司. All rights reserved.
//

#import "PJ_MaskTool.h"

static PJ_MaskTool * _maskTool = nil;

@implementation PJ_MaskTool
+(instancetype)shareMaskTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _maskTool = [[PJ_MaskTool alloc]init];
    });
    return _maskTool;
}
+(void)addMaskToView:(UIView *)view  alpha:(CGFloat)alpha
{
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    // Create a path and add the rectangle in it.
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, maskRect);
    
    // Set the path to the mask layer.
    [maskLayer setPath:path];
    
    // Release the path since it's not covered by ARC.
    CGPathRelease(path);
    view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:alpha];
;
    // Set the mask of the view.
    view.layer.mask = maskLayer;
}
/*
 添加蒙板
 */
+ (UIView *)addMaskToWindow{
    UIView * maskBG = [[UIView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight)];
    maskBG.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4f];
    // Create a mask layer and the frame to determine what will be visible in the view.
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    // Create a path and add the rectangle in it.
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, maskRect);
    
    // Set the path to the mask layer.
    [maskLayer setPath:path];
    
    // Release the path since it's not covered by ARC.
    CGPathRelease(path);
    
    // Set the mask of the view.
    maskBG.layer.mask = maskLayer;
    maskBG.tag = 10000;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskBGGestureTap:)];
    tapGesture.delegate = [PJ_MaskTool shareMaskTool];
    [maskBG addGestureRecognizer:tapGesture];
    [[[UIApplication sharedApplication] delegate].window addSubview:maskBG];
    return maskBG;
}
+(void)maskBGGestureTap:(UITapGestureRecognizer *)tap
{
    if ([[[UIApplication sharedApplication]delegate].window viewWithTag:10000]) {
        UIView * maskBG = (UIView *)[[[UIApplication sharedApplication]delegate].window viewWithTag:10000];
        [maskBG removeFromSuperview];
    };
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UIView * touchView = touch.view;
    NSLog(@"--touchView: %@ --",touchView);
    if (touchView.tag == 10000) {
        return YES;
    }
    return NO;
}
/*
 移除模板
 */
+ (void)removeMaskFromWindow{
    if ([[[UIApplication sharedApplication]delegate].window viewWithTag:10000]) {
        UIView * maskBG = (UIView *)[[[UIApplication sharedApplication]delegate].window viewWithTag:10000];
        [maskBG removeFromSuperview];
        maskBG = nil;
    }
}
+ (void)hideMaskInWindow{
    if ([[[UIApplication sharedApplication]delegate].window viewWithTag:10000]) {
        UIView * maskBG = (UIView *)[[[UIApplication sharedApplication]delegate].window viewWithTag:10000];
        maskBG.hidden = YES;
    }
}

@end
