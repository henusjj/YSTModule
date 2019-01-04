//
//  ShopStandard.h
//  YSTModule
//
//  Created by 节庆霞 on 2018/7/6.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol shopStandardDelegate <NSObject>
//选择的是规格是什么
- (void)selectedDic:(NSDictionary *)dic selectedStr:(NSString *)str;
@end

@interface ShopStandard : UIView

@property (nonatomic,weak)id<shopStandardDelegate> delegate;//代理

- (instancetype)initWithFrame:(CGRect)frame productId:(NSString *)productid;

@end
