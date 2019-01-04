//
//  ShareListViewController.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "ShareListViewController.h"
#import "ShareListCell.h"
#import "HomeSearchPageViewController.h"
#import "EmptyListView.h"
#import "PHCellHeight.h"
#import "UIView+Helper.h"

@interface ShareListViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 数据属性
 */
@property (nonatomic,strong)NSMutableArray * datas;
@property (nonatomic,assign)NSUInteger page;

/**
 视图属性
 */
@property (nonatomic,strong)UITableView * tabelView;
@end

@implementation ShareListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
    [self refreshUI];
    [self refreshNewData];
    // Do any additional setup after loading the view.
}
#pragma mark -- 处理逻辑的一些方法
-(void)initData{
    _datas = [NSMutableArray array];
    _page = 1;
    
    //    for (int i = 0; i < 10; i ++) {
    //        [_datas addObject:@""];
    //    }
    
    
}

-(void)initUI{
    self.view.backgroundColor =[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];// [UIColor colorWithR:245 G:245 B:245 alpha:1];
    __block typeof(self) weakSelf = self;
    
    
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height-64-50) style:UITableViewStyleGrouped];
    
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [self.view addSubview:_tabelView];
    [_tabelView registerClass:[ShareListCell class] forCellReuseIdentifier:@"cell"];
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tabelView.estimatedRowHeight = 200;
    [_tabelView addEmptyView:[[EmptyListView alloc]initWithFrame:CGRectMake(0, 0, _tabelView.width, _tabelView.height) title:@"空空如也~" imgName:@"kongNew"]];
//    _tabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNewData)];
//    _tabelView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
    [_tabelView class];
    
}
-(void)refreshNewData{
    _page = 1;
    [self refreshData];
}
-(void)refreshMoreData{
    
    _page ++;
    [self refreshData];
}
-(void)refreshData{
    
    
    
    
   
    _datas =[@[@{@"title":@"测试图文资讯001***",@"Description":@"测试计划发布1",@"shareNum":@"10",@"commentNum":@"11",@"fabulousNum":@"22",@"img":(@[@"2",@"1",@"3"])},
               @{@"title":@"测试图文资讯001***",@"Description":@"测试计划发布1",@"shareNum":@"10",@"commentNum":@"11",@"fabulousNum":@"22",@"img":(@[@"2",@"1",@"3"])},
               @{@"title":@"测试图文资002***",@"Description":@"测试计划发布1",@"shareNum":@"10",@"commentNum":@"11",@"fabulousNum":@"22",@"img":(@[@"2"])}
               ] mutableCopy];
    [self refreshUI];
    
//    [Request getInformationListWithKeyWold:self.pageVC.searchTF.text page:_page success:^(NSUInteger code, NSString *msg, id data) {
//        [_tabelView.mj_header endRefreshing];
//        [_tabelView.mj_footer endRefreshing];
//        NSLog(@"%@",msg);
//        if (_page == 1) {
//            [_datas removeAllObjects];
//        }
//
//
//
//
//        if (code == 1) {
//            //            data = @[@{
//            //                         @"reprintName": @"ull",//转载的用户
//            //                         @"num": @"1",
//            //                         @"ptitle": @"测试计划发布1",//产品计划标题
//            //                         @"id": @"16",
//            //                         @"title": @"测试图文资讯001***",
//            //                         @"userName": @"null",
//            //                         @"type": @"3",
//            //                         @"status": @"0",
//            //                         @"img":@[@{@"img":@"",@"video":@""}]
//            //                            }];
//
//
//
//
//            NSArray * dataR = [NSMutableArray arrayWithArray:data];
//            NSMutableArray * datas = [NSMutableArray array];
//            for (NSDictionary * dic in dataR) {
//                InfomationlistModel * model = [InfomationlistModel new];
//                [model setValuesForKeysWithDictionary:dic];
//                [datas addObject:model];
//            }
//            [_datas addObjectsFromArray:datas];
//
//            //            [_tabelView reloadData];
//            [self refreshUI];
//
//        }else{
//            [self.view makeToast:msg duration:2 position:CSToastPositionCenter];
//
//        }
//
//
//
//    } failure:^(NSError *error) {
//        [_tabelView.mj_header endRefreshing];
//        [_tabelView.mj_footer endRefreshing];
//
//        [self refreshUI];
//    }];
}
-(void)refreshUI{
    [_tabelView reloadData];
    _tabelView.emptyView.hidden = _datas.count != 0;
}
-(void)setKeyWord:(NSString *)keyWord
{
    _keyWord = keyWord;
    [self refreshNewData];
}
#pragma mark -- tableView  delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView cellHeightWithIndexPath:indexPath];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShareListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.model = _datas[indexPath.section];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

/*
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
