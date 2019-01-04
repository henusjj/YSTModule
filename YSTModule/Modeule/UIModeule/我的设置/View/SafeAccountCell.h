//
//  SafeAccountCell.h
//  PuJiTown
//
//  Created by 李晨芳 on 2018/2/22.
//  Copyright © 2018年 yst.com. All rights reserved.
//  账号安全cell

#import <UIKit/UIKit.h>

@interface SafeAccountCell : UITableViewCell
/**
 左边title
 */
@property(nonatomic,strong) UILabel * leftTitle;
/**
 右边title
 */
@property(nonatomic,strong) UILabel * rightTitle;
/**
 选择按钮switch
 */
@property(nonatomic,strong) UISwitch * switchBtn;
/**
 next图标
 */
@property(nonatomic,strong) UIImageView * nextImage;

/** 开关值改变的事件*/ 
@property (nonatomic, copy) void (^switchBtnBlock)(SafeAccountCell * controllCell,UISwitch * assSwitch);

@end
