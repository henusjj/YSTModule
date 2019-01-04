//
//  YSTShopCarListVC.m
//  ShopCarListDemo
//
//  Created by penglaizhi on 2018/6/12.
//  Copyright © 2018年 决心. All rights reserved.
//

#import "YSTShopCarListVC.h"
#import "YSTShopCarListView.h"
#import "ShopM.h"

@interface YSTShopCarListVC ()
/**控制器右侧按钮***/
@property (nonatomic,strong) UIButton *buttonRight;

@property (nonatomic,strong) YSTShopCarListView *viewCarList;
/*商家数组-非商品，*/
@property (nonatomic,strong) NSMutableArray *arrShop;
/*当前价格*/
@property (nonatomic,assign) CGFloat priceAll;
/*是否处于编辑状态*/
@property (nonatomic,assign) BOOL isEdit;

@end
@implementation YSTShopCarListVC
-(NSMutableArray *)arrShop
{
    if (_arrShop==nil) {
        _arrShop = [NSMutableArray array];
    }
    return _arrShop;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_makeupViewInPLZStoreCarVC];
    [self p_makeupDataInPLZStoreCarVC];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseGoodCarWithIndex:) name:@"chooseGoodCarWithIndex" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needPushINshopCarListAction:) name:@"needPushINshopCarList" object:nil];

//    [self plzForPopAction];
    // Do any additional setup after loading the view.
}

-(void)chooseGoodCarWithIndex:(NSNotification *)notification
{
    NSLog(@"需要更新数据当前总价为%.2f",self.priceAll);
    NSDictionary *dic = notification.userInfo;
    NSString *type = dic[@"type"];
    NSString *isSelect = [NSString stringWithFormat:@"%@",dic[@"isSelect"]];
    NSString *section = dic[@"section"];
    NSInteger sec = [section integerValue];
    NSLog(@"sender.tag2 = %ld,当前数组有%ld个",sec,self.arrShop.count);

    ShopM *shopM = self.arrShop[sec] ;
    
    if ([type isEqualToString:@"1"]) {///商家
        
        if ([isSelect isEqualToString:@"1"]) {//处于选中
            NSString *strPrice = dic[@"price"];
            CGFloat floatSection = [strPrice doubleValue];
            
            self.priceAll = self.priceAll+floatSection;
            
        }else{//取消选中
            NSString *strPrice = dic[@"price2"];
            CGFloat floatSection = [strPrice doubleValue];
            
            self.priceAll = self.priceAll-floatSection;
            
        }
        self.viewCarList.priceAllOut = [NSString stringWithFormat:@"%.2f",self.priceAll];
        
        
    }else{//商品
        NSString *count = dic[@"count"];
        NSString *price = dic[@"price"];
        NSString *select = dic[@"select"];
        CGFloat priceF = [count integerValue]*[price doubleValue];
        
        if ([select isEqualToString:@"1"]) {//处理选不选中
            if ([isSelect isEqualToString:@"1"]) {
                self.priceAll = self.priceAll+priceF;
                self.viewCarList.priceAllOut = [NSString stringWithFormat:@"%.2f",self.priceAll];
                BOOL isAll = YES;
                for (int i = 0; i<shopM.content.count; i++) {
                    ShopChild *childM = shopM.content[i];
                    isAll = childM.isSelect&&isAll;
                }
                if (isAll) {
                    shopM.isSelect = YES;
                    self.viewCarList.arrShop = self.arrShop;
                }
            }else{
                self.priceAll = self.priceAll-priceF;
                self.viewCarList.priceAllOut = [NSString stringWithFormat:@"%.2f",self.priceAll];
                shopM.isSelect = NO;
                self.viewCarList.arrShop = self.arrShop;
            }
            
        }else if([select isEqualToString:@"2"]){//处理加运算
            if ([isSelect isEqualToString:@"1"]) {
                priceF = [price doubleValue];
                self.priceAll = self.priceAll+priceF;
                self.viewCarList.priceAllOut = [NSString stringWithFormat:@"%.2f",self.priceAll];
            }
        }else if ([select isEqualToString:@"3"]){//处理减运算
            
            if ([isSelect isEqualToString:@"1"]) {
                priceF = [price doubleValue];
                self.priceAll = self.priceAll-priceF;
                self.viewCarList.priceAllOut = [NSString stringWithFormat:@"%.2f",self.priceAll];
            }
        }else if([select isEqualToString:@"4"]){//处理输入运算
            if ([isSelect isEqualToString:@"1"]) {
                NSString *priceT3 = dic[@"priceT3"];
                CGFloat priceT33 = [priceT3 doubleValue];
                self.priceAll = self.priceAll+priceT33;
                self.viewCarList.priceAllOut = [NSString stringWithFormat:@"%.2f",self.priceAll];
            }
        }
    }
    
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"移除了观察者");
}
-(void)p_makeupViewInPLZStoreCarVC
{
    self.title = @"购物车";
    [self makeupRightButtonForNavigationRight];
    [self.buttonRight setTitle:@"编辑" forState:(UIControlStateNormal)];
    self.viewCarList = [[YSTShopCarListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    __weak typeof(self) weakSelf = self;

    [self.view addSubview:self.viewCarList];
    //点击全选或者全不选更新一下控制器里的数据
    self.viewCarList.selectCell = ^(NSInteger index) {
        NSLog(@"点击的是购物车第%ld个",index);
    };

    self.viewCarList.didSelectedAllButtonBlock = ^(NSString *price) {
        weakSelf.priceAll = [price doubleValue];
    };
}
-(void)p_makeupDataInPLZStoreCarVC
{
    NSArray *arrName = @[@"张三的店铺",@"李四的店铺",@"王五的店铺",@"朱六的店铺",@"杨七的店铺",@"牛八的店铺",@"阿九的店铺",@"小石的店铺",@"十一郎的店铺",@"十二的店铺",@"十三的店铺",@"十四小兄弟的店铺"];
    NSArray *arrShop = @[@"小果子",@"大果子",@"小水果",@"大水果",@"新衣服"];
    for (int i = 0; i<arc4random()%10+2; i++) {
        
        ShopM *shopMM = [[ShopM alloc] init];
        shopMM.shopName = arrName[i];
        for (int j = 0; j<arc4random()%4+1; j++) {
            ShopChild *childM = [[ShopChild alloc] init];
            childM.shopName = arrShop[j];
            childM.count = [NSString stringWithFormat:@"%u",arc4random()%6+1];
            childM.price = [NSString stringWithFormat:@"%u",arc4random()%200+1];
            [shopMM.content addObject:childM];
        }
        [self.arrShop addObject:shopMM];
    }
    NSLog(@"数组有%ld个元素",self.arrShop.count);
    self.viewCarList.arrShop = self.arrShop;
}
-(void)makeupRightButtonForNavigationRight{
    
    self.buttonRight = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.buttonRight setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.buttonRight setTitle:@"完成" forState:(UIControlStateNormal)];
    self.buttonRight.frame = CGRectMake(0, 0, 64, 40);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.buttonRight];
    self.buttonRight.hidden = NO;
    [self.buttonRight addTarget:self action:@selector(buttonRightActionInShopCarVC) forControlEvents:(UIControlEventTouchUpInside)];
}
#pragma mark - 点击购物车控制器的编辑按钮
-(void)buttonRightActionInShopCarVC
{
    if (self.isEdit) {
        self.isEdit = NO;
        [self.buttonRight setTitle:@"编辑" forState:(UIControlStateNormal)];
    }else{
        self.isEdit = YES;
        [self.buttonRight setTitle:@"取消" forState:(UIControlStateNormal)];
    }
    self.viewCarList.isEdit = self.isEdit;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//返回
-(void)plzForPopAction
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 24, 44);
    //    [button setImage:[UIImage imageNamed:@"back_img"] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
//    [button setTitle:@"返回" forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:@"G_Back_0"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonActionInBase) forControlEvents:(UIControlEventTouchUpInside)];
    //    self.buttonLeft = button;
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    //    button.backgroundColor = [UIColor yellowColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
#pragma mark - 模态返回
-(void)buttonActionInBase
{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 点击商品图片和店铺的跳转
-(void)needPushINshopCarListAction:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    NSString *name = dic[@"shopName"];
    NSString *type = dic[@"typeNew"];
    if ([type isEqualToString:@"1"]) {//跳转商品详情
        NSLog(@"跳转到商品%@的详情",name);
    }else{
        NSLog(@"跳转到商家%@的详情",name);
        
    }
}
@end
