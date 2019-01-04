//
//  SjjNavigationController.h
//  ALL-Demo
//
//  Created by 史玉金 on 2018/6/19.
//  Copyright © 2018年 henusjj.com. All rights reserved.
//
#import <UIKit/UIKit.h>
/**
 导航控制器基类
 */
@interface SjjNavigationController : UINavigationController
/*!
*  返回到指定的类视图
*
*  @param ClassName 类名
*  @param animated  是否动画
*/
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;


@end
