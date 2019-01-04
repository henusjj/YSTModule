//
//  TradePasswordAlertView.h
//  EquityTradingPlatform
//
//  Created by 冯亮亮 on 2018/5/23.
//  Copyright © 2018年 冯亮亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//#define  boxWidth (SCREEN_WIDTH -70)/6 //密码框的宽度
#define boxWidth 24 * SCALE_WIDTH //密码框的宽度
@interface TradePasswordAlertView : UIView<UITextFieldDelegate>

///  TF
@property (nonatomic,)UITextField *TF;

///  假的输入框
@property (nonatomic,)UIView *view_box;
@property (nonatomic,)UIView *view_box2;
@property (nonatomic,)UIView *view_box3;
@property (nonatomic,)UIView *view_box4;
@property (nonatomic,)UIView *view_box5;
@property (nonatomic,)UIView *view_box6;

///   密码点
@property (nonatomic,)UILabel *lable_point;
@property (nonatomic,)UILabel *lable_point2;
@property (nonatomic,)UILabel *lable_point3;
@property (nonatomic,)UILabel *lable_point4;
@property (nonatomic,)UILabel *lable_point5;
@property (nonatomic,)UILabel *lable_point6;

/**
 弹出视图
 @return 视图
 */
- (instancetype)initWithTitle:(NSString *)title BackImage:(NSString *)backImage cancelImage:(NSString *)cancelImage makeSureImage:(NSString *)makeSureImage clickBlock:(void(^)(NSString *password))btnClickBlock;
-(void)show;
-(void)dismiss;
@end
