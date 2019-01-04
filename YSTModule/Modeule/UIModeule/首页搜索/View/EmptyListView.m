//
//  EmptyListView.m
//  PuJiTown
//
//  Created by penghui on 2018/2/25.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "EmptyListView.h"

@implementation EmptyListView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imgName:(NSString *)imgName{
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        self.imgName = imgName;
        [self initUI];
    }
    return self;
    
}

-(void)initUI{
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.imgView.image = [UIImage imageNamed:_imgName];
    [self addSubview:self.imgView];
    self.imgView.center = CGPointMake(self.width / 2, self.height / 2 -100);
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imgView.bottom + 20, self.width, 20)];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor =[UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1] ;//[UIColor colorWithR:196 G:196 B:196];
    label.text = _title;
    [self addSubview:label];
    label.top = self.imgView.bottom + 20;
    label.centerX = self.imgView.centerX;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
