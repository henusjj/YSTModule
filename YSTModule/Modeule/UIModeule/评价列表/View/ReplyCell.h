//
//  ReplyCell.h
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/29.
//  Copyright © 2018年 yst.com. All rights reserved.
//评价回复的cell

#import <UIKit/UIKit.h>

@interface ReplyCell : UITableViewCell

@property (nonatomic,copy) NSString *strReply;

/*创建评价回复的cell*/
+(instancetype)cellWithtableViewForAppraiseListReply:(UITableView *)tableview;

@end
