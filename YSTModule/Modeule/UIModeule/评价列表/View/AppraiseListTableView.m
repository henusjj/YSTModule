//
//  AppraiseListTableView.m
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/19.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "AppraiseListTableView.h"
#import "AppraiseListNCell.h"
#import "AppraiseListM.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例
@interface AppraiseListTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableViewAppraiseN;
@property (nonatomic,strong) UIView *tableViewHeader;

@end

@implementation AppraiseListTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_makeupViewForAppraiseListTableView];
    }
    return self;
}
-(void)p_makeupViewForAppraiseListTableView
{
    self.tableViewAppraiseN = [[UITableView alloc] initWithFrame:CGRectMake(0, 86*SCALE_WIDTH+1, kScreenWidth, kScreenHeight-kNavHeight-87*SCALE_WIDTH) style:UITableViewStylePlain];
    self.tableViewAppraiseN.delegate = self;
    self.tableViewAppraiseN.dataSource = self;
    self.tableViewAppraiseN.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableViewAppraiseN.estimatedRowHeight = 300;
    self.tableViewAppraiseN.rowHeight = UITableViewAutomaticDimension;
    [self addSubview:self.tableViewAppraiseN];
    
    self.tableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 86*SCALE_WIDTH)];
    self.tableViewHeader.backgroundColor = [UIColor whiteColor];
    UIView *viewHeaderTitle = [[UIView alloc] init];
    viewHeaderTitle.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
//    UILabel *labelTitle = [PJ_CreatLabel creatLabelFont:14 color:@"222222" title:@"评价详情"];
    UILabel *labelTitle = [[UILabel alloc] init];
    labelTitle.font = [UIFont systemFontOfSize:14];
    labelTitle.textColor = [UIColor grayColor];
    labelTitle.text = @"评价详情";

    UIView *viewHeaderDown = [[UIView alloc] init];
    viewHeaderDown.backgroundColor = [UIColor whiteColor];
    
    [self.tableViewHeader addSubview:viewHeaderTitle];
    [self.tableViewHeader addSubview:viewHeaderDown];
    [viewHeaderTitle addSubview:labelTitle];
    [self addSubview:self.tableViewHeader];
    
    //    [self.tableViewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.trailing.offset(0);
    //        make.top.offset(0);
    //        make.height.mas_equalTo(86*SCALE_WIDTH);
    //    }];
    
    [viewHeaderTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.offset(0);
        make.height.mas_equalTo(44*SCALE_WIDTH);
    }];
    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16*SCALE_WIDTH);
        make.top.trailing.bottom.offset(0);
    }];
    [viewHeaderDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(7*SCALE_WIDTH);
        make.bottom.trailing.mas_offset(0);
        make.height.mas_equalTo(42*SCALE_WIDTH);
    }];
    
    NSArray *arrButton = @[@"未回复",@"中差评",@"好评",@"全部"];
    for (int i = 0; i < arrButton.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [viewHeaderDown addSubview:button];
        button.tag = 170+i;
        [button addTarget:self action:@selector(buttonAppraiseNTypeAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 11.5*SCALE_WIDTH;
        button.layer.borderColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1].CGColor;
        [button setTitle:arrButton[i] forState:(UIControlStateNormal)];
        if (i==0) {
            [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            button.backgroundColor = [UIColor redColor];
            button.layer.borderWidth = 0;
        }else{
            [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            button.backgroundColor = [UIColor whiteColor];
            button.layer.borderWidth = 1;
            
        }
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.offset(9*SCALE_WIDTH+(79*SCALE_WIDTH)*i);
            make.width.mas_equalTo(70*SCALE_WIDTH);
            make.height.mas_equalTo(23*SCALE_WIDTH);
            make.top.offset(9*SCALE_WIDTH);
        }];
    }
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 86*SCALE_WIDTH, kScreenWidth, 1)];
    viewLine.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self addSubview:viewLine];
    //
    //    [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.trailing.offset(0);
    //        make.top.equalTo(self.tableViewHeader.mas_bottom);
    //        make.height.mas_equalTo(1);
    //    }];
    
    
    //    [self.tableViewAppraiseN mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.trailing.bottom.top.offset(0);
    //    }];
    //    self.tableViewAppraiseN.tableHeaderView = self.tableViewHeader;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    AppraiseListNCell *cell = [AppraiseListNCell cellWithtableViewForAppraiseList:tableView];
    BiglistGoods *appraiseM = self.arrAppraiseList[indexPath.row];
    if (self.type==1) {
        appraiseM.isServer = 1;
    }else{
        appraiseM.isServer = 0;
    }
    cell.appraiseM = appraiseM;
    //    NSString *imageType = [NSString stringWithFormat:@"%d",arc4random()%4];
    //    NSInteger imageType = arc4random()%4;
    //    NSString *strContent = @"Masonry 出来也很有一段时间了，由于之前一直使用Frame方式布局（iOS7之前的程序员的痛）,复杂的界面则使用MVVM模式来处理，与后来为了快速拉界面做屏幕适配而使用的xib的Autoresizing等布局方式。并未使用过这个第三方库，后来一直听说Masonry的“轻量，链式语法，高可读性等特点”，一副好像很厉害的样子，老夫实在是忍不住想要搞事情了。刚好有个不怎么复杂的界面就拿来试试手先。。。（哪知这一试竟试出来四十级电视连续剧的赶脚）。";
    //    cell.type = imageType;
    //    cell.strContent = [strContent substringToIndex:arc4random()%200+1];
    
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrAppraiseList.count;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 373*SCALE_WIDTH;
//}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击的index为%ld",indexPath.row);
}
-(void)setArrAppraiseList:(NSArray *)arrAppraiseList
{
    _arrAppraiseList = arrAppraiseList;
//    UIButton *button0 = (UIButton *)[self viewWithTag:170];
//    UIButton *button1 = (UIButton *)[self viewWithTag:171];
//    UIButton *button2 = (UIButton *)[self viewWithTag:172];
//    UIButton *button3 = (UIButton *)[self viewWithTag:173];
//    [button0 setTitle:[NSString stringWithFormat:@"未回复(%ld)",self.appraiseM.countNo] forState:(UIControlStateNormal)];
//    [button1 setTitle:[NSString stringWithFormat:@"中差评(%ld)",self.appraiseM.countLittle] forState:(UIControlStateNormal)];
//    [button2 setTitle:[NSString stringWithFormat:@"好评(%ld)",self.appraiseM.countBest] forState:(UIControlStateNormal)];
//    [button3 setTitle:[NSString stringWithFormat:@"全部(%ld)",self.appraiseM.countAll] forState:(UIControlStateNormal)];
    [self.tableViewAppraiseN reloadData];
}
#pragma mark - 选择评价类型
-(void)buttonAppraiseNTypeAction:(UIButton *)sender
{
    for (int i = 170; i<174; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderWidth = 1;
        
    }
    [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    sender.backgroundColor = [UIColor redColor];
    sender.layer.borderWidth = 0;
    NSString *type = @"";
    
    switch (sender.tag) {
        case 170:
        {
            NSLog(@"点击了未回复");
            if (self.type==1) {
                type = @"1";
            }else{
                type = @"5";
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AppraiseTypeForList" object:type];
        }
            break;
        case 171:
        {
            NSLog(@"点击了中差评");
            if (self.type==1) {
                type = @"2";
            }else{
                type = @"6";
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AppraiseTypeForList" object:type];
            
        }
            break;
        case 172:
        {
            NSLog(@"点击了好评");
            //            self.selectTypeBlock(3);
            if (self.type==1) {
                type = @"3";
            }else{
                type = @"7";
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AppraiseTypeForList" object:type];
            
        }
            break;
        case 173:
        {
            NSLog(@"点击了全部");
            //            self.selectTypeBlock(0);
            if (self.type==1) {
                type = @"4";
            }else{
                type = @"8";
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AppraiseTypeForList" object:type];
            
        }
            break;
            
        default:
            break;
    }
}
@end
