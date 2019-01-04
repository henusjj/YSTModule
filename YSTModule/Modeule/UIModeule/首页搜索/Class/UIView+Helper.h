//
//  UIView+Helper.h
//  专卖商城 - iOS
//
//  Created by penghui on 2017/12/29.
//  Copyright © 2017年 重庆易耀通科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helper)
#pragma mark -- 当tableView  为空时要显示的界面
@property (nonatomic, copy) UIView * emptyView;
-(void)addEmptyView:(UIView *)emptyView;
@end
