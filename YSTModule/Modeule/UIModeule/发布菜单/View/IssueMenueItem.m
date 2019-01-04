//
//  IssueMenueItem.m
//  YSTModule
//
//  Created by 李慧静 on 2018/6/27.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "IssueMenueItem.h"

@implementation IssueMenueItem
+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title
{
    IssueMenueItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    
    return item;
}
@end
