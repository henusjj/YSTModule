//
//  YSTShopCarListView.m
//  ShopCarListDemo
//
//  Created by penglaizhi on 2018/6/12.
//  Copyright © 2018年 决心. All rights reserved.
//

#import "YSTShopCarListView.h"
#import "YSTShopCarCell.h"



@interface YSTShopCarListView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
/*购物车列表*/
@property (nonatomic,strong) UITableView *tableViewCarList;
/*全选按钮*/
@property (nonatomic,strong) UIButton *buttonAll;
/*全选后的价格合计*/
@property (nonatomic,assign) CGFloat priceAll;
/*全选按钮状态*/
@property (nonatomic,assign) BOOL isAll;
/*合计价格*/
@property (nonatomic,strong) UILabel *labelAllPrice;
/*结算按钮*/
@property (nonatomic,strong) UIButton *buttonOK;
/**底部view*/
@property (nonatomic,strong) UIView *viewDown;
/*参数字典*/
@property (nonatomic,strong) NSMutableDictionary *dicPram;

@end
@implementation YSTShopCarListView
-(NSMutableDictionary *)dicPram
{
    if (_dicPram==nil) {
        _dicPram = [NSMutableDictionary dictionary];
    }
    return _dicPram;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_makeupViewForPLZStoreCarView];
    }
    return self;
}

-(void)p_makeupViewForPLZStoreCarView
{
    self.backgroundColor = [UIColor whiteColor];
    self.tableViewCarList = [[UITableView alloc] initWithFrame:CGRectMake(1, 1, 1, 1) style:(UITableViewStyleGrouped)];
    self.tableViewCarList.delegate = self;
    self.tableViewCarList.dataSource = self;
    [self addSubview:self.tableViewCarList];
    self.tableViewCarList.rowHeight = UITableViewAutomaticDimension;
    self.tableViewCarList.estimatedRowHeight = 105;
    //    self.tableViewCarList.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    
    [self.tableViewCarList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.offset(0);
//        make.top.offset(kNavHeight);
        //        ([[UIApplication sharedApplication] statusBarFrame].size.height + 44)
        make.bottom.offset(-54-kNavHeight);
        
    }];
    self.viewDown = [[UIView alloc] init];
    [self addSubview:self.viewDown];
    self.buttonOK = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.buttonAll = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        self.labelAllPrice = [PJ_CreatLabel creatLabelFont:15 color:@"222222" title:@"allPrice:226"];
    self.labelAllPrice = [[UILabel alloc] init];
    self.labelAllPrice.font = [UIFont systemFontOfSize:12];
    self.labelAllPrice.textAlignment = NSTextAlignmentRight;
    self.labelAllPrice.text = @"合计：￥0";
    
    [self.viewDown addSubview:self.buttonAll];
    [self.viewDown addSubview:self.buttonOK];
    [self.viewDown addSubview:self.labelAllPrice];
    [self.buttonAll setTitle:@"全选" forState:(UIControlStateNormal)];
    self.buttonAll.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.buttonAll setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [self.buttonAll setImage:[UIImage imageNamed:@"购物车_未选中"] forState:(UIControlStateNormal)];
    [self.buttonAll addTarget:self action:@selector(buttonAllActionInShopCarListView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.buttonAll setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
    
    [self.buttonOK setTitle:@"结算" forState:(UIControlStateNormal)];
    self.buttonOK.backgroundColor = [UIColor redColor];
    [self.buttonOK setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.buttonOK addTarget:self action:@selector(buttonOKAction) forControlEvents:(UIControlEventTouchUpInside)];
//    self.labelAllPrice.backgroundColor = [UIColor greenColor];
    
    [self.viewDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.offset(0);
        make.top.equalTo(self.tableViewCarList.mas_bottom).offset(5);
        make.height.mas_equalTo(44);
    }];
    
    [self.buttonAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.leading.offset(10);
        make.width.mas_equalTo(60);
        
    }];
    [self.buttonOK mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.bottom.offset(0);
        make.width.mas_equalTo(100);
    }];
    [self.labelAllPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.leading.equalTo(self.buttonAll.mas_trailing).offset(10);
        make.trailing.equalTo(self.buttonOK.mas_leading).offset(-10);
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    ShopM *shop = self.arrShop[indexPath.section];
    ShopChild *childM = shop.content[indexPath.row];
    childM.section = [NSString stringWithFormat:@"%ld",indexPath.section];
    
    YSTShopCarCell *cell = [YSTShopCarCell cellWithtableViewForGoodsCarN:tableView];
    cell.childM = childM;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableViewCarList endEditing:YES];

    self.selectCell(indexPath.section);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrShop.count;
    return arc4random()%6+2;
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ShopM *shopA = self.arrShop[section];
    return shopA.content.count;
    return arc4random()%5+1;
    return 1;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 130;
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShopM *shop = self.arrShop[section];
    
//    UIView *viewAll = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UIButton *viewAll = [UIButton buttonWithType:(UIButtonTypeSystem)];
    viewAll.frame = CGRectMake(0, 0, kScreenWidth, 50);
    viewAll.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
//    [viewAll addTarget:self action:@selector(viewAllActionInCarView:) forControlEvents:(UIControlEventTouchUpInside)];
//    viewAll.tag = 500+section;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 40)];
    [viewAll addSubview:view];
    
    UIButton *buttonChoose = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [view addSubview:buttonChoose];
    [buttonChoose addTarget:self action:@selector(buttonChooseActionInPLZStoreCarCell:) forControlEvents:(UIControlEventTouchUpInside)];
    buttonChoose.tag = 100+section;
    
    UIButton *buttonIcon = [UIButton buttonWithType:(UIButtonTypeCustom)];
    buttonIcon.layer.masksToBounds = YES;
    buttonIcon.layer.cornerRadius = 15;
    buttonIcon.backgroundColor = [UIColor grayColor];
    [view addSubview:buttonIcon];
    [buttonIcon addTarget:self action:@selector(buttonIconActionInPLZStoreCarCell:) forControlEvents:(UIControlEventTouchUpInside)];
    buttonIcon.tag = 1000+section;
    
    UILabel *labelName = [[UILabel alloc] init];
    labelName.text = @"There is no doubt that!";
    labelName.numberOfLines = 1;
    [view addSubview:labelName];
    
    //    UIButton *buttonRightArrows = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    buttonRightArrows.backgroundColor = [UIColor grayColor];
    //    [view addSubview:buttonRightArrows];
    
    view.backgroundColor = [UIColor whiteColor];
    UIView *viewLine = [[UIView alloc] init];
    viewLine.backgroundColor = [UIColor colorWithRed:0.9 green:0.8 blue:0.9 alpha:1];
    [view addSubview:viewLine];
    [buttonChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(6);
        make.width.height.mas_equalTo(25);
        make.top.offset(6);
    }];
    
    [buttonIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(buttonChoose.mas_trailing).offset(11);
        make.width.height.mas_equalTo(30);
        make.centerY.equalTo(buttonChoose);
        
    }];
    
    //    [buttonRightArrows mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.trailing.offset(-11);
    //        make.centerY.equalTo(buttonChoose);
    //        make.width.height.mas_equalTo(17);
    //    }];
    
    [labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(buttonIcon.mas_trailing).offset(10);
        //        make.trailing.equalTo(buttonRightArrows.mas_leading).offset(-10);
        make.trailing.offset(30);
        make.centerY.equalTo(buttonChoose);
    }];
    [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonIcon.mas_bottom).offset(6);
        make.leading.trailing.offset(0);
        make.height.mas_equalTo(1);
    }];
    
    if (shop.isSelect) {
        [buttonChoose setImage:[UIImage imageNamed:@"购物车_选中"] forState:(UIControlStateNormal)];
    }else{
        [buttonChoose setImage:[UIImage imageNamed:@"购物车_未选中"] forState:(UIControlStateNormal)];
    }
    labelName.text = shop.shopName;
    
//    view.userInteractionEnabled = NO;
    return viewAll;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - 选择的section的选中按钮
-(void)buttonChooseActionInPLZStoreCarCell:(UIButton *)sender
{
    NSLog(@"第%ld个商家的选中",sender.tag-100);
    ShopM *shopN = self.arrShop[sender.tag-100];
    CGFloat floatSection = 0;
    CGFloat floatSection2 = 0;
    for (int i = 0; i<shopN.content.count; i++) {
        ShopChild *childM = shopN.content[i];
        CGFloat priceF = [childM.count integerValue]*[childM.price doubleValue];
        if (!childM.isSelect) {
            floatSection = floatSection+priceF;
        }
        floatSection2 = floatSection2+priceF;

    }

    if (shopN.isSelect) {
        shopN.isSelect = NO;
        [sender setImage:[UIImage imageNamed:@"购物车_未选中"] forState:(UIControlStateNormal)];
        for (int i = 0; i<shopN.content.count; i++) {
            ShopChild *childM =shopN.content[i];
            childM.isSelect = NO;
        }
    }else{
        shopN.isSelect = YES;
        [sender setImage:[UIImage imageNamed:@"购物车_选中"] forState:(UIControlStateNormal)];
        for (int i = 0; i<shopN.content.count; i++) {
            ShopChild *childM =shopN.content[i];
            childM.isSelect = YES;
        }
    }
    [self.tableViewCarList reloadData];
    self.dicPram = [shopN mj_keyValues];
    self.dicPram[@"type"] = @"1";//1代表商户，2代表具体商品
    self.dicPram[@"section"] = [NSString stringWithFormat:@"%ld",sender.tag-100];
    NSLog(@"sender.tag = %ld",sender.tag);
    self.dicPram[@"price"] = [NSString stringWithFormat:@"%.2f",floatSection];
    self.dicPram[@"price2"] = [NSString stringWithFormat:@"%.2f",floatSection2];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseGoodCarWithIndex" object:nil userInfo:self.dicPram];

}
#pragma mark - 选择的section的选中的头像
-(void)buttonIconActionInPLZStoreCarCell:(UIButton *)sender
{
    NSLog(@"第%ld个商家的头像",sender.tag-1000);
    ShopM *shopN = self.arrShop[sender.tag-1000];
    
    self.dicPram = [shopN mj_keyValues];
    self.dicPram[@"typeNew"] = @"2";//1代表是点击商品图，2跳转店铺
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"needPushINshopCarList" object:nil userInfo:self.dicPram];

}
#pragma mark - set方法赋值更新数据
-(void)setArrShop:(NSArray *)arrShop
{
    _arrShop = arrShop;
    [self.tableViewCarList reloadData];
//    for (int i = 0; i<arrShop.count; i++) {
//        ShopM *shop = arrShop[i];
//        for (int j = 0; j<shop.content.count; j++) {
//            ShopChild *childM = shop.content[j];
//
//        }
//
//    }
}
#pragma mark - 全选按钮点击事件
-(void)buttonAllActionInShopCarListView
{
    if (self.isAll) {
        self.isAll = NO;
        for (int i = 0; i<self.arrShop.count;i++ ) {
            ShopM *shop = self.arrShop[i];
            shop.isSelect = NO;
            for (int j = 0; j<shop.content.count; j++) {
                ShopChild *childM = shop.content[j];
                childM.isSelect = NO;
            }
        }
        [self.buttonAll setImage:[UIImage imageNamed:@"购物车_未选中"] forState:(UIControlStateNormal)];
        self.priceAll = 0;
        self.labelAllPrice.text = @"合计：￥0";

    }else{
        [self.buttonAll setImage:[UIImage imageNamed:@"购物车_选中"] forState:(UIControlStateNormal)];

        self.isAll = YES;
        for (int i = 0; i<self.arrShop.count;i++ ) {
            ShopM *shop = self.arrShop[i];
            shop.isSelect = YES;
            for (int j = 0; j<shop.content.count; j++) {
                ShopChild *childM = shop.content[j];
                self.priceAll = [childM.count integerValue]*[childM.price doubleValue]+self.priceAll;
                childM.isSelect = YES;
            }
        }
        self.labelAllPrice.text = [NSString stringWithFormat:@"合计：￥%.2f",self.priceAll];

    }
    NSString *newPrcie = [NSString stringWithFormat:@"%.2f",self.priceAll];
    self.didSelectedAllButtonBlock(newPrcie);
    [self.tableViewCarList reloadData];
}
-(void)setPriceAllOut:(NSString *)priceAllOut
{
    priceAllOut = priceAllOut;
    self.labelAllPrice.text = [NSString stringWithFormat:@"合计：￥%@",priceAllOut];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self endEditing:YES];

}
-(void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
    if (isEdit) {
        [self.buttonOK setTitle:@"删除" forState:(UIControlStateNormal)];

    }else{
        [self.buttonOK setTitle:@"结算" forState:(UIControlStateNormal)];

    }

}
#pragma mark - 点击结算、删除按钮
-(void)buttonOKAction
{
    if (self.isEdit) {
        NSLog(@"删除已选");
    }else{
        NSLog(@"去结算");
    }
}
#pragma mark - 店家商家--
-(void)viewAllActionInCarView:(UIButton *)sender
{
    ShopM *shopN = self.arrShop[sender.tag-500];

    self.dicPram = [shopN mj_keyValues];
    self.dicPram[@"typeNew"] = @"2";//1代表是点击商品图，2跳转店铺
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"needPushINshopCarList" object:nil userInfo:self.dicPram];

}
@end
