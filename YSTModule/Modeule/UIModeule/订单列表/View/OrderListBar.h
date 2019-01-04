//
//  OrderListBar.h
//  YSTModule
//
//  Created by 史玉金 on 2018/7/6.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^IndexBlock)(NSString *title,NSInteger index);

@interface OrderListBar : UIView

@property (nonatomic, strong) UIColor    *lineColor;        //移动线的颜色(默认黑色)
@property (nonatomic, assign) CGFloat    lineHeight;        //移动线的高度(默认2)
@property (nonatomic, assign) CGFloat     lineWide;      //移动线宽度
@property (nonatomic, assign) CGFloat    lineCornerRadius;  //移动线的两边弧度(默认3)
@property (nonatomic, copy  ) IndexBlock indexBlock;        //block回调(返回标题、下标)

/**
 *  设置控件XY位置
 *
 *  @param point 坐标
 *
 *  @return 对象
 */
- (void)setBarPoint:(CGPoint)point;

/**
*  设置数据源与属性
*
*  @param titles  每个选项的标题
*  @param n_color 默认颜色
*  @param s_color 选中颜色
*  @param font    字体
*/
- (void)setData:(NSArray *)titles NormalColor:(UIColor *)n_color SelectColor:(UIColor *)s_color Font:(UIFont *)font;

/**
 *  得到移动的下标与内容
 *
 *  @param block 回调
 */
- (void)getViewIndex:(IndexBlock)block;

/**
 *  设置移动的位置
 *
 *  @param index 下标
 */
- (void)setViewIndex:(NSInteger)index;

@end
