//
//  ViewController.m
//  YSTModule
//
//  Created by 朱标 on 2018/6/8.
//  Copyright © 2018年 zhubiao. All rights reserved.
//  

#import "ViewController.h"
#import "SjjNavigationController.h"
#import "LoginViewController.h"
#import "PLZScanQrcodeVC.h"
#import "PLZQRCodeViewController.h"
#import "MultipleViewController.h"//富文本编辑框
#import "SetupViewController.h"//设置
#import "HomeSearchPageViewController.h"
#import "Yist_Module_WkWebViewController.h"     //wk
#import "Yist_Module_FeedBackViewController.h"      //意见反馈
#import "Yist_Module_AnimaltionViewController.h"        //动画
#import "YSTShopCarListVC.h"
#import "FourButtonVC.h"
#import "ButtonCodeVC.h"
#import "YSTCarouselViewController.h"
#import "Config.h"
#import "YSYSideBarViewController.h"
#import "YstWaterWaveViewController.h" //水波纹
#import "PJ_AppraiseListNVC.h"
#import "HtmlController.h"//解析html标签
#import "IssueViewController.h"//弹框菜单
#import "PHCalendar.h"
#import "ActionSheetViewController.h"
#import "IdentificationVC.h"
#import "AlertPopViewController.h"
#import "Timer.h"
#import "ShopStandardViewController.h"//商品规格
#import "orderListVC.h"

#import "YST_GuestureBtnViewController.h"//手势密码
#import "TradePasswordController.h"//输入交易密码框
#import "WriteCommentController.h"//写评论

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSArray *titleDataList;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //UI
    self.title=@"小组件";

    _dataList = @[@"实名认证",@"扫描二维码",@"登录注册",@"富文本",@"我的设置",@"搜索",@"购物车列表",@"评价列表",@"水波纹",@"发布菜单",@"解析html标签",@"自定义ActionSheet",@"自定义Alert弹出框",@"倒计时",@"日历",@"商品规格",@"订单列表",@"输入交易密码框",@"写评论"];

    //
    _titleDataList = @[@"webView",@"意见反馈",@"button四种图文排列",@"发送验证码",@"动画",@"轮播图",@"侧边栏",@"手势密码"];
    
}

#pragma mark tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return _dataList.count;
    };
    return _titleDataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    if(indexPath.section == 0){
        cell.textLabel.text = _dataList[indexPath.row];
    }else {
        cell.textLabel.text = _titleDataList[indexPath.row];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    if(indexPath.section == 1){
//        switch (indexPath.row) {
//            case 0:{
//                Yist_Module_WkWebViewController *Yist_Module_WkWebVC = [[Yist_Module_WkWebViewController alloc]init];
//                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Yist_Module_WkWebVC];
//                [self presentViewController:nav animated:YES completion:nil];
//            }
//                break;
//            case 1:{
//                Yist_Module_FeedBackViewController *Yist_Module_FeedBackVC = [[Yist_Module_FeedBackViewController alloc]init];
//                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Yist_Module_FeedBackVC];
//                [self presentViewController:nav animated:YES completion:nil];
//                return;
//            }
//            case 2:{
//                FourButtonVC *buttonVC = [[FourButtonVC alloc]init];
//                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:buttonVC];
//                [self presentViewController:nav animated:YES completion:nil];
//                return;
//            }
//            case 3:{
//                ButtonCodeVC *buttonVC = [[ButtonCodeVC alloc]init];
//                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:buttonVC];
//                [self presentViewController:nav animated:YES completion:nil];
//                return;
//            }
//                break;
//            case 4:{
//                Yist_Module_AnimaltionViewController *Yist_Module_AnimaltionVC = [[Yist_Module_AnimaltionViewController alloc]init];
//                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Yist_Module_AnimaltionVC];
//                [self presentViewController:nav animated:YES completion:^{
//                    
//                }];
//            }
//                break;
//            case 5:{
//                YSTCarouselViewController *carousel = [[YSTCarouselViewController alloc]init];
//                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:carousel];
//                [self presentViewController:nav animated:YES completion:^{
//                    
//                }];
//            }
//                break;
//            case 6:{
//                YSYSideBarViewController *carousel = [[YSYSideBarViewController alloc]init];
//                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:carousel];
//                [self presentViewController:nav animated:YES completion:^{
//                    
//                }];
//            }
//                break;
//            case 7:{
//       
//                
//            }
//                break;
//            default:
//                break;
//        }
//        return;
//    }
//    //扫描二维码功能模拟器不跳转
//    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && indexPath.section == 0 &&indexPath.row == 1) {
//        /// 硬件问题提示
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未能检测到摄像头" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//        return;
//
//    }
//
//    if (indexPath.row == 0) {
//        SetupViewController *secondVC = [[SetupViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:secondVC];
//        [self presentViewController:nav animated:YES completion:nil];
//    }else if (indexPath.row == 1) {
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        {
//            PLZScanQrcodeVC *seconVC = [[PLZScanQrcodeVC alloc] init];
//            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:seconVC];
//            [self presentViewController:naVC animated:YES completion:nil];
//        } else {
//            /// 硬件问题提示
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未能检测到摄像头" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            
//            [alertView show];
//        }
//   
//    }else if (indexPath.row == 2) {
//        LoginViewController * loginVC = [[LoginViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
//        [self presentViewController:nav animated:YES completion:nil];        
//    }else if (indexPath.row == 3) {
//        MultipleViewController *multiple = [[MultipleViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:multiple];
//        [self presentViewController:nav animated:YES completion:nil];
//        
//    }else if (indexPath.row ==4){
//        SetupViewController *setUpVc = [[SetupViewController  alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:setUpVc];
//        [self presentViewController:nav animated:YES completion:nil];
//    }else if (indexPath.row ==5){
//        HomeSearchPageViewController *searchVc = [[HomeSearchPageViewController  alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:searchVc];
//        [self presentViewController:nav animated:YES completion:nil];
//
//    }else if (indexPath.row==6){
//        YSTShopCarListVC *carListVC = [[YSTShopCarListVC  alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:carListVC];
//        [self presentViewController:nav animated:YES completion:nil];
//    }else if (indexPath.row==7){
//        PJ_AppraiseListNVC *carListVC = [[PJ_AppraiseListNVC  alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:carListVC];
//        [self presentViewController:nav animated:YES completion:nil];
//    }else if (indexPath.row==8 ){
//        YstWaterWaveViewController * waterWaveVC = [[YstWaterWaveViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:waterWaveVC];
//        [self presentViewController:nav animated:YES completion:nil];
//    }else if (indexPath.row ==9){
//        IssueViewController *issueVc = [[IssueViewController alloc]init];
//        [self presentViewController:issueVc animated:YES completion:nil];
//
//    }else if (indexPath.row == 10){
//        HtmlController *Html = [[HtmlController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Html];
//        [self presentViewController:nav animated:YES completion:^{
//            
//        }];
//
//    }
//    else if (indexPath.row == 11){
//        PHCalendar *calendar = [[PHCalendar alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:calendar];
//        [self presentViewController:nav animated:YES completion:^{
//            
//        }];
//        
//    }
    

    NSArray *viewControllers = [Config listViewControllerNames];
    NSString *className = viewControllers[indexPath.section][indexPath.row];
    Class objClass = NSClassFromString(className);
    UIViewController *vc = [[objClass alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    [self presentViewController:nav animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray *titleAry = @[@"基础UI",@"控件"];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    labe.text = titleAry[section];
    [headView addSubview:labe];
    return headView;
}
@end
