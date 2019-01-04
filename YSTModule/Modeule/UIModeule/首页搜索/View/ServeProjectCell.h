//
//  ServeProjectCell.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServeProjectCell : UITableViewCell
@property (nonatomic,strong)NSDictionary* model;
@property (nonatomic,copy)void(^changeFollow)(NSIndexPath  *index);
@end
