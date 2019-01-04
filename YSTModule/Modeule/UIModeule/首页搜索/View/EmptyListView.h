//
//  EmptyListView.h
//  PuJiTown
//
//  Created by penghui on 2018/2/25.
//  Copyright © 2018年 yst.com. All rights reserved.
//
/*
 空列表 要显示的 界面
 */

#import <UIKit/UIKit.h>

@interface EmptyListView : UIView
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imgName:(NSString *)imgName;
@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)NSString * imgName;
@property (nonatomic,strong)UIImageView * imgView;
@end
