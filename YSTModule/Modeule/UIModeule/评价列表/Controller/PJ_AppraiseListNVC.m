//
//  PJ_AppraiseListNVC.m
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/18.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "PJ_AppraiseListNVC.h"
#import "AppraiseListNView.h"
#import "AppraiseListM.h"

@interface PJ_AppraiseListNVC ()
@property (nonatomic,strong) AppraiseListNView *viewAppraiseListN;
/**fuwu评价数组*/
@property (nonatomic,strong) NSMutableArray *arrServeAppraise;
/**商品评价数组*/
@property (nonatomic,strong) NSMutableArray *arrGoodsAppraise;
/*保存当前在第几个*/
@property (nonatomic,assign) NSInteger index;
/*基础参数字典*/
@property (nonatomic,strong) NSMutableDictionary *dicPramLZ;
@end

@implementation PJ_AppraiseListNVC
-(NSMutableDictionary *)dicPram
{
    if (_dicPramLZ==nil) {
        _dicPramLZ = [NSMutableDictionary dictionary];
    }
    return _dicPramLZ;
}
-(NSMutableArray *)arrServeAppraise
{
    if (_arrServeAppraise==nil) {
        _arrServeAppraise = [NSMutableArray array];
    }
    return _arrServeAppraise;
}
-(NSMutableArray *)arrGoodsAppraise
{
    if (_arrGoodsAppraise==nil) {
        _arrGoodsAppraise = [NSMutableArray array];
    }
    return _arrGoodsAppraise;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.dicPramLZ[@"phone"] = @"15070925726";
    //    self.dicPramLZ[@"uuid"] = @"307b708f4c5c489f9fc0802d1e053865";
    
    [self p_makeupViewForPJ_AppraiseListNVC];
    //index:0代表服务，1代表商品
    //type：0全部 1未回复 2中差评 3好评
    [self p_makeupDataForPJ_AppraiseListNVC:0 type:@"1"];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)p_makeupViewForPJ_AppraiseListNVC
{
    self.viewAppraiseListN = [[AppraiseListNView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.viewAppraiseListN];
    [self.viewAppraiseListN.buttonBack addTarget:self action:@selector(buttonBackActionInPJ_AppraiseListNVC) forControlEvents:(UIControlEventTouchUpInside)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppraiseTypeForListAction:) name:@"AppraiseTypeForList" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppraisePraiseOrReplyForListAction:) name:@"AppraisePraiseOrReplyForList" object:nil];
}
#pragma mark - 点赞和回复的网络请求处理
-(void)AppraisePraiseOrReplyForListAction:(NSNotification *)notification
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:notification.userInfo];
    
    
    if ([dic[@"index"] isEqualToString:@"1"]) {//点赞
        //        self.dicPramLZ[@"type"] = dic[@"type"];
        //        self.dicPramLZ[@"orderCommentId"] = dic[@"orderCommentId"];
        //        self.dicPramLZ[@"consultationType"] = @"5";
        
        //        [[NetworkTool shareInstance] postWithUrl:PJ_API_TeamManagerCommentPraise paramWithDic:self.dicPramLZ success:^(id responseObject) {
        //        } failure:^(NSError *error) {
        //        }];
        
    }else if ([dic[@"index"] isEqualToString:@"2"]){///回复
//        self.dicPramLZ[@"id"] = [PJ_UserMannager userModel].userID;
//        self.dicPramLZ[@"commentId"] = dic[@"commentId"];
//        self.dicPramLZ[@"content"] = dic[@"content"];
//        self.dicPramLZ[@"operationId"] = dic[@"operationId"];
//        self.dicPramLZ[@"objectName"] = dic[@"objectName"];
//        self.dicPramLZ[@"operationObjectId"] = dic[@"operationObjectId"];
//        self.dicPramLZ[@"serviceId"] = dic[@"serviceId"];
//
//        [[NetworkTool shareInstance] postWithUrl:PJ_API_TeamManagerCommentReply paramWithDic:self.dicPramLZ success:^(id responseObject) {
//            NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
//            upLoadFileM *loadM = [upLoadFileM mj_objectWithKeyValues:dic];
//            [JKAlert alertText:loadM.msg];
//
//            [self reloadDataByType:self.index];
//        } failure:^(NSError *error) {
//
//        }];
    }else{///其他
//        [JKAlert alertText:@"评价列表其他点击事件"];
    }
}
#pragma mark - 刷新列表通知事件
-(void)AppraiseTypeForListAction:(NSNotification *)notification
{
    NSInteger type = [notification.object integerValue];
    self.index = type;
    [self reloadDataByType:type];
}
#pragma mark - 刷新列表
-(void)reloadDataByType:(NSInteger)type
{
    switch (type) {
        case 1:
        {
            [self p_makeupDataForPJ_AppraiseListNVC:0 type:@"1"];
            
        }
            break;
        case 2:
        {
            [self p_makeupDataForPJ_AppraiseListNVC:0 type:@"2"];
            
        }
            break;
        case 3:
        {
            [self p_makeupDataForPJ_AppraiseListNVC:0 type:@"3"];
            
        }
            break;
        case 4:
        {
            [self p_makeupDataForPJ_AppraiseListNVC:0 type:@"0"];
            
        }
            break;
        case 5:
        {
            [self p_makeupDataForPJ_AppraiseListNVC:1 type:@"1"];
            
        }
            break;
        case 6:
        {
            [self p_makeupDataForPJ_AppraiseListNVC:1 type:@"2"];
            
        }
            break;
        case 7:
        {
            [self p_makeupDataForPJ_AppraiseListNVC:1 type:@"3"];
        }
            break;
        case 8:
        {
            [self p_makeupDataForPJ_AppraiseListNVC:1 type:@"0"];
        }
            break;
            
        default:
            break;
    }
    
}
-(void)p_makeupDataForPJ_AppraiseListNVC:(NSInteger)index type:(NSString *)type
{
    self.dicPramLZ[@"type"] = type;
//
//    NSString *strUrl = @"";
//    if (index==0) {
//        strUrl = PJ_API_TeamManangerServeAppraiseList;
//    }else{
//        strUrl = PJ_API_TeamManangerGoodsAppraiseList;
//    }
//    
//    [[NetworkTool shareInstance] postWithUrl:strUrl paramWithDic:self.dicPramLZ success:^(id responseObject) {
//        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        
    //        AppraiseListM *appListM = [AppraiseListM mj_objectWithKeyValues:dic];
    
    AppraiseListM *appListM = [[AppraiseListM alloc] init];
    appListM.content = [[AppraiseContentN alloc] init];
    NSInteger count = arc4random()%10+1;
    NSMutableArray *arr = [NSMutableArray array];
    NSString *strPicture1 = @"https://yst-pjyc-server.oss-cn-beijing.aliyuncs.com/datas/image/20180627/20180627133753217687858.jpeg";
    NSString *strPicture2 = @"https://yst-pjyc-server.oss-cn-beijing.aliyuncs.com/datas/image/20180627/20180627133835730945068.jpeg";
    NSString *strPicture3 = @"https://yst-pjyc-server.oss-cn-beijing.aliyuncs.com/datas/image/20180627/20180627133933548983940.jpeg";
    NSString *strPicture4 = @"https://yst-pjyc-server.oss-cn-beijing.aliyuncs.com/datas/image/20180627/20180627134033040357394.jpeg";
    NSString *strPicture5 = @"https://yst-pjyc-server.oss-cn-beijing.aliyuncs.com/datas/image/20180627/20180627134011364437831.jpeg";
    NSString *strPicture6 = @"https://yst-pjyc-server.oss-cn-beijing.aliyuncs.com/datas/image/20180626/20180626113317621483578.jpeg";
    NSArray *arrPicture = @[strPicture1,strPicture2,strPicture3,strPicture4,strPicture5,strPicture6];
    NSArray *arrName = @[@"凌一",@"唐二",@"张三",@"李四",@"王五",@"朱六",@"卓七"];
    NSArray *arrColor = @[@"黑色",@"白色",@"红色",@"青色",@"紫色"];
    NSArray *arrServe = @[@"扫地",@"擦玻璃",@"护理",@"看护",@"其他服务"];
    NSString *content1 = @"1.提供了一个 UIImageView 的 category 用来加载网络图片并且对网络图片的缓存进行管理";
    NSString *content2 = @"2.采用异步方式来下载网络图片";
    NSString *content3 = @"开始加载之前图片先取消对应的 UIImageView 先前的图片下载操作。试想，如果我们给 UIImageView 设置了一张新的图片，那么我们还会在意该 UIImageVIew 先前是要加载哪一张图片么？应该是不在意的吧！那是不是应该尝试把该 UIImageView 先前的加载图片相关操作给取消掉呢?";
    NSString *content4 = @"4.加载图片还有使用 SDWebImageDownloader 和 SDImageCache 方式，但那个并不是我们经常用到的。基本上面所讲的3个方法都能满足需求。";
    NSArray *arrContent = @[content1,content2,content3,content4];
    for (int i = 0; i<count; i++) {
        BiglistGoods *bigM = [[BiglistGoods alloc] init];
        bigM.content = arrContent[arc4random()%4];
        bigM.fabulousNum = [NSString stringWithFormat:@"%u",arc4random()%900+1];
        bigM.createdTime = @"2018-10-21 12:20";
        bigM.productName = @"";
        bigM.nickname = arrName[arc4random()%7];
        bigM.commentTime = @"2018-08-21 21:20";
        bigM.startNum = arc4random()%5+1;
        bigM.payTime = @"2018-08-21 21:20";
        bigM.readNum = [NSString stringWithFormat:@"%u",arc4random()%100+1];
        bigM.productSalePrice = [NSString stringWithFormat:@"￥%u",arc4random()%100+1];
        bigM.returnContent = @[@"好",@"很好",@"非常好"];
        bigM.productSpecificationName = arrColor[arc4random()%5];
        bigM.logoAttachmentAddress = @"";
        bigM.servicePrice = [NSString stringWithFormat:@"￥%u",arc4random()%100+1];
        bigM.serviceTitle = arrServe[arc4random()%5];
        NSInteger countPicture = arc4random()%6;
        NSMutableArray *arrPi = [NSMutableArray array];
        for (int i = 0; i<countPicture; i++) {
            [arrPi addObject:arrPicture[i]];
        }
        bigM.arrPicture = arrPi;
//        bigM.logoAttachmentAddress = @"";
        [arr addObject:bigM];
    }
    appListM.content.bigList = arr;
    appListM.content.lista = arr;
        if (index==0) {
            self.viewAppraiseListN.appraiseM = appListM.content;
            self.arrServeAppraise = appListM.content.lista.mutableCopy;
            self.viewAppraiseListN.arrServe = self.arrServeAppraise;
            
        }else{
            
            self.viewAppraiseListN.appraiseM = appListM.content;
            self.arrGoodsAppraise = appListM.content.bigList.mutableCopy;
            
            self.viewAppraiseListN.arrGoods = self.arrGoodsAppraise;
            
        }
//        if (appListM.content.bigList.count<1&&appListM.content.lista.count<1) {
//            [JKAlert alertText:@"您还没有评价"];
//        }
//        
//        
//    } failure:^(NSError *error) {
//        
//    }];
}

-(void)buttonBackActionInPJ_AppraiseListNVC
{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
