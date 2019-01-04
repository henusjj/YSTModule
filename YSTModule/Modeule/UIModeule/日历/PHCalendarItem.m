//
//  PHCalendarItem.m
//  PHPackAge
//
//  Created by wdx on 16/8/10.
//  Copyright © 2016年 wdx. All rights reserved.
//

#import "PHCalendarItem.h"




@implementation PHCalendarItem
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self newView];
    }
    return self;
}
-(void)newView{
    
    _labelTitle=[UIButton new];
    _labelTitle.userInteractionEnabled=NO;
    _labelTitle.titleLabel.textAlignment=NSTextAlignmentCenter;
    _labelTitle.titleLabel.font=[UIFont systemFontOfSize:13];
    _labelTitle.backgroundColor=[UIColor lightGrayColor];
    [_labelTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_labelTitle];
    
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (selected) {
        _labelTitle.backgroundColor=[UIColor redColor];
    }else{
        _labelTitle.backgroundColor=[UIColor lightGrayColor];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _labelTitle.frame=CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10 );
    _labelTitle.centerX=self.width/2;
    _labelTitle.centerY=self.height/2;
    _labelTitle.layer.cornerRadius=_labelTitle.width/2;
    _labelTitle.layer.masksToBounds=YES;
//    _labelTitle.titleLabel.text=[NSString stringWithFormat:@"%d",_day];
    [_labelTitle setTitle:[NSString stringWithFormat:@"%ld",(long)_day] forState:UIControlStateNormal];
    switch (_itemType) {
        case PHCalendarItemType1:
//            self.backgroundColor=[UIColor purpleColor];
            break;
        case PHCalendarItemType2:
//            self.backgroundColor=[UIColor blueColor];
            break;
            
        default:
            break;
    }
//    self.viewImg.backgroundColor=[UIColor lightGrayColor];
  
    if (_isToday) {
        self.labelTitle.backgroundColor=[UIColor blueColor];
    }
    if (self.selected) {
        self.labelTitle.backgroundColor=[UIColor redColor];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
