//
//  IssueMenueButton.m
//  YSTModule
//
//  Created by 李慧静 on 2018/6/27.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "IssueMenueButton.h"

@implementation IssueMenueButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.bounds.size.width;
    CGFloat btnH = self.bounds.size.height;
    
    CGFloat imageH = btnH * _heightRate / (1 + _heightRate) - self.imageTitleMargin;
    self.imageView.frame = CGRectMake(0, 0, btnW, imageH);
    
    self.titleLabel.frame = CGRectMake(0, imageH + self.imageTitleMargin, btnW, btnH - imageH - self.imageTitleMargin);
}
@end
