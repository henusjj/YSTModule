//
//  ShopM.h
//  ShopCarListDemo
//
//  Created by penglaizhi on 2018/6/12.
//  Copyright © 2018年 决心. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderForShopCar.h"

@class ShopChild;

@interface ShopM : NSObject
/*商铺头像地址*/
@property (nonatomic,copy) NSString *imgUrl;
/*商铺名称*/
@property (nonatomic,copy) NSString *shopName;
/*是否选中*/
@property (nonatomic,assign) BOOL isSelect;

@property (nonatomic,strong) NSMutableArray<ShopChild *> *content;

@end

@interface ShopChild : NSObject
/*上铺头像地址*/
@property (nonatomic,copy) NSString *imgUrl;
/*商铺名称*/
@property (nonatomic,copy) NSString *shopName;
/*单价*/
@property (nonatomic,strong) NSString *price;
/*件数*/
@property (nonatomic,strong) NSString *count;
/*是否选中*/
@property (nonatomic,assign) BOOL isSelect;
/*当前cell分组*/
@property (nonatomic,copy) NSString *section;
@end

