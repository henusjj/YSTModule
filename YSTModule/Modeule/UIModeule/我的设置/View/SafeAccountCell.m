//
//  SafeAccountCell.m
//  PuJiTown
//
//  Created by 李晨芳 on 2018/2/22.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "SafeAccountCell.h"

@implementation SafeAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}
//初始化UI
-(void)initUI{
    //左标题
    self.leftTitle = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, kScreenWidth/2, 45)];
    self.leftTitle.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.leftTitle];
    //    右标题
    self.rightTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 45)];
    self.rightTitle.textAlignment = NSTextAlignmentRight;
    self.rightTitle.font =[UIFont systemFontOfSize:14];
    self.rightTitle.right = kScreenWidth-16;
    [self.contentView addSubview:self.rightTitle];
    self.rightTitle.hidden = YES;
    
    //  nextImg
    self.nextImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-15-16, 16, 16, 16)];
    self.nextImage.image = [UIImage imageNamed:@"person_but_next"];
    [self addSubview:self.nextImage];
    
    //uiswitc
    self.switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(0,0, 60, 30)];
    self.switchBtn.right = kScreenWidth-16;
    self.switchBtn.centerY = 45/2;
    [self.switchBtn addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.switchBtn];
    self.switchBtn.onTintColor = [UIColor colorWithRed:237/255.0 green:84/255.0 blue:82/255.0 alpha:1];
    self.switchBtn.hidden = YES;
    
    //    line
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,45-1, kScreenWidth, 1)];
    line.backgroundColor =  [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self addSubview:line];
}
#pragma mark -----switch开关
-(void)switchClick:(UISwitch *)sender{
//    sender.on = !sender.on;
    if (_switchBtnBlock) {
        _switchBtnBlock(self,self.switchBtn);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
