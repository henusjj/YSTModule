//
//  AppraiseListNCell.m
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/19.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "AppraiseListNCell.h"
#import "ReplyForAppraiseView.h"
//#import "KeyBoardView.h"
//#import "PublishView.h"
#import "AppraiseCollectionCell.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例
@interface AppraiseListNCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
/*顶部view*/
@property (nonatomic,strong) UIView *viewTop;
/*头像*/
@property (nonatomic,strong) UIButton *buttonIcon;
/*昵称*/
@property (nonatomic,strong) UILabel *labelName;
/*评分星星*/
@property (nonatomic,strong) UIButton *buttonStar;
/*时间*/
@property (nonatomic,strong) UILabel *labelTime;
/*内容（文字）*/
@property (nonatomic,strong) UILabel *labelContent;
/*内容（图片）*/
@property (nonatomic,strong) UIView *viewImageV;
/*规格View*/
@property (nonatomic,strong) UIView *viewSpecification;
/*图片下面的线*/
@property (nonatomic,strong) UIView *viewline1;
/*规格*/
@property (nonatomic,strong) UILabel *labelSpecification;
/*时间2(下面的)*/
@property (nonatomic,strong) UILabel *labelTimeDown;
/*规格下面的线*/
@property (nonatomic,strong) UIView *viewline2;
/*浏览数、点赞数、举报、回复按钮父view*/
@property (nonatomic,strong) UIView *viewForFourButton;
/*浏览数*/
@property (nonatomic,strong) UIButton *buttonLook;
/*点赞数*/
@property (nonatomic,strong) UIButton *buttonPraise;
/*举报*/
@property (nonatomic,strong) UIButton *buttonReport;
/*回复*/
@property (nonatomic,strong) UIButton *buttonReply;
/*底部回复view*/
@property (nonatomic,strong) UIView *viewReply;
/*底部回复button(显示用的不可点击)*/
@property (nonatomic,strong) UIButton *buttonReplyContent;
/*所有控件集合*/
@property (nonatomic,strong) UIView *viewAll;
/*点赞取消赞参数字典*/
@property (nonatomic,strong) NSMutableDictionary *dicPram;
/**回复*/
@property (nonatomic,strong) ReplyForAppraiseView *viewReplyTable;
/*评价图片的collectionView*/
@property (nonatomic,strong) UICollectionView *collectionV;

@end

@implementation AppraiseListNCell
#pragma mark - 服务评价
-(NSMutableDictionary *)dicPram
{
    if (_dicPram == nil) {//index代表类型：1点赞，2回复，
        _dicPram = [NSMutableDictionary dictionary];
    }
    return _dicPram;
}
+(instancetype)cellWithtableViewForAppraiseList:(UITableView *)tableview;
{
    static NSString *ID = @"AppraiseListNCell";
    
    AppraiseListNCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[AppraiseListNCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell p_makeupViewForAppraiseListNCell];
    }
    
    return cell;
    
}
-(void)p_makeupViewForAppraiseListNCell
{
    self.contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    self.viewAll = [[UIView alloc] init];
    self.viewAll.backgroundColor = [UIColor whiteColor];
    
    self.viewTop = [[UIView alloc] init];
    
    self.buttonIcon = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.buttonIcon.layer.masksToBounds = YES;
    self.buttonIcon.layer.cornerRadius = 21*SCALE_WIDTH;
    self.buttonIcon.backgroundColor = [UIColor grayColor];
    [self.buttonIcon addTarget:self action:@selector(buttonIconActoionInAppraiseListNCell) forControlEvents:(UIControlEventTouchUpInside)];
    
    
//    self.labelName = [PJ_CreatLabel creatLabelFont:14 color:@"222222" title:@"vitality"];
//    self.labelTime = [PJ_CreatLabel creatLabelFont:11 color:@"666666" title:@"2018-05-19 20:30"];
    self.labelName = [[UILabel alloc] init];
    self.labelName.font = [UIFont systemFontOfSize:14];
    self.labelName.textColor = [UIColor grayColor];
    self.labelName.text = @"vitality";
    
    self.labelTime = [[UILabel alloc] init];
    self.labelTime.font = [UIFont systemFontOfSize:11];
    self.labelTime.textColor = [UIColor grayColor];
    self.labelTime.text = @"2018-05-19 20:30";

    self.labelTime.textAlignment = NSTextAlignmentRight;
    self.buttonStar = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    [self.buttonStar setTitle:@"remark" forState:(UIControlStateNormal)];
    [self.buttonStar setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    [self.buttonStar setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.buttonStar.titleLabel.font = [UIFont systemFontOfSize:10];
    
//    self.labelContent = [PJ_CreatLabel creatLabelFont:13 color:@"222222" title:@"家政是指在家庭这个小群体中，与全体或部分家庭成员生活有关的事情，它带有一种“公事”的意味，另外还含有“要事”的意思。"];
    self.labelContent = [[UILabel alloc] init];
    self.labelContent.numberOfLines = 0;
    self.labelContent.font = [UIFont systemFontOfSize:13];
    self.labelContent.textColor = [UIColor grayColor];
    self.labelContent.text = @"家政是指在家庭这个小群体中，与全体或部分家庭成员生活有关的事情，它带有一种“公事”的意味，另外还含有“要事”的意思。";

    self.viewImageV = [[UIView alloc] init];
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小
    layout.itemSize = CGSizeMake(113*SCALE_WIDTH, 113*SCALE_WIDTH);
    layout.minimumLineSpacing = 3;
    layout.minimumInteritemSpacing = 3;
    //创建collectionView 通过一个布局策略layout来创建
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(1, 1,1,1) collectionViewLayout:layout];
    [self.viewImageV addSubview:self.collectionV];
    //代理设置
    self.collectionV.delegate=self;
    self.collectionV.dataSource=self;
    self.collectionV.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    //注册item类型 这里使用系统的类型
    [self.collectionV registerClass:[AppraiseCollectionCell class] forCellWithReuseIdentifier:@"appraiseCollectCell"];
    self.collectionV.scrollEnabled = NO;
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(0);
        make.trailing.offset(-0);
        make.top.offset(5);
        make.bottom.offset(-5);
    }];
    //    self.viewImageV.backgroundColor = [UIColor redColor];
//    for (int i=0; i<3; i++) {
//        UIImageView *imageV = [[UIImageView alloc] init];
//        imageV.backgroundColor = [UIColor randomColor];
//        imageV.tag = 180+i;
//        imageV.contentMode = UIViewContentModeScaleAspectFill;
//        imageV.clipsToBounds = YES;
//        [self.viewImageV addSubview:imageV];
//
//        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.mas_equalTo(116*SCALE_WIDTH*i);
//            make.top.bottom.offset(0);
//            make.width.mas_equalTo(113*SCALE_WIDTH);
//        }];
//    }
    
    self.viewSpecification = [[UIView alloc] init];
    //    self.viewSpecification.backgroundColor = [UIColor cyanColor];
    self.viewline1 = [[UIView alloc] init];
    self.viewline1.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
//    self.labelSpecification = [PJ_CreatLabel creatLabelFont:12 color:@"222222" title:@"monkey red 64G 66.6"];
    self.labelSpecification = [[UILabel alloc] init];
    self.labelSpecification.font = [UIFont systemFontOfSize:12];
    self.labelSpecification.textColor = [UIColor grayColor];
    self.labelSpecification.text = @"monkey red 64G 66.6";

    self.labelSpecification.numberOfLines = 1;
//    self.labelTimeDown = [PJ_CreatLabel creatLabelFont:11 color:@"666666" title:@"2018-05-19 20:30"];
    self.labelTimeDown = [[UILabel alloc] init];
    self.labelTimeDown.font = [UIFont systemFontOfSize:11];
    self.labelTimeDown.textColor = [UIColor grayColor];
    self.labelTimeDown.text = @"2018-05-19 20:30";

    self.labelTimeDown.textAlignment = NSTextAlignmentRight;
    self.viewline2 = [[UIView alloc] init];
    self.viewline2.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    self.viewForFourButton = [[UIView alloc] init];
    //    self.viewForFourButton.backgroundColor = [UIColor purpleColor];
    
    self.buttonLook = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.buttonLook.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.buttonLook setTitle:@"889" forState:(UIControlStateNormal)];
    [self.buttonLook setImage:[UIImage imageNamed:@"liulan"] forState:(UIControlStateNormal)];
    [self.buttonLook setTitleColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] forState:(UIControlStateNormal)];
    [self.buttonLook setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    
    self.buttonPraise = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.buttonPraise.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.buttonPraise setTitle:@"8819" forState:(UIControlStateNormal)];
    [self.buttonPraise setImage:[UIImage imageNamed:@"AppraiseListdianzan"] forState:(UIControlStateNormal)];
    [self.buttonPraise setTitleColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] forState:(UIControlStateNormal)];
    [self.buttonPraise setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    
    //    self.buttonPraise.backgroundColor = [UIColor redColor];
    //    self.buttonLook.backgroundColor = [UIColor cyanColor];
    
    self.buttonReport = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.buttonReport.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    [self.buttonReport setTitleColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] forState:(UIControlStateNormal)];
    [self.buttonReport setTitle:@"举报" forState:(UIControlStateNormal)];
    self.buttonReport.titleLabel.font = [UIFont systemFontOfSize:10];
    self.buttonReport.layer.masksToBounds = YES;
    self.buttonReport.layer.cornerRadius = 10.5*SCALE_WIDTH;
    
    self.buttonReply = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.buttonReply.backgroundColor = [UIColor redColor];
    [self.buttonReply setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.buttonReply setTitle:@"回复" forState:(UIControlStateNormal)];
    self.buttonReply.titleLabel.font = [UIFont systemFontOfSize:10];
    self.buttonReply.layer.masksToBounds = YES;
    self.buttonReply.layer.cornerRadius = 10.5*SCALE_WIDTH;
    
    self.viewReply = [[UIView alloc] init];
    self.viewReply.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    self.viewReplyTable = [[ReplyForAppraiseView alloc] init];
    [self.viewReply addSubview:self.viewReplyTable];
    
    //    self.buttonReplyContent = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    [self.buttonReplyContent setImage:[UIImage imageNamed:@"pinglunNew"] forState:(UIControlStateNormal)];
    //    [self.buttonReplyContent setTitle:@"There is no doubt that!" forState:(UIControlStateNormal)];
    //    [self.buttonReplyContent setTitleColor:[UIColor colorWithHexString:@"666666"] forState:(UIControlStateNormal)];
    //    self.buttonReplyContent.titleLabel.font = [UIFont systemFontOfSize:11];
    
    [self.buttonLook addTarget:self action:@selector(buttonLookActionInAppraiseListNCell) forControlEvents:(UIControlEventTouchUpInside)];
    [self.buttonPraise addTarget:self action:@selector(buttonPraiseActionInAppraiseListNCell) forControlEvents:(UIControlEventTouchUpInside)];
    [self.buttonReport addTarget:self action:@selector(buttonReportActionInAppraiseListNCell) forControlEvents:(UIControlEventTouchUpInside)];
    [self.buttonReply addTarget:self action:@selector(buttonReplyActionInAppraiseListNCell) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.contentView addSubview:self.viewAll];
    
    [self.viewTop addSubview:self.buttonIcon];
    [self.viewTop addSubview:self.labelName];
    [self.viewTop addSubview:self.labelTime];
    [self.viewTop addSubview:self.buttonStar];
    
    [self.viewAll addSubview:self.labelContent];
    [self.viewAll addSubview:self.viewImageV];
    [self.viewAll addSubview:self.viewTop];
    [self.viewAll addSubview:self.viewForFourButton];
    [self.viewAll addSubview:self.viewSpecification];
    [self.viewAll addSubview:self.viewReply];
    
    [self.viewSpecification addSubview:self.viewline1];
    [self.viewSpecification addSubview:self.viewline2];
    [self.viewSpecification addSubview:self.labelSpecification];
    [self.viewSpecification addSubview:self.labelTimeDown];
    
    [self.viewForFourButton addSubview:self.buttonLook];
    [self.viewForFourButton addSubview:self.buttonPraise];
    [self.viewForFourButton addSubview:self.buttonReply];
    [self.viewForFourButton addSubview:self.buttonReport];
    
    [self.viewReply addSubview:self.buttonReplyContent];
    
    [self p_makeupViewByMasonryInAppraiseListNCell];
    //    self.buttonReport.hidden = YES;
        self.buttonReply.hidden = YES;
}

-(void)p_makeupViewByMasonryInAppraiseListNCell
{
    [self.viewAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.offset(0);
        make.bottom.offset(-9*SCALE_WIDTH);
        
    }];
    
    [self.viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.offset(0);
        make.height.mas_equalTo(65*SCALE_WIDTH);
    }];
    [self.buttonIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.offset(15*SCALE_WIDTH);
        make.width.height.mas_equalTo(41*SCALE_WIDTH);
        
    }];
    [self.labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.offset(-15*SCALE_WIDTH);
        make.top.offset(24*SCALE_WIDTH);
        make.width.mas_equalTo(120);
    }];
    [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.buttonIcon.mas_trailing).offset(10);
        make.centerY.equalTo(self.labelTime);
        make.trailing.equalTo(self.labelTime.mas_leading).offset(-10);
    }];
    [self.buttonStar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.labelName);
        make.top.equalTo(self.labelName.mas_bottom).offset(6*SCALE_WIDTH);
        make.height.mas_equalTo(12*SCALE_WIDTH);
    }];
    
    
    [self.labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(16*SCALE_WIDTH);
        make.top.equalTo(self.viewTop.mas_bottom);
        make.trailing.offset(-16*SCALE_WIDTH);
        //        make.bottom.offset(-275*SCALE_WIDTH);
        //        make.height.mas_equalTo(32*SCALE_WIDTH);
    }];
    
    [self.viewImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(12*SCALE_WIDTH);
        make.top.equalTo(self.labelContent.mas_bottom).offset(8*SCALE_WIDTH);
        make.height.mas_equalTo(113*SCALE_WIDTH);
        make.trailing.offset(-12*SCALE_WIDTH);
    }];
    
    [self.viewSpecification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.offset(0);
        make.top.equalTo(self.viewImageV.mas_bottom).offset(10*SCALE_WIDTH);
        make.height.mas_equalTo(41*SCALE_WIDTH);
        
    }];
    [self.viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.leading.offset(15*SCALE_WIDTH);
        make.trailing.offset(-15*SCALE_WIDTH);
        make.height.mas_equalTo(1);
    }];
    [self.labelTimeDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.offset(-15*SCALE_WIDTH);
        make.top.offset(3);
        make.bottom.offset(-3);
        make.width.mas_equalTo(120);
    }];
    [self.labelSpecification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15*SCALE_WIDTH);
        make.centerY.equalTo(self.labelTimeDown);
        make.trailing.equalTo(self.labelTimeDown.mas_leading).offset(-5);
    }];
    [self.viewline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.equalTo(self.viewline1);
        make.bottom.offset(-1);
    }];
    
    [self.viewForFourButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.offset(0);
        make.top.equalTo(self.viewSpecification.mas_bottom);
        make.height.mas_equalTo(42*SCALE_WIDTH);
        
    }];
    [self.buttonReply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.offset(-15*SCALE_WIDTH);
        make.top.offset(11*SCALE_WIDTH);
        make.height.mas_equalTo(21*SCALE_WIDTH);
        make.width.mas_equalTo(44*SCALE_WIDTH);
        
    }];
    [self.buttonReport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.equalTo(self.buttonReply);
        make.trailing.mas_equalTo(self.buttonReply.mas_leading).offset(-7*SCALE_WIDTH);
    }];
    [self.buttonLook mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15*SCALE_WIDTH);
        make.centerY.equalTo(self.buttonReport);
        make.width.mas_equalTo(60*SCALE_WIDTH);
        
    }];
    [self.buttonPraise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.equalTo(self.buttonLook);
        make.leading.equalTo(self.buttonLook.mas_trailing).offset(10);
        
    }];
    
    [self.viewReply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15*SCALE_WIDTH);
        make.trailing.offset(-15*SCALE_WIDTH);
        make.top.equalTo(self.viewForFourButton.mas_bottom);
        make.height.mas_equalTo(43*SCALE_WIDTH);
        make.bottom.offset(-10*SCALE_WIDTH);
        
    }];
    [self.viewReplyTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.offset(10*SCALE_WIDTH);
        make.trailing.bottom.offset(-10*SCALE_WIDTH);
        
    }];
    //    self.buttonReplyContent.titleLabel.numberOfLines = 0;
    //    [self.buttonReplyContent mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.offset(10*SCALE_WIDTH);
    //        make.trailing.offset(-10*SCALE_WIDTH);
    //        make.centerY.equalTo(self.viewReply);
    //    }];
    
}

-(void)setType:(NSInteger)type
{
    _type = type;
    [self.collectionV reloadData];
    NSInteger row1 = type/3;
    NSInteger row2 = type%3;
    if (row2>0) {
       row1++;
    }
    [self.viewImageV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((113*SCALE_WIDTH+3)*row1+10);
    }];
//    [self.viewImageV mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(113*SCALE_WIDTH);
//    }];
//    UIImageView *imageV0 = (UIImageView *)[self viewWithTag:180];
//    UIImageView *imageV1 = (UIImageView *)[self viewWithTag:181];
//    UIImageView *imageV2 = (UIImageView *)[self viewWithTag:182];
//    imageV0.hidden = NO;
//    imageV1.hidden = NO;
//    imageV2.hidden = NO;
//    if (type==0) {
//        [self.viewImageV mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(0.01);
//        }];
//        imageV0.hidden = YES;
//        imageV1.hidden = YES;
//        imageV2.hidden = YES;
//
//    }else if (type==1){
//        imageV1.hidden = YES;
//        imageV2.hidden = YES;
//        if (self.appraiseM.arrPicture.count>0) {
//            [imageV0 sd_setImageWithURL:[NSURL URLWithString:self.appraiseM.arrPicture[0]] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
//        }
//
//    }else if (type==2){
//        imageV2.hidden = YES;
//        if (self.appraiseM.arrPicture.count>1) {
//            [imageV0 sd_setImageWithURL:[NSURL URLWithString:self.appraiseM.arrPicture[0]] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
//            [imageV1 sd_setImageWithURL:[NSURL URLWithString:self.appraiseM.arrPicture[1]] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
//
//        }
//
//    }else{
//        if (self.appraiseM.arrPicture.count>2) {
//            [imageV0 sd_setImageWithURL:[NSURL URLWithString:self.appraiseM.arrPicture[0]] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
//            [imageV1 sd_setImageWithURL:[NSURL URLWithString:self.appraiseM.arrPicture[1]] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
//            [imageV2 sd_setImageWithURL:[NSURL URLWithString:self.appraiseM.arrPicture[2]] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
//
//        }
//
//    }
//    switch (type) {
//        case 0:
//        {
//            [self.viewImageV mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(0.01);
//            }];
//            imageV0.hidden = YES;
//            imageV1.hidden = YES;
//            imageV2.hidden = YES;
//        }
//            break;
//        case 1:
//        {
//            imageV1.hidden = YES;
//            imageV2.hidden = YES;
//            if (self.appraiseM.arrPicture.count>0) {
//                [imageV0 sd_setImageWithURL:[NSURL URLWithString:self.appraiseM.arrPicture[0]] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
//            }
//        }
//            break;
//        case 2:
//        {
//            imageV2.hidden = YES;
//            if (self.appraiseM.arrPicture.count>1) {
//                [imageV0 sd_setImageWithURL:[NSURL URLWithString:self.appraiseM.arrPicture[0]] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
//                [imageV1 sd_setImageWithURL:[NSURL URLWithString:self.appraiseM.arrPicture[1]] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
//                
//            }
//            
//        }
//            break;
//        case 3:
//        {
//            if (self.appraiseM.arrPicture.count>2) {
//                [imageV0 sd_setImageWithURL:[NSURL URLWithString:self.appraiseM.arrPicture[0]] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
//                [imageV1 sd_setImageWithURL:[NSURL URLWithString:self.appraiseM.arrPicture[1]] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
//                [imageV2 sd_setImageWithURL:[NSURL URLWithString:self.appraiseM.arrPicture[2]] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
//                
//            }
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
}
#pragma mark - 点击了头像
-(void)buttonIconActoionInAppraiseListNCell
{
    NSLog(@"点击了头像");
}
#pragma mark - 点击查看、点赞、举报、回复
-(void)buttonLookActionInAppraiseListNCell
{
    //    NSLog(@"点击了查看");
}
-(void)buttonPraiseActionInAppraiseListNCell
{
    //暂时该列表不需要点赞
    //    NSLog(@"点击了点赞");
    //    self.dicPram[@"index"] = @"1";
    //    self.dicPram[@"orderCommentId"] = self.appraiseM.commentid;
    //    if (self.appraiseM.isPraise) {
    //        self.dicPram[@"type"] = @"2";
    //    }else{
    //        self.dicPram[@"type"] = @"1";
    //    }
    //
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"AppraisePraiseOrReplyForList" object:nil userInfo:self.dicPram];
}
-(void)buttonReportActionInAppraiseListNCell
{
    NSLog(@"点击了举报");
    
}
#pragma mark - 点击回复按钮代理
-(void)sendText:(NSString *)text
{
    if (text.length<1) {
//        [JKAlert alertText:@"请输入回复内容"];
        return;
    }
    self.dicPram[@"index"] = @"2";
    self.dicPram[@"commentId"] = self.appraiseM.commentId;
    self.dicPram[@"objectName"] = self.appraiseM.content;
    self.dicPram[@"operationObjectId"] = self.appraiseM.commentId;
    self.dicPram[@"operationId"] = self.appraiseM.commentMemberId;
    self.dicPram[@"serviceId"] = self.appraiseM.serviceId;
    self.dicPram[@"content"] = text;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AppraisePraiseOrReplyForList" object:nil userInfo:self.dicPram];
    
    
}
#pragma mark - 点击发表的回调
-(void)publishMessageText:(NSString *)message{
    [self sendText:message];
}
-(void)buttonReplyActionInAppraiseListNCell
{
    NSLog(@"点击了回复");
//    PublishView *publishview = [[PublishView alloc]initWithShowType:@"1"];
//    publishview.publishdelegate = self;
//    publishview.headlabel.text = @"回复";
//    [publishview showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)setStrContent:(NSString *)strContent
{
    _strContent = strContent;
    self.labelContent.text = strContent;
}
-(void)setAppraiseM:(BiglistGoods *)appraiseM
{
    _appraiseM = appraiseM;
//    [self.buttonIcon sd_setImageWithURL:[NSURL URLWithString:appraiseM.logoAttachmentAddress] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"imageHeader"]];
    self.labelName.text = appraiseM.nickname;
    self.labelTime.text = appraiseM.commentTime;
    self.labelTimeDown.text = appraiseM.createdTime;
    self.labelContent.text = appraiseM.content;
    
    self.viewReplyTable.arrReply = appraiseM.arrReturnContent;
    if (appraiseM.floatHeight<1) {
        [self.viewReply mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
        }];
        self.viewReply.hidden = YES;
    }else{
        [self.viewReply mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(23*SCALE_WIDTH+appraiseM.floatHeight);
        }];
        self.viewReply.hidden = NO;
        
    }

    self.type = appraiseM.arrPicture.count;
    if (appraiseM.isServer) {
        self.labelSpecification.text = [NSString stringWithFormat:@"服务：%@",appraiseM.serviceTitle];
        
    }else{
        self.labelSpecification.text = [NSString stringWithFormat:@"%@    %@    %@",appraiseM.productName,appraiseM.productSpecificationName,appraiseM.productSalePrice];
    }
    [self.buttonLook setTitle:appraiseM.readNum forState:(UIControlStateNormal)];
    [self.buttonPraise setTitle:appraiseM.fabulousNum forState:(UIControlStateNormal)];
    [self.buttonReplyContent setTitle:[NSString stringWithFormat:@"%@",appraiseM.returnContent] forState:(UIControlStateNormal)];
    
    switch (appraiseM.startNum) {
        case 1:
        {
            [self.buttonStar setImage:[UIImage imageNamed:@"star1"] forState:(UIControlStateNormal)];
        }
            break;
        case 2:
        {
            [self.buttonStar setImage:[UIImage imageNamed:@"star2"] forState:(UIControlStateNormal)];
        }
            break;
        case 3:
        {
            [self.buttonStar setImage:[UIImage imageNamed:@"star3"] forState:(UIControlStateNormal)];
        }
            break;
        case 4:
        {
            [self.buttonStar setImage:[UIImage imageNamed:@"star4"] forState:(UIControlStateNormal)];
        }
            break;
        case 5:
        {
            [self.buttonStar setImage:[UIImage imageNamed:@"star5"] forState:(UIControlStateNormal)];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 分区数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
#pragma mark - 返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.appraiseM.arrPicture.count;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    AppraiseCollectionCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"appraiseCollectCell" forIndexPath:indexPath];
    
    cell.strUrl = self.appraiseM.arrPicture[indexPath.row];
    return cell;
    
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
////    if (self.isManager) {
//        return CGSizeMake(173*SCALE_WIDTH, 184*SCALE_WIDTH);
////    }else{
////        return CGSizeMake(173*SCALE_WIDTH, 220*SCALE_WIDTH);
////    }
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
