//
//  IssueMenueScrollView.m
//  YSTModule
//
//  Created by 李慧静 on 2018/6/27.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "IssueMenueScrollView.h"
#import "IssueMenueButton.h"
#import "IssueMenueItem.h"
#import "IssueMenueItemView.h"

@interface IssueMenueScrollView ()<IssueMenueItemViewDelegate,UIScrollViewDelegate>
/** 背景视图 */
@property (strong, nonatomic) UIView *backgroundView;
/** 背景视图 */
@property (strong, nonatomic) UIScrollView *backgroundScrollView;
/** 底部使能按钮 */
@property (strong, nonatomic) UIButton *bottomActiveButton;
/** 底部pageControl */
@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic)  UIView *linkView;

@property (strong,nonatomic) NSMutableArray *menueArray;
@end

@implementation IssueMenueScrollView


-(NSMutableArray *)menueArray{
    
    if (!_menueArray) {
        _menueArray=[NSMutableArray array];
    }
    return _menueArray;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    self.backgroundColor= [UIColor whiteColor];
    self.alpha=1;
    UITapGestureRecognizer *tapGestre=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignActive)];
    [self addGestureRecognizer:tapGestre];
    
    
    
}

+ (instancetype)menu
{
    return [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
}


+(instancetype)menuWithItems:(NSArray *)items{
    
    IssueMenueScrollView *issueMenue=[self menu];
    issueMenue.frame=[UIScreen mainScreen].bounds;
    issueMenue.menusItems=items;
    return issueMenue;
}
-(void)setMenusItems:(NSArray<NSArray *> *)menusItems{
    
    _menusItems=menusItems;
    if (_backgroundScrollView==nil) {
        [self addBackgroundScrollView];
    }
    self.backgroundScrollView.contentSize=CGSizeMake(kScreenWidth*menusItems.count, CGRectGetHeight(self.backgroundScrollView.frame));
    self.pageControl.numberOfPages=menusItems.count;
    [self setMenusView];
}

-(void)setMenusView{
    
    for (int i=0; i<self.menusItems.count; i++) {
        NSArray *itemArray=self.menusItems[i];
        
        IssueMenueItemView *menueView=[IssueMenueItemView menuWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, CGRectGetHeight(self.backgroundScrollView.frame)) items:itemArray];
        menueView.delegate=self;
        menueView.tag=2000+i;
        if (itemArray.count<4) {
            
            menueView.columns = itemArray.count;
            // 最后一个按钮与底部的距离
            menueView.spaceToBottom = 60;
            
        }else{
            menueView.columns=4;
            // 最后一个按钮与底部的距离
            menueView.spaceToBottom = 120;
        }
        menueView.buttonDiameter = 62;
        menueView.buttonTitleColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        menueView.enableTouchResignActive = YES;
        [self.backgroundScrollView addSubview:menueView];
        
        [self.menueArray addObject:menueView];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 添加底部按钮
    if (_bottomActiveButton == nil) {
        [self addBottomActiveButton];
    }if (_pageControl==nil) {
        [self addBottomPageControl];
    }// 添加背景视图
    if (_backgroundView == nil) {
        [self addBackgroundView];
    }
}

#pragma mark - 布局
-(void)addBackgroundView{
    if ([self.dataSource respondsToSelector:@selector(backgroundViewOfSpringMenu:)]) {
        UIView *backgroundView = [self.dataSource backgroundViewOfSpringMenu:self];
        [self insertSubview:backgroundView atIndex:0];
        self.backgroundView = backgroundView;
        // 有背景视图后，把自定义控件背景颜色设置为clearColor
        self.backgroundColor = [UIColor clearColor];
    }
    
}
-(void)addBackgroundScrollView{
    
    UIScrollView *backgroundScrollView=[[UIScrollView alloc]init];
    CGFloat scrollMaxY=CGRectGetMinY(self.pageControl.frame)-10;
    backgroundScrollView.delegate=self;
    backgroundScrollView.showsHorizontalScrollIndicator=NO;
    backgroundScrollView.pagingEnabled=YES;
    backgroundScrollView.frame=CGRectMake(0,0,kScreenWidth, kScreenHeight);
    [self addSubview:backgroundScrollView];
    self.backgroundScrollView=backgroundScrollView;
    
}

-(void)addBottomPageControl{
    if ([self.dataSource respondsToSelector:@selector(bottomPageControlOfSpringMenu:)]) {
        UIPageControl *pageControl=[self.dataSource bottomPageControlOfSpringMenu:self];
        CGFloat pageCenterY = CGRectGetMinY(self.linkView.frame) - pageControl.bounds.size.height / 2.0;
        pageControl.center=CGPointMake(kScreenWidth*0.5, pageCenterY);
        [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:pageControl];
        self.pageControl=pageControl;
    }
}
-(void)addBottomActiveButton{
    
    if ([self.dataSource respondsToSelector:@selector(buttonToChangeActiveForSpringMenu:)]) {
        UIButton *btn = [self.dataSource buttonToChangeActiveForSpringMenu:self];
        CGFloat btnCenterY = kScreenHeight - btn.bounds.size.height / 2.0;
        btn.center = CGPointMake(kScreenWidth * 0.5, btnCenterY);
        [btn addTarget:self action:@selector(bottomButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _bottomActiveButton = btn;
        
        UIView *linkView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(btn.frame)-10.5, kScreenWidth, 0.5)];
        linkView.backgroundColor=[UIColor grayColor];
        linkView.tag=1001;
        [self addSubview:linkView];
        self.linkView=linkView;
        
    }
}
#pragma mark 显示menu
- (void)becomeActive
{
    self.alpha = 1.0;
    self.backgroundScrollView.alpha=1;
    self.bottomActiveButton.alpha = 1;
    UIView *linkView=[self viewWithTag:1001];
    linkView.alpha=1;
    for (int i=0; i<self.menusItems.count; i++) {
        IssueMenueItemView *menueView1=self.menueArray[i];
        if (i==0) {
            [menueView1 becomeActive];
        }else
            menueView1.alpha=1;
    }
}
#pragma mark 取消显示menu
- (void)resignActive
{
    
    int pag =(int)self.pageControl.currentPage;
    
    for (int i=0; i<self.menusItems.count; i++) {
        IssueMenueItemView *menunView=self.menueArray[i];
        if (i==pag) {
            [menunView resignActive];
        }else
            menunView.alpha=0;
    }
    
}
#pragma mark 点击方法

-(void)bottomButtonOnClick:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(springMenu:didClickBottomActiveButton:)]) {
        [self.delegate springMenu:self didClickBottomActiveButton:self.bottomActiveButton];
    }
    
    // 一般按底部都是隐藏视图，所以直接实现，不由代理实现了
    [self resignActive];
    
}

#pragma mark - IssueMenueItemViewDelegate

-(void)springMenu:(IssueMenueItemView *)menu didClickButtonWithIndex:(NSInteger)index{
    
    if ([self.delegate respondsToSelector:@selector(springMenu:menueItemView:didClickButtonWithIndex:)]) {
        
        [self.delegate springMenu:self menueItemView:menu didClickButtonWithIndex:index];
    }
    
    
    
}
-(void)resignCurrentActive:(IssueMenueItemView *)menu{
    
    self.bottomActiveButton.alpha = 0;
    self.backgroundScrollView.alpha=0;
    UIView *linkView=[self viewWithTag:1001];
    linkView.alpha=0;
    self.backgroundColor = [UIColor clearColor];
    
}
-(void)resignCurrentActiveEnd:(IssueMenueItemView *)menu{
    self.alpha=0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[self getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
    });
}

#pragma mark ScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage=page;
    
}

-(void)changePage:(id)sender {
    int page = (int)self.pageControl.currentPage;
    [self.backgroundScrollView setContentOffset:CGPointMake(kScreenWidth*page, 0)animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //    if (self.isEnableTouchResignActive) {
    //        [self resignActive];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [[YSTCommonTools getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
    //        });
    //    }
}

- (UIViewController *)getCurrentVC
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

@end
