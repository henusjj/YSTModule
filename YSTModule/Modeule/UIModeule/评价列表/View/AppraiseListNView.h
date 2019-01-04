//
//  AppraiseListNView.h
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/19.
//  Copyright © 2018年 yst.com. All rights reserved.
//评价列表整体自定义view

#import <UIKit/UIKit.h>
#import "AppraiseListM.h"

//typedef void (^selectButtonForAppraise)(NSInteger index);

@interface AppraiseListNView : UIView
//@property (nonatomic,copy) selectButtonForAppraise appraiseBlock;
/*返回按钮*/
@property (nonatomic,strong) UIButton *buttonBack;
/*服务数组*/
@property (nonatomic,strong) NSArray *arrServe;
/*商品*/
@property (nonatomic,strong) NSArray *arrGoods;
/**/
@property (nonatomic,strong) AppraiseContentN *appraiseM;

@end
