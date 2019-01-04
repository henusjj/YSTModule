//
//  ReplyForAppraiseView.m
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/29.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "ReplyForAppraiseView.h"
#import "ReplyCell.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例
@interface ReplyForAppraiseView ()<UITableViewDelegate,UITableViewDataSource>
/*左边固定的按钮*/
@property (nonatomic,strong) UIButton *buttonMerchant;
/*右边的回复内容*/
@property (nonatomic,strong) UILabel *labelContent;

@property (nonatomic,strong) UITableView *tableView;


@end

@implementation ReplyForAppraiseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_makeupViewForReplyForAppraiseView];
    }
    return self;
}
-(void)p_makeupViewForReplyForAppraiseView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(1, 1, 1, 1) style:(UITableViewStylePlain)];
    [self addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 15;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.offset(0);
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    ReplyCell *cell = [ReplyCell cellWithtableViewForAppraiseListReply:tableView];
    NSString *strReply = self.arrReply[indexPath.row];
    cell.strReply = strReply;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrReply.count;
}
-(void)setArrReply:(NSArray *)arrReply
{
    _arrReply = arrReply;
    [self.tableView reloadData];
}
@end
