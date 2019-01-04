//
//  WriteCommentView.h
//  YSTModule
//
//  Created by 冯亮亮 on 2018/7/10.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButtonView.h"

@interface WriteCommentView : UIView
@property(nonatomic,strong)UIView *backView;//灰色背景
@property(nonatomic,strong)UIImageView *iconImageView;//图标
@property(nonatomic,strong)UILabel *placeLabel;//写评论
@property(nonatomic,strong)UIButton *writeButton;//灰色背景上面的按钮
@property(nonatomic,strong)CustomButtonView *zanView;//点赞
@property(nonatomic,strong)CustomButtonView *shareView;//分享
@property(nonatomic,strong)CustomButtonView *collectView;//收藏
@end
