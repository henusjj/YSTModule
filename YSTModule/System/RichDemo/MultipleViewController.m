//
//  MultipleViewController.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "MultipleViewController.h"
#import "RichEditorCell.h"
#import "RichEditView.h"



@interface MultipleViewController ()<UITableViewDelegate,UITableViewDataSource,RichEditorCellDelegate>
@property (nonatomic,strong)UITableView *tableView;
/** 详情编辑框高度 */
@property (nonatomic,assign) CGFloat richCellH;
/** 富文本编辑器cell */
@property (nonatomic,strong)RichEditView * rishView;

@property (nonatomic,strong)NSArray *data;
@end

@implementation MultipleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //MARK:
    self.navigationItem.title = @"编辑器";
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _richCellH =0;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backVC)];
    // Do any additional setup after loading the view.
}
-(void)backVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RichEditorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[RichEditorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.ImgMax =10;
        cell.videoMax = 1;
        cell.richCellDelegate = self;
        self.rishView = cell.rishView;
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //默认高度
    if (_richCellH==0) {
        _richCellH = 132+95;
        return _richCellH;
    }
    //适配内容高度
    return _richCellH;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//MARK:商品详情cell - 返回富文本编辑器cell高度
-(void)richEditorCell:(RichEditorCell *)cell cellHeight:(CGFloat)cellHeight{
    
    if (cellHeight > self.richCellH+2 ||cellHeight< self.richCellH-2) {
        //如果是当前高度不需要刷新
        self.richCellH = cellHeight;

        //适配内容更新高度，防止tableview错位
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:-1 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        
        //优化 添加图片滑动到底部
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
//MARK:商品详情cell - 开始编辑
-(void)richEitorBeginEditor{
    NSIndexPath *ssss= [NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView scrollToRowAtIndexPath:ssss atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
