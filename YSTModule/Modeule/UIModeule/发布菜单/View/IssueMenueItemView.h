//
//  IssueMenueItemView.h
//  YSTModule
//
//  Created by 李慧静 on 2018/6/27.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IssueMenueItemView;


@protocol IssueMenueItemViewDelegate <NSObject>

/** 点击功能按钮*/
- (void)springMenu:(IssueMenueItemView *)menu didClickButtonWithIndex:(NSInteger)index;
/** 隐藏的方法*/
-(void)resignCurrentActive:(IssueMenueItemView*)menu;

-(void)resignCurrentActiveEnd:(IssueMenueItemView*)menu;

@end

@interface IssueMenueItemView : UIView

@property (weak, nonatomic) id<IssueMenueItemViewDelegate> delegate;

/** 存储按钮图片和描述文字 */
@property (strong, nonatomic) NSArray *items;

@property (strong,nonatomic) NSArray<NSArray *> *menueClass;
/** 按钮列数 */
@property (assign, nonatomic) NSInteger columns;
/** 按钮直径 */
@property (assign, nonatomic) CGFloat buttonDiameter;
/** 按钮文字颜色 */
@property (strong, nonatomic) UIColor *buttonTitleColor;
/** 按钮显示后，最底部的按钮，距离底部的距离 */
@property (assign, nonatomic) CGFloat spaceToBottom;
/** 允许点击背景隐藏 */
@property (assign, nonatomic, getter=isEnableTouchResignActive) BOOL enableTouchResignActive;

+ (instancetype)menuWithFrame:(CGRect)frame items:(NSArray *)items;

- (void)becomeActive;

- (void)resignActive;

@end
