//
//  TagView.m
//  ComponentNavPage
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "TagView.h"


@implementation TagView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
}


-(void)refreshUI{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    for (int i = 0; i < _tags.count; i ++) {
        id tag =  _tags[i];
        if([tag isKindOfClass:[NSString class]]){ //
            
            NSString * typeString = [NSString stringWithFormat:@"%@",tag];
            [self createBtnWithBaseY:0 index:i title:typeString tag:100 + i];
            
        }
    }
    
    [self layout];
}
-(void)createBtnWithBaseY:(CGFloat)baseY index:(NSInteger)index title:(NSString *)title tag:(NSInteger)tag{
    
    CGFloat space = 20;
    CGFloat btnW = 100;
    CGFloat btnH = 30;
    CGFloat btnX = 10;
    CGFloat btnY = 10;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.8] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    [btn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setBackgroundColor:[UIColor colorWithR:200.0 G:20.0 B:27.0 alpha:1] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.tag = tag;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    [btn sizeToFit];
    btn.width = btn.width + 20;
    btn.height = btn.height + 15;
    if (btn.width < 60) {
        btn.width = 60;
    }
    if (btn.height < 25) {
        btn.height = 25;
    }
    
    btn.layer.cornerRadius = 3;
    btn.layer.borderColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.8].CGColor;
    btn.layer.borderWidth = 0.5;
    btn.layer.masksToBounds = YES;
    
}


-(void)layout{
    
    
    CGFloat leftEdge = 0;
    CGFloat spaceX = 20;
    CGFloat spaceY = 10;
    
    CGFloat setX = leftEdge;
    CGFloat setY = 0;
    CGFloat setW = 100;
    CGFloat setH = 30;
    
    for (UIView * subView in self.subviews) {
        if (subView.tag >= 100) {
            
            subView.left = setX;
            subView.top = setY;
            setX = subView.right + spaceX;
            if (subView.right > self.width - 10) {
                setX = leftEdge;
                setY = subView.bottom + spaceY;
                
                subView.left = setX;
                subView.top = setY;
                setX = subView.right + spaceX;
            }
            
        }
    }
    
    self.height = self.subviews.lastObject.bottom + 10;
    
}

-(void)setTags:(NSArray *)tags{
    _tags =tags;
    [self refreshUI];
}
//-(void)setFrame:(CGRect)frame{
//    super.frame = frame;
//    [self layout];
//}

#pragma mark -- 点击事件
-(void)btnClick:(UIButton *)sender{
    if (_clickCall) {
        _clickCall(sender.tag - 100);
    }
    
}
@end
