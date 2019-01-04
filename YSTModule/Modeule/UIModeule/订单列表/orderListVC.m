//
//  orderListVC.m
//  YSTModule
//
//  Created by 史玉金 on 2018/7/6.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "orderListVC.h"
#import "OrderListBar.h"

@interface orderListVC ()

@end

@implementation orderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的订单";
    self.view.backgroundColor=[UIColor whiteColor];
    self.stuta = @"0";
    [self creatMenu];
}
-(void)creatMenu{
    NSArray *menuList=@[@"全部订单",@"待付款",@"待使用",@"待评价",@"售后"];
    OrderListBar *menu=[[OrderListBar alloc]init];
    [menu setBarPoint:CGPointMake(0, 0)];
//    线宽
    menu.lineWide=30;
//    线色
    menu.lineColor=[UIColor orangeColor];
//    选中与否 设置显色
    [menu setData:menuList NormalColor:[UIColor grayColor] SelectColor:[UIColor redColor] Font:[UIFont systemFontOfSize:13]];
    
    [self.view addSubview:menu];
//    点进去选择状态
    [menu setViewIndex:self.stuta.intValue];//这里始终是选择全部订单
    
//    标签回调
    [menu getViewIndex:^(NSString *title, NSInteger index) {
        self.stuta = [NSString stringWithFormat:@"%ld",index];
        NSLog(@"index--------%@",self.stuta);
        
//    点击标签需要做的事情
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
