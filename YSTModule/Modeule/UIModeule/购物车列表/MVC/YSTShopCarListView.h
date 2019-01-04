//
//  YSTShopCarListView.h
//  ShopCarListDemo
//
//  Created by penglaizhi on 2018/6/12.
//  Copyright © 2018年 决心. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderForShopCar.h"
#import "ShopM.h"

typedef void (^didSelectedStoreCarCell)(NSInteger index);
typedef void (^didSelectedAllButton)(NSString *price);

@interface YSTShopCarListView : UIView
/*选中的某个购物车*/
@property (nonatomic,copy) didSelectedStoreCarCell selectCell;
/*点击全选按钮更新控制器数据*/
@property (nonatomic,copy) didSelectedAllButton didSelectedAllButtonBlock;
/*商家和商品数据数组*/
@property (nonatomic,strong) NSArray *arrShop;
/*当前的价格合计*/
@property (nonatomic,copy) NSString *priceAllOut;
/*是否处于编辑状态*/
@property (nonatomic,assign) BOOL isEdit;
@end
