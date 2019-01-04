//
//  SetupViewController.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "SetupViewController.h"
#import "SafeAccountCell.h"
#define kNavHeight ([[UIApplication sharedApplication] statusBarFrame].size.height + 44)

@interface SetupViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property(nonatomic,strong)UITableView * tableView;

/** dataSource */
@property(nonatomic,strong)NSArray * dataArr;

/** 微信type*/
@property(nonatomic,assign)BOOL wxType;
/** QQtype*/
@property(nonatomic,assign)BOOL qqType;

/** 选中的三方的cell*/
@property (nonatomic,strong) SafeAccountCell * selectedCell;
@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];//[UIColor colorWithR:245 G:245 B:245];
    self.navigationItem.title = @"设置";
    [self initData];
    [self initUI];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backVC)];

}

-(void)backVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self refrshData];
}
/**
 初始化数据
 */

/**
 初始化数据
 */
-(void)initData{

    _wxType = NO;
    _qqType = NO;

    self.dataArr = [[NSArray alloc]init];
    self.dataArr = @[
                     @{@"title":@"个人信息"},
                     @{@"title":@"收货地址"},
                     @{@"title":@"微信"},
                     @{@"title":@"QQ"},
                     @{@"title":@"修改登录密码"},
                     @{@"title":@"修改交易密码"},
                     @{@"title":@"实名认证"},
                     @{@"title":@"意见反馈"},
                     @{@"title":@"清除缓存"},
                     @{@"title":@"关于我们"},
                     //                     @{@"title":@"版本更新"}
                     ];
}

/**
 初始化界面
 */
-(void)initUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, kScreenHeight-kNavHeight) style:UITableViewStylePlain];
    [_tableView registerClass:[SafeAccountCell class] forCellReuseIdentifier:@"cell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    //退出登录按钮
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
    UIButton * exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 49, 310, 42)];
    exitBtn.centerX =footView.centerX;
    [exitBtn setImage:[UIImage imageNamed:@"tuichu"] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:exitBtn];
    self.tableView.tableFooterView = footView;
}
#pragma mark -----tableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SafeAccountCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftTitle.text = [self.dataArr[indexPath.row] objectForKey:@"title"];
    WeakSelf(self)
    __block typeof(cell) weakCell = cell;
    if (indexPath.row == 8) {
        cell.nextImage.hidden = YES;
        cell.rightTitle.hidden = NO;
        cell.rightTitle.text  = [self checkCache];
        cell.rightTitle.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
//        self.selectedCell  = cell;
        
    }else if (indexPath.row == 2){
        
        cell.nextImage.hidden = YES;
        cell.switchBtn.hidden = NO;
        cell.switchBtn.on = _wxType;
        
    }else if(indexPath.row == 3){
        
        cell.nextImage.hidden = YES;
        cell.switchBtn.hidden = NO;
        cell.switchBtn.on = _qqType;
        
    }else{}
    
    //UISwitch的回调
    cell.switchBtnBlock = ^(SafeAccountCell *controllCell, UISwitch *assSwitch) {
        self.selectedCell = controllCell;
        if (!assSwitch.on) { //解绑
         
        }else{  //MARK:绑定微信或者QQ
            if (indexPath.row == 2) { //微信

            }else{ //QQ
                //判断有没有QQ客户端

            }
        }
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row ==8) {
        NSString * path =  [NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
        [self clearCache:path];
        self.selectedCell.rightTitle.text  = @"0M";
    }
    
    
}
-(void)exitBtnClick:(UIButton *)sender{

}

#pragma mark ------- 计算缓存
- (NSString *)checkCache {
    NSString * path =  [NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    
    float totalSize = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:path];
    for (NSString *fileName in fileEnumerator)
    {
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        
        unsigned long long length = [attrs fileSize];
        
        totalSize += length;
    }
    // NSLog(@"tmp size is %.2f",totalSize);
    
    NSString * hcStr = [NSString stringWithFormat:@"%f",totalSize/1024];
    
    NSRange range = [hcStr rangeOfString:@"."]; //现获取要截取的字符串位置
    hcStr = [hcStr substringToIndex:range.location]; //截取字符串
    
    if ([hcStr intValue]>1024) {
        
        hcStr = [NSString stringWithFormat:@"%ldM",[hcStr integerValue]/1024];
    }else{
        hcStr = [NSString stringWithFormat:@"%ldKB",[hcStr integerValue]];
        
    }
    return hcStr;
}

#pragma mark ---- 清空缓存
-(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL isHave = [fileManager fileExistsAtPath:path];
    if (isHave) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        BOOL suc = NO;
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            BOOL isSuc = [fileManager removeItemAtPath:absolutePath error:nil];
            suc += isSuc;
        }
        if (suc) {
//            [self.view makeToast:NSLocalizedString(@"清除成功", @"成功") duration:1 position:CSToastPositionBottom];
        }
        else {
//            [self.view makeToast:NSLocalizedString(@"没有可以清除的缓存", @"没有可以清除的缓存") duration:1 position:CSToastPositionBottom];
        }
    }
//    [[SDImageCache sharedImageCache] cleanDisk];
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
