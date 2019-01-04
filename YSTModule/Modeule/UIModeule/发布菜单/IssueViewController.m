//
//  IssueViewController.m
//  YSTModule
//
//  Created by 李慧静 on 2018/6/27.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "IssueViewController.h"
#import "IssueMenueScrollView.h"
#import "IssueMenueItemView.h"
#import "IssueMenueItem.h"

@interface IssueViewController ()<UIScrollViewDelegate,IssueMenueScrollViewDataSource,IssueMenueScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (nonatomic,strong)IssueMenueScrollView *menueScrollView;


@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];

}

- (void)initView {
    
    //菜单配置
    IssueMenueItem *item1 = [IssueMenueItem itemWithImage:[UIImage imageNamed:@"icon-提问"] title:@"提问"];
    IssueMenueItem *item2 = [IssueMenueItem itemWithImage:[UIImage imageNamed:@"icon-找人"] title:@"找人"];
    NSArray *items = @[item1, item2];
    
    IssueMenueItem *item3 = [IssueMenueItem itemWithImage:[UIImage imageNamed:@"icon-视频"] title:@"视频"];
    IssueMenueItem *item4 = [IssueMenueItem itemWithImage:[UIImage imageNamed:@"icon-直播"] title:@"直播"];
    IssueMenueItem *item5 = [IssueMenueItem itemWithImage:[UIImage imageNamed:@"icon-图文资讯"] title:@"图文资讯"];
//    IssueMenueItem *item6 = [IssueMenueItem itemWithImage:[UIImage imageNamed:@"invite_img"] title:@"邀请帖"];
    IssueMenueItem *item7 = [IssueMenueItem itemWithImage:[UIImage imageNamed:@"icon-合作项目"] title:@"项目合作"];
    NSArray *rightItems = @[item3,item4,item5,item7];
    NSArray *menueArray=@[items,rightItems];
    
    //菜单赋值
    IssueMenueScrollView *menueScrollView=[IssueMenueScrollView menuWithItems:menueArray];
    menueScrollView.delegate=self;
    menueScrollView.dataSource=self;
    menueScrollView.spaceToBottom=100;
    [self.view addSubview:menueScrollView];
    self.menueScrollView=menueScrollView;
    
    
}

#pragma mark TPCSpringMenuDelegate

-(void)springMenu:(IssueMenueScrollView *)menu didClickBottomActiveButton:(UIButton *)button{
    
    
    
}
-(void)springMenu:(IssueMenueScrollView *)menu menueItemView:(IssueMenueItemView *)itemView didClickButtonWithIndex:(NSInteger)index{
    
    
    switch (itemView.tag-2000) {
        case 0:{
            
            // 提问、找人
            switch (index-20) {
                case 0:{
                    //发布提问
                   
                    
                }
                    break;
                case 1:{
                    // 发布找人
                  
                    
                    
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            
            break;
        case 1:{
            
            
            
            switch (index-20) {
                case 0:{
                    //视频
                  
                    
                }
                    break;
                case 1:{
                    
                    //                  直播
                  
                    
                    
                }
                    break;
                case 2:{
                    // 发布图文资讯
                
                }
                    break;
                case 3:{
                    // 发布项目合作
                   
                    
                }
                    break;
                case 4:{
                    
                    
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark TPCSpringMenuDataSource
- (UIButton *)buttonToChangeActiveForSpringMenu:(IssueMenueScrollView *)menu
{
    [self.bottomButton setImage:[UIImage imageNamed:@"icon-关闭"] forState:UIControlStateNormal];
    return self.bottomButton;
}

- (UIView *)backgroundViewOfSpringMenu:(IssueMenueScrollView *)menu
{
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    
    return view;
}

-(UIPageControl *)bottomPageControlOfSpringMenu:(IssueMenueScrollView *)menu{
    
    UIPageControl *pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 30)];
    pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    pageControl.pageIndicatorTintColor=[UIColor grayColor];
    pageControl.numberOfPages=2;
    pageControl.currentPage=0;
    return pageControl;
}
- (void)hideMenue {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
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
