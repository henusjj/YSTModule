//
//  ShareListCell.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "ShareListCell.h"
#import "ImgShowView.h"
#import "PHCellHeight.h"


@interface ShareListCell ()
@property (nonatomic,strong)UIView * backView;


@property (nonatomic,strong)UILabel * labelTitle;
@property (nonatomic,strong)UILabel * labelContent;

@property (nonatomic,strong)ImgShowView * imgContentView;
@property (nonatomic,strong)UIButton * btnShare;
@property (nonatomic,strong)UIButton * btnComment;
@property (nonatomic,strong)UIButton * btnPrise;
@end

@implementation ShareListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
    
}
-(void)initUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 100)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_backView];
    
    _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, _backView.width - 20, 20)];
    _labelTitle.font = [UIFont systemFontOfSize:15];
    _labelTitle.textColor = [UIColor colorWithWhite:0 alpha:0.8];
    _labelTitle.numberOfLines = 0;
    _labelTitle.text = @"分享";
    [_backView addSubview:_labelTitle];
    
    _labelContent= [[UILabel alloc]initWithFrame:CGRectMake(10, 10, _backView.width - 20, 20)];
    _labelContent.font = [UIFont systemFontOfSize:15];
    _labelContent.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.8];
    _labelContent.numberOfLines = 0;
    _labelContent.text = @"哈哈哈哈或或或或或或或";
    [_backView addSubview:_labelContent];
    
    _imgContentView = [[ImgShowView alloc]initWithFrame:CGRectMake(10, 10, _backView.width - 20, 100)];
    [_backView addSubview:_imgContentView];
    
    
    NSArray * icons = @[@"zhuan",@"ping",@"zan"];
    UIView * bottomView= [[UIView alloc]initWithFrame:CGRectMake(0, 10, _backView.width, 20)];
    [_backView addSubview:bottomView];
    
    
    for (int i = 0; i < icons.count; i ++) {
        NSString * icon = icons[i];
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        [btn setTitleColor:[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.8] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.centerX = i * (bottomView.width / 3) + (bottomView.width / 6);
        [bottomView addSubview:btn];
        
        switch (i) {
            case 0:
                _btnShare = btn;
                break;
            case 1:
                _btnComment = btn;
                break;
            case 2:
                _btnPrise = btn;
                break;
            default:
                break;
        }
        
    }
    
    
//    //MARK:假数据
//    _imgContentView.img = 3;//arc4random()%4;
//    [self layout];
//    self.ph_Height = _backView.height;
}
-(void)layout{
    CGFloat setY = 10;
    
    for (UIView * subView in _backView.subviews) {
        subView.top = setY;
        setY = subView.bottom + 10;
    }
    _backView.height = setY;
    
}

-(void)setModel:(NSDictionary *)model{
    _model = model;
    
    _labelTitle.width = _backView.width - 20;
    _labelContent.width = _backView.width - 20;
    
    _labelTitle.text = [NSString stringWithFormat:@"%@",_model[@"title"]];
    _labelContent.text = [NSString stringWithFormat:@"%@",_model[@"Description"]];
    [_labelTitle sizeToFit];
    [_labelContent sizeToFit];
    
    _imgContentView.imgs = _model[@"img"];
    
    
    [_btnShare setTitle:[NSString stringWithFormat:@"  %@",_model[@"shareNum"]] forState:UIControlStateNormal];
    [_btnComment setTitle:[NSString stringWithFormat:@"  %@",_model[@"commentNum"]] forState:UIControlStateNormal];
    [_btnPrise setTitle:[NSString stringWithFormat:@"  %@",_model[@"fabulousNum"]] forState:UIControlStateNormal];
    
    
    
    [self layout];
    self.ph_Height = _backView.height;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
