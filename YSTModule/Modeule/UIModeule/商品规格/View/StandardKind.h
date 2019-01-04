//
//  StandardKind.h
//  YSTModule
//
//  Created by 节庆霞 on 2018/7/6.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

//代理
@protocol standButtonDelegete <NSObject>

//选择的是那个规格
- (void)selectedInfoView:(NSInteger)viewtag selectedButtonMessage:(NSDictionary *)dic;
@end

@interface StandardKind : UIView
@property (nonatomic,strong)NSArray *mainArray;
@property (nonatomic ,weak) id<standButtonDelegete> delegte;//代理

- (instancetype)initWithFrame:(CGRect)frame contentDic:(NSDictionary *)contentdic;
@end
