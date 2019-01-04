//
//  AppraiseListTableView.h
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/19.
//  Copyright © 2018年 yst.com. All rights reserved.
//评价列表子tableview

#import <UIKit/UIKit.h>
#import "AppraiseListM.h"

/*好评差评分类*/
typedef void (^selectButtonForAppraiseType)(NSInteger index);

/*类型：1.服务评价，2.商品评价*/
typedef NS_ENUM(NSInteger, AppraiseType)
{
    AppraiseServe = 1,
    AppraiseGoods
    
};
@interface AppraiseListTableView : UIView
@property (nonatomic,copy) selectButtonForAppraiseType selectTypeBlock;
/*评价数据源*/
@property (nonatomic,strong) NSArray *arrAppraiseList;

@property (nonatomic,assign) AppraiseType type;

/**/
@property (nonatomic,strong) AppraiseContentN *appraiseM;
@end
