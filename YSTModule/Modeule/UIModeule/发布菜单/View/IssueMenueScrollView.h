//
//  IssueMenueScrollView.h
//  YSTModule
//
//  Created by 李慧静 on 2018/6/27.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IssueMenueScrollView,IssueMenueItemView;

@protocol IssueMenueScrollViewDelegate <NSObject>

// 点击功能按钮
- (void)springMenu:(IssueMenueScrollView *)menu menueItemView:(IssueMenueItemView *)itemView didClickButtonWithIndex:(NSInteger)index;

// 点击底部按钮
- (void)springMenu:(IssueMenueScrollView *)menu didClickBottomActiveButton:(UIButton *)button;

@end

@protocol IssueMenueScrollViewDataSource <NSObject>
@optional
// 返回背景颜色
- (UIView *)backgroundViewOfSpringMenu:(IssueMenueScrollView *)menu;

@optional
//返回的菜单栏
- (UIScrollView *)backgroundScrollViewOfSpringMenu:(IssueMenueScrollView *)menu;
// 返回底部的按钮
- (UIButton *)buttonToChangeActiveForSpringMenu:(IssueMenueScrollView *)menu;
// 返回pageControl
- (UIPageControl *)bottomPageControlOfSpringMenu:(IssueMenueScrollView *)menu;
@end


@interface IssueMenueScrollView : UIView
@property (weak, nonatomic) id<IssueMenueScrollViewDelegate> delegate;

@property (weak, nonatomic) id<IssueMenueScrollViewDataSource> dataSource;

/** 分类菜单栏数组 */
@property (strong, nonatomic) NSArray<NSArray*> *menusItems;

/** 按钮显示后，最底部的按钮，距离底部的距离 */
@property (assign, nonatomic) CGFloat spaceToBottom;

/** 允许点击背景隐藏 */
@property (assign, nonatomic, getter=isEnableTouchResignActive) BOOL enableTouchResignActive;

+(instancetype)menuWithItems:(NSArray *)items;

- (void)becomeActive;

- (void)resignActive;
@end
