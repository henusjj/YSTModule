//
//  PHCalendar.m
//  PHPackAge
//
//  Created by wdx on 16/8/9.
//  Copyright © 2016年 wdx. All rights reserved.
//

#import "PHCalendar.h"
#import "PHCalendarContentVC.h"

@interface PHCalendar ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (nonatomic,strong)UILabel * yearAndMonth;
@property (nonatomic,assign)NSInteger currentYear;
@property (nonatomic,assign)NSInteger currentMonth;
@property (nonatomic,assign)NSInteger currentMonthConstant;

@property (nonatomic,strong)UIPageViewController * mainPage;
@end

@implementation PHCalendar

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self newNavi];
    [self newView];
    [self reshView];
    // Do any additional setup after loading the view.
}
-(void)loadData{
    NSDateFormatter * fo=[[NSDateFormatter alloc]init];
    [fo setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*3600]];
    [fo setDateFormat:@"yyyy-MM-dd"];
    NSString * nowDateString=[fo stringFromDate:[NSDate date]];
    NSArray * nowDateArr=[nowDateString componentsSeparatedByString:@"-"];
    
    
    _currentYear=[[NSString stringWithFormat:@"%@",nowDateArr[0]] integerValue];
    _currentMonth=[[NSString stringWithFormat:@"%@",nowDateArr[1]] integerValue];
    _currentMonthConstant=_currentMonth;
}
-(void)newNavi{
    self.title = @"日历";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)newView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _yearAndMonth=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, self.view.width-20, 20)];
    _yearAndMonth.font=[UIFont systemFontOfSize:16];
    _yearAndMonth.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_yearAndMonth];
    
    UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(10, _yearAndMonth.bottom, self.view.width-20, 20)];
    [self.view addSubview:topView];
    
    NSArray * weekTitles=@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat weekW=topView.width/7;
    
    for (int i =0 ; i < 7;  i ++) {
        UILabel * week=[[UILabel alloc]initWithFrame:CGRectMake(i * weekW, 0, weekW, topView.height)];
        week.textAlignment=NSTextAlignmentCenter;
        week.text=weekTitles[i];
        week.font=[UIFont systemFontOfSize:13];
        [topView addSubview:week];
    }
    
    
    _mainPage=[[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    PHCalendarContentVC * calendar=[PHCalendarContentVC instantMonthPageWithCurrentYear:_currentYear andMonth:_currentMonth];
    [_mainPage setViewControllers:@[calendar] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    _mainPage.delegate=self;
    _mainPage.dataSource=self;
    _mainPage.view.frame=self.view.frame;
    _mainPage.view.top=topView.bottom;
    _mainPage.view.height=_mainPage.view.width;

    [self.view addSubview:_mainPage.view];
    [self addChildViewController:_mainPage];
}
-(void)reshView{
     _yearAndMonth.text=[NSString stringWithFormat:@"%ld年 %ld月",(long)_currentYear,(long)_currentMonth];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger currentYear= ((PHCalendarContentVC *)(pageViewController.viewControllers.firstObject)).currentYear;
    NSInteger currentMonth= ((PHCalendarContentVC *)(pageViewController.viewControllers.firstObject)).currentMonth;
    currentMonth++;
    if (currentMonth>_currentMonthConstant+1) {
        return nil;
    }
    
    if (currentMonth>12) {
        currentMonth=1;
        currentYear+=1;
    }
    PHCalendarContentVC * calendar=[PHCalendarContentVC instantMonthPageWithCurrentYear:currentYear andMonth:currentMonth];
    return calendar;
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger currentYear= ((PHCalendarContentVC *)(pageViewController.viewControllers.firstObject)).currentYear;
    NSInteger currentMonth= ((PHCalendarContentVC *)(pageViewController.viewControllers.firstObject)).currentMonth;
    currentMonth--;
    if (currentMonth<_currentMonthConstant-1) {
        return nil;
    }
    
    
    if(currentMonth<1){
        currentMonth=12;
        currentYear-=1;
    }
    PHCalendarContentVC * calendar=[PHCalendarContentVC instantMonthPageWithCurrentYear:currentYear andMonth:currentMonth];
    return calendar;
}
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    NSInteger currentYear= ((PHCalendarContentVC *)(pageViewController.viewControllers.firstObject)).currentYear;
    NSInteger currentMonth= ((PHCalendarContentVC *)(pageViewController.viewControllers.firstObject)).currentMonth;
    _currentYear=currentYear;
    _currentMonth=currentMonth;
    [self reshView];
    
}


@end
