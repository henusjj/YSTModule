//
//  ActionSheetAView.m
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/22.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "ActionSheetAView.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例



@implementation ActionSheetAView



+(UIView *)creatActionSheetViewWithTitle:(NSString *)title otherTitles:(NSArray *)array cancleTitle:(NSString *)cancleTitle delegate:(id)delegate
{
    UIView *viewMeng = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    viewMeng.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];

    UIView *viewActionSheet = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight- 52*SCALE_WIDTH-(45*SCALE_WIDTH+1)*(array.count), kScreenWidth, 52*SCALE_WIDTH+(45*SCALE_WIDTH+1)*(array.count))];
    viewActionSheet.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [viewMeng addSubview:viewActionSheet];
    viewMeng.userInteractionEnabled = YES;
    viewActionSheet.userInteractionEnabled = YES;

    UIButton *buttonCacle = [UIButton buttonWithType:(UIButtonTypeCustom)];
    buttonCacle.frame = CGRectMake(0, 7*SCALE_WIDTH+(45*SCALE_WIDTH+1)*(array.count), kScreenWidth, 45*SCALE_WIDTH);
    [buttonCacle addTarget:[ActionSheetAView getCurrentVC] action:@selector(buttonTitleActionInViewSheetAction:) forControlEvents:(UIControlEventTouchUpInside)];
    buttonCacle.tag = 359;
    [buttonCacle setTitle:cancleTitle?cancleTitle:@"关闭" forState:(UIControlStateNormal)];
    [viewActionSheet addSubview:buttonCacle];
    [buttonCacle setTitleColor:[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1] forState:(UIControlStateNormal)];
    buttonCacle.backgroundColor = [UIColor whiteColor];
    buttonCacle.titleLabel.font = [UIFont systemFontOfSize:15];
    
    if (array.count<1) {
        return viewMeng;
    }else{
        for (int i = 0; i<array.count; i++) {
            UIButton *buttonTitle = [UIButton buttonWithType:(UIButtonTypeSystem)];
            buttonTitle.frame = CGRectMake(0, (45*SCALE_WIDTH+1)*(array.count-i-1), kScreenWidth, 45*SCALE_WIDTH);
            [buttonTitle setTitle:array[i] forState:(UIControlStateNormal)];
            buttonTitle.backgroundColor = [UIColor whiteColor];
            [buttonTitle setTitleColor:[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1] forState:(UIControlStateNormal)];
            [buttonTitle addTarget:[ActionSheetAView getCurrentVC] action:@selector(buttonTitleActionInViewSheetAction:) forControlEvents:(UIControlEventTouchUpInside)];
            buttonTitle.tag = 360+i;
            [viewActionSheet addSubview:buttonTitle];
            buttonTitle.titleLabel.font = [UIFont systemFontOfSize:15];
            if (i==array.count) {

            }else{
                UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(buttonTitle.frame)-1, kScreenWidth, 1)];
                viewLine.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
                [viewActionSheet addSubview:viewLine];
            }
        }

    }
    return viewMeng;
}
+ (UIViewController *)getCurrentVC
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    NSLog(@"-- %@ --",result);
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    NSLog(@"-- %@ --",result);
    return result;
}

@end
