//
//  ServeProjectListViewController.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "ServeProjectListViewController.h"

#import "ServeProjectCell.h"
#import "EmptyListView.h"
#import "UIView+Helper.h"
#import "PHCellHeight.h"

@interface ServeProjectListViewController ()<UITableViewDataSource,UITableViewDelegate>
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

@implementation ServeProjectListViewController

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
    
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height-64-50) style:UITableViewStyleGrouped];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [self.view addSubview:_tabelView];
    [_tabelView registerClass:[ServeProjectCell class] forCellReuseIdentifier:@"cell"];
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tabelView addEmptyView:[[EmptyListView alloc]initWithFrame:CGRectMake(0, 0, _tabelView.width, _tabelView.height) title:@"空空如也~" imgName:@"kongNew"]];
    _tabelView.estimatedRowHeight = 200;
    
//    _tabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNewData)];
//    _tabelView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
    
//    [self refreshUI];
}

-(void)refreshNewData{
    
    _page = 1;
    [self refreshData];
}
-(void)refreshMoreData{
    
    
    _page ++;
    [self refreshData];
}
-(void)refreshUI{
    [_tabelView reloadData];
    _tabelView.emptyView.hidden = _datas.count != 0;
}
-(void)refreshData{
    
    _datas =[@[@{@"title":@"测试图文资讯001***",@"nickName":@"小明",@"content":@"停电一小时",@"price":@"11.00",@"isFollow":@"1"},
               @{@"title":@"服务项目002***",@"nickName":@"Nike",@"content":@"停电一小时",@"price":@"0.02",@"isFollow":@"0"},
               @{@"title":@"服务项目003***",@"nickName":@"小明",@"content":@"停电一小时",@"price":@"11.00",@"isFollow":@"1"},
               ] mutableCopy];
    
    
    [self refreshUI];
    
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [_tabelView.mj_header endRefreshing];
    //        [_tabelView.mj_footer endRefreshing];
    //    });
    
//
//    [Request getServeProjectListWithKeyWold:self.pageVC.searchTF.text page:_page success:^(NSUInteger code, NSString *msg, id data) {
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
//            //            data = @[@{     @"merchantId":@"492",
//            //                            @"price":@"0.10",
//            //                            @"introduce":@"田园风光",
//            //                            @"imageAddress":@"https://yst-pjyc-server.oss-cn-beijing.aliyuncs.com/datas/image/20180417/20180417102544771770878.jpg",
//            //                            @"id":@"2",
//            //                            @"title":@"我呢",
//            //                            @"advisor":@{@"nickName":@"peng",
//            //                                         @"content":@"ffffffff",
//            //                                         @"imgUrl":@"https://yst-pjyc-server.oss-cn-beijing.aliyuncs.com/datas/image/20180417/20180417102544771770878.jpg"}}];
//
//
//
//
//            NSArray * dataR = [NSMutableArray arrayWithArray:data];
//            NSMutableArray * datas = [NSMutableArray array];
//            for (NSDictionary * dic in dataR) {
//                PJ_ServeProjectlistModel * model = [PJ_ServeProjectlistModel new];
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
//        [self refreshUI];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    ServeProjectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.model = _datas[indexPath.section];
    
//    __weak typeof(self) weakSelf = self;
    cell.changeFollow = ^(NSIndexPath *indexP) {

    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
