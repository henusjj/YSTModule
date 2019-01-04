//
//  SearchPageTitleView.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "SearchPageTitleView.h"

@implementation SearchPageTitleView

-(instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)]) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 2; i ++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i * self.width/2, 0, self.width/2, self.height)];
        [self addSubview:btn];
        btn.tag = 100 + i;
        [btn setTitleColor:[UIColor colorWithWhite:0 alpha:0.8] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:i == 0 ? @"服务项目" : @"分享" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIImageView * sepView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1, self.height - 20)];
    sepView.backgroundColor =  [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.8];
    [self addSubview:sepView];
    sepView.center = CGPointMake(self.width/2, self.height/2);
    
    
    UIImageView * bottomLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 2)];
    bottomLine.tag = 1000;
    bottomLine.backgroundColor = [UIColor colorWithRed:200/255.0 green:20.0/255.0 blue:27.0/255.0 alpha:1];
    bottomLine.bottom = self.height - 5;
    [self addSubview:bottomLine];
    
    self.index = 0;
}
#pragma mark --
-(void)setIndex:(NSUInteger)index{
    _index = index;
    if (_index != 0 && _index != 1) {
        return;
    }
    
    UIImageView * bottomLine = [self viewWithTag:1000];
    bottomLine.centerX = [self viewWithTag:100+index].centerX;
}
#pragma mark -- 点击事件
-(void)btnClick:(UIButton *)sender{
    
    if (_selectCallBack) {
        _selectCallBack(sender.tag - 100);
    }
    
    self.index = sender.tag - 100;
}

@end
