//
//  Config.m
//  YSTModule
//
//  Created by 朱标 on 2018/7/5.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "Config.h"

@implementation Config
+(NSArray<NSArray<NSString *>*>*)listViewControllerNames
{
    return@[
            @[
                @"IdentificationVC",         //实名认证
                @"PLZScanQrcodeVC",              //扫描二维码
                @"LoginViewController",          //登录注册
                @"MultipleViewController",       //富文本
                @"SetupViewController",          //我的设置
                @"HomeSearchPageViewController", //搜索
                @"YSTShopCarListVC",              //购物车
                @"PJ_AppraiseListNVC",            //
                @"YstWaterWaveViewController",    //
                @"IssueViewController",           //
                @"HtmlController",                //解析html标签
                @"ActionSheetViewController",     //
                @"AlertPopViewController",        //自定义alert弹框
                @"Timer",
                @"PHCalendar",                    // 日历
                @"ShopStandardViewController",    //商品规格
                @"orderListVC",                   //订单列表
                @"TradePasswordController",      //输入交易密码框
                @"WriteCommentController",       //写评论
            ],
            @[
                @"Yist_Module_WkWebViewController",     //webView
                @"Yist_Module_FeedBackViewController",  //意见反馈
                @"FourButtonVC",                        //button四中图文排序
                @"ButtonCodeVC",                        //发送验证码
                @"Yist_Module_AnimaltionViewController",//动画
                @"YSTCarouselViewController",           //轮播图
                @"YSYSideBarViewController",            //侧滑
                @"YST_GuestureBtnViewController",            //手势密码

            ]
          ];

}
@end
