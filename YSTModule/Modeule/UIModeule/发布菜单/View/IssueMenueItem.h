//
//  IssueMenueItem.h
//  YSTModule
//
//  Created by 李慧静 on 2018/6/27.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IssueMenueItem : NSObject
/** 图片 */
@property (strong, nonatomic) UIImage *image;

/** 文字 */
@property (copy, nonatomic) NSString *title;


+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title;
@end
