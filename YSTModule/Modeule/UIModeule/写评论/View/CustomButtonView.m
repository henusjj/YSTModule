//
//  CustomButtonView.m
//  YSTModule
//
//  Created by 冯亮亮 on 2018/7/10.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "CustomButtonView.h"
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例
#define SCALE_HEIGHT  kScreenHeight/667.f //适配比例

@implementation CustomButtonView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUIWithFrame:frame];
    }
    return self;
}
-(void)initUIWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor whiteColor];
//    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15 * SCALE_WIDTH, 15 * SCALE_HEIGHT, frame.size.width - 30 * SCALE_WIDTH, frame.size.height - 30 * SCALE_HEIGHT)];
    self.iconImageView = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.iconImageView.frame = CGRectMake(15 * SCALE_WIDTH, 15 * SCALE_HEIGHT, frame.size.width - 30 * SCALE_WIDTH, frame.size.height - 30 * SCALE_HEIGHT);
    [self addSubview:self.iconImageView];
    
    
    
    self.iconButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.iconButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self addSubview:self.iconButton];
}

@end
