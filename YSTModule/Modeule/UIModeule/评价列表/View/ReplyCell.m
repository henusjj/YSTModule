//
//  ReplyCell.m
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/29.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "ReplyCell.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例
@interface ReplyCell ()

/*左边固定的按钮*/
@property (nonatomic,strong) UIButton *buttonMerchant;
/*右边的回复内容*/
@property (nonatomic,strong) UILabel *labelContent;

@end

@implementation ReplyCell
+(instancetype)cellWithtableViewForAppraiseListReply:(UITableView *)tableview
{
    static NSString *ID = @"ReplyCell";
    
    ReplyCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[ReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell p_makeupViewForReplyCell];
    }
    
    return cell;
    
}
-(void)p_makeupViewForReplyCell
{
    self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.buttonMerchant = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.buttonMerchant setTitle:@"商家：" forState:(UIControlStateNormal)];
    [self.buttonMerchant setImage:[UIImage imageNamed:@"pinglun"] forState:(UIControlStateNormal)];
    [self.buttonMerchant setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    [self.buttonMerchant setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    
    [self.buttonMerchant setTitleColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] forState:(UIControlStateNormal)];
    self.buttonMerchant.titleLabel.font = [UIFont systemFontOfSize:11];
    //    self.buttonMerchant.backgroundColor = [UIColor cyanColor];
    
//    self.labelContent = [PJ_CreatLabel creatLabelFont:11 color:@"666666" title:@"1"];
    self.labelContent = [[UILabel alloc] init];
    self.labelContent.numberOfLines = 0;
    self.labelContent.font = [UIFont systemFontOfSize:11];
    self.labelContent.textColor = [UIColor grayColor];
    
    
    [self.contentView addSubview:self.buttonMerchant];
    [self.contentView addSubview:self.labelContent];
    
    [self.buttonMerchant mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.offset(0);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(60);
    }];
    [self.labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.offset(0);
        make.leading.equalTo(self.buttonMerchant.mas_trailing).offset(1);
        make.bottom.offset(0);
    }];
    
}
-(void)setStrReply:(NSString *)strReply
{
    _strReply = strReply;
    self.labelContent.text = strReply;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
