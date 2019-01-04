//
//  AppraiseListNCell.h
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/19.
//  Copyright © 2018年 yst.com. All rights reserved.
//评价cell

#import <UIKit/UIKit.h>
#import "AppraiseListM.h"

@interface AppraiseListNCell : UITableViewCell
/*图片张数*/
@property (nonatomic,assign) NSInteger type;
/*评论内容*/
@property (nonatomic,copy) NSString *strContent;
/*评价模型*/
@property (nonatomic,strong) BiglistGoods *appraiseM;
/*创建服务评价和商品的cell*/
+(instancetype)cellWithtableViewForAppraiseList:(UITableView *)tableview;
@end
