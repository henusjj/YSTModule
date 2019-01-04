//
//  HtmlController.m
//  YSTModule
//
//  Created by 冯亮亮 on 2018/6/27.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "HtmlController.h"
#import "HtmlView.h"

@interface HtmlController ()
@property(nonatomic,strong)HtmlView *userGuideView;//用户指南

@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,copy)NSString *htmlStr;
@end

@implementation HtmlController
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(HtmlView *)userGuideView
{
    if (!_userGuideView) {
        _userGuideView = [[HtmlView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _userGuideView;
}
- (void)viewDidLoad {
    self.navigationItem.title = @"解析Html标签";
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self.view addSubview:self.userGuideView];
    self.htmlStr = @"<p><strong>很经典的黑色后背纯雪纺透视装到货了哈</strong><strong>&nbsp;</strong></p><p><strong>前面莫代尔&nbsp;手感顺滑 柔软 &nbsp;手感不错</strong></p><p><strong>后面薄薄的雪纺纱</strong></p><p><strong>腰节处开叉</strong></p><p><strong>很大气，超有范儿的一款&nbsp; 这个年代随时随地 都可见的欧美街头范儿</strong></p><p><strong>后背透、透、透</strong></p><p><strong>165身高 96J穿起来大概在膝盖不到10CM的位置</strong></p><p>&nbsp;</p><p><strong>亲们啊~ 特别美得一款，穿起来超级有范，</strong></p><p><strong>看着特别不起眼的一件衣服，但上身效果特别好，</strong></p><p><strong>背面全部透视的雪纺黑纱，特别性感，</strong></p><p><strong>里面需要配一款黑色吊带，两侧带开叉的设计，亲们赶紧下手吧~~&middot;</strong></p><p>&nbsp;</p><p><strong>面料： 正面莫代尔背面：雪纺纱&nbsp;</strong></p><p><strong>Label:</strong>无主标 无尺码标&nbsp; 有吊牌 普通包装</p><p>&nbsp;</p><p><strong>Size</strong>：平铺尺寸,由于手工测量,会有2~3厘米的误差</p><p>~SIZE=CM</p><p>胸围：126连肩袖长：65&nbsp; 前衣长：80 后衣长：90</p><p>&nbsp;<img style=\"border-width:0;border-image-width:initial\" src=\"https://img.alicdn.com/imgextra/i4/676496646/T2zdB0X9NXXXXXXXXX_!!676496646.jpg\" width=\"100%\" height=\"((348 / 500) * 100)%\" align=\"absmiddle\">&nbsp;&nbsp;</p><p>&nbsp;</p>";
//    self.htmlStr = @"<title>关于APP的声明</title></head><body><h3>关于APP的声明</h3><p>只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试</p><p>只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试</p><h3>联系我们</h3><p>若您在使用该APP有遇到任何问题或有新想法，都可以联系我们. 如下是我们的联系方式:</p><ul><li>只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试</li><li>E-mail: xxxxxxxxxxxxxxxxxxxxxxxxxx</li><li>phone: xxxxxxxxxxxxxxxxxx</li></ul><h3>感谢</h3><p>首先，感谢广大用户对公司的支持和鼓励，谢谢你们对我们的一路支持.</p><p>只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试</p><h3>版权声明</h3><p>只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试只是测试</p></body></html>";
//    self.htmlStr = @"<html><body> Some html string \n <font size=\"13\" color=\"red\">This is some text!</font> </body></html>";
//    self.htmlStr = @"<p>你好</p><p>        这是一个例子，请显示</p><p>外加一个table</p><table><tbody><tr class=\"firstRow\"><td valign=\"top\" width=\"261\">aaaa</td><td valign=\"top\" width=\"261\">bbbb</td><td valign=\"top\" width=\"261\">cccc</td></tr></tbody></table><p></p>";
    // Do any additional setup after loading the view.
    [self postData];
    [self backBtn];

}
-(void)postData
{
    self.userGuideView.str = self.htmlStr;
    [self.userGuideView layoutIfNeeded];
    
    //    [[NetworkRequestTool shareInstance] postWithUrl:[NSString stringWithFormat:@"%@%@",ETP_API_MOBILE,ETP_UserGuide] paramWithDic:nil success:^(id responseObject) {
    //        NSLog(@"%@",responseObject);
    //        NSInteger code = [responseObject[@"code"] integerValue];
    //        NSString *msg = responseObject[@"msg"];
    //
    //        NSLog(@"%@",[responseObject[@"content"] objectForKey:@"content"]);
    //        if (code == 1) {
    //            self.userGuideView.str = [responseObject[@"content"] objectForKey:@"content"];
    //            [self.userGuideView layoutIfNeeded];
    //        }else{
    //            self.userGuideView.str = self.htmlStr;
    //            [self.userGuideView layoutIfNeeded];
    //        }
    //
    //    } failure:^(NSError *error) {
    //        self.userGuideView.str = self.htmlStr;
    //        [self.userGuideView layoutIfNeeded];
    //
    //    }];
}
//添加返回按钮
-(void)backBtn{
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 10, 50, 20)];
    [backBtn setTitle:@"  返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    backBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    backBtn.imageEdgeInsets=UIEdgeInsetsMake(2,2,2,2);
    [backBtn setImage:[UIImage imageNamed:@"G_Back_0"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    UIBarButtonItem *flexBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexBtn.width= 0;//正数往左移，负数往右移
    self.navigationItem.leftBarButtonItems=@[flexBtn,leftBtn];
}
//返回按钮
-(void)backto{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
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
