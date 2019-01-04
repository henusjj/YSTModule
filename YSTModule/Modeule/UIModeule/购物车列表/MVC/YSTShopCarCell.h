//
//  YSTShopCarCell.h
//  ShopCarListDemo
//
//  Created by penglaizhi on 2018/6/12.
//  Copyright © 2018年 决心. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopM.h"
#import "HeaderForShopCar.h"
@interface YSTShopCarCell : UITableViewCell
/*商品详情*/
@property (nonatomic,strong) ShopChild *childM;

+(instancetype)cellWithtableViewForGoodsCarN:(UITableView *)tableview;

@end
