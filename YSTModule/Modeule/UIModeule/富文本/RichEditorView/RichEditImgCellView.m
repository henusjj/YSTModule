//
//  RichEditImgCellView.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "RichEditImgCellView.h"
#import "RichEditPalyVideoView.h"
#import "RichEditModel.h"

@interface RichEditImgCellView ()
@property (nonatomic,strong)UIImageView * imgView;

@property (nonatomic,strong)UIImageView * goodSLogImg;

@property (nonatomic,strong)UIButton * deleBtn;
@end

@implementation RichEditImgCellView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES;//    _imgView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_imgView];
//    [_imgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
    
    _goodSLogImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    _goodSLogImg.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _goodSLogImg.contentMode = UIViewContentModeCenter;
    [self addSubview:_goodSLogImg];
    _goodSLogImg.image = [UIImage imageNamed:@"bofang"];
    _goodSLogImg.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerBtnClick)];
    [_goodSLogImg addGestureRecognizer:tap];
    
    _deleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    _deleBtn.top =  10;
//    _deleBtn.right = self.width - 10;
    [self addSubview:_deleBtn];
    [_deleBtn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    [_deleBtn addTarget:self action:@selector(deleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setModel:(RichEditModel *)model{
    [super setModel:model];
    
    
    _goodSLogImg.hidden = YES;
    if (model.cellType == RichEditCellViewTypeImg) {
        NSString * imgUrl = [NSString stringWithFormat:@"%@",model.content];
        //MARK:此时用的是本地路径 如果你使用需要换成网络url
//        [_imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"moren"]];
        _imgView.image = [UIImage imageWithContentsOfFile:model.content];

        NSDictionary * urlPara = [self dictionaryForGetLinkParaWithUrlLink:imgUrl];
        if (urlPara) {
            NSString * width = [NSString stringWithFormat:@"%@",urlPara[@"width"]];
            NSString * height = [NSString stringWithFormat:@"%@",urlPara[@"height"]];
            if (width && height) {
                _imgView.height = _imgView.width * ([height floatValue]/[width floatValue]);
                self.height = _imgView.bottom;
            }
        }

    }
    
    if (model.cellType == RichEditCellViewTypeVideo) {
//        [_imgView sd_setImageWithURL:[NSURL URLWithString:model.videoCoverUrl] placeholderImage:[UIImage imageNamed:@"moren"]];
        _imgView.image = [UIImage imageWithContentsOfFile:model.videoCoverUrl];
        _goodSLogImg.hidden = NO;
    }
}
#pragma mark -- btnClick
-(void)deleBtnClick:(UIButton *)sender{
    if (_deleBlock) {
        _deleBlock(self.row);
    }
}
/** 获取链接的参数 并且转化为字典 */
- (NSDictionary *)dictionaryForGetLinkParaWithUrlLink:(NSString *)urlLink{
    NSDictionary * dic;
    if ([urlLink containsString:@"?"]) {
        NSMutableDictionary * dicTem = [NSMutableDictionary dictionary];
        NSString * paraString =  [urlLink componentsSeparatedByString:@"?"].lastObject;
        
        
        
        NSArray * paraS = [paraString componentsSeparatedByString:@"&"];
        for (NSString * para in paraS) {
            
            NSArray * paraKeyAndValue = [para componentsSeparatedByString:@"="];
            NSString * key = paraKeyAndValue.firstObject;
            NSString * value = paraKeyAndValue.lastObject;
            
            
            [dicTem addEntriesFromDictionary:@{key:value}];
        }
        dic = [NSDictionary dictionaryWithDictionary:dicTem];
    }
    return dic;
}
-(void)centerBtnClick{
    
    RichEditPalyVideoView *play= [[RichEditPalyVideoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withVideoUrl:self.model.videoUrl];
//    play.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    [[UIApplication sharedApplication].keyWindow addSubview:play];
    [play showPlayer];
    
}

@end
