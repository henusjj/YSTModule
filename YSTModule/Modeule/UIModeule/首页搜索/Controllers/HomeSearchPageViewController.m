//
//  HomeSearchPageViewController.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "HomeSearchPageViewController.h"
#import "SearchPageTitleView.h"
#import "ServeProjectListViewController.h"
#import "ShareListViewController.h"
#import "SearchKeyWordRecommendView.h"

@interface HomeSearchPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UITextFieldDelegate>

@property (nonatomic,strong)SearchPageTitleView * titleV;

@property (nonatomic,strong)UIPageViewController * pageVC;

@property (nonatomic,strong)SearchKeyWordRecommendView * keywordView;


@property (nonatomic,strong)ServeProjectListViewController *  serveProjectListViewController;
@property (nonatomic,strong)ShareListViewController        *  shareListViewController;

@end

@implementation HomeSearchPageViewController

-(instancetype)init{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initUI];
    [self initKeyWordView];
    [_keywordView getHotKey];
    
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backVC)];
    // Do any additional setup after loading the view.
}
-(void)backVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)initKeyWordView{
    SearchKeyWordRecommendView * keyword = [SearchKeyWordRecommendView new];
    [self.view addSubview:keyword];
    _keywordView = keyword;
    __weak typeof(self) weakSelf = self;
    keyword.searchCall = ^(NSString *keyWord) {
        weakSelf.searchTF.text = keyWord;
        [weakSelf textFieldShouldReturn:weakSelf.searchTF];
    };
}


-(void)initNavi{
    self.navigationItem.titleView = [self titleView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClick:)];
}
-(void)initUI{
    self.view.backgroundColor  =[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];//[UIColor colorWithR:245 G:245 B:245];
    
    SearchPageTitleView * titleV = [SearchPageTitleView new];
    titleV.top = 5;
    [self.view addSubview:titleV];
    __weak typeof(self) weakSelf = self;
    titleV.selectCallBack = ^(NSUInteger index) {
        [weakSelf titleVSelectClick:index];
    };
    _titleV = titleV;
    
    _serveProjectListViewController = [ServeProjectListViewController new];
    _serveProjectListViewController.pageVC = self;
    _shareListViewController        = [ShareListViewController new];
    _shareListViewController.pageVC = self;
    
    
    _pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [_pageVC setViewControllers:@[_serveProjectListViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
    }];
    
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    [self addChildViewController:_pageVC];
    [self.view addSubview:_pageVC.view];
    _pageVC.view.top = titleV.bottom;
    _pageVC.view.height = self.view.height - titleV.bottom;
    [self findScrollView:_pageVC.view].scrollEnabled = NO;
}

-(UIView *)titleView
{
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width - 150, 30)];
    titleView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];//[UIColor colorWithR:234 G:234 B:234 alpha:1];
    titleView.layer.cornerRadius = 4;
    
    UITextField * textF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,titleView.width-10, 30)];
    textF.font = [UIFont systemFontOfSize:14];
    UIImageView * searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    searchImg.image = [UIImage imageNamed:@"search"];
    textF.leftView = searchImg;
    textF.leftViewMode = UITextFieldViewModeAlways;
    textF.placeholder = @"服务团队";
    textF.delegate = self;
    _searchTF =textF;
    
    [titleView addSubview:textF];
    textF.center = CGPointMake(titleView.width/2, titleView.height/2);
    return titleView;
}
#pragma mark -- 点击事件
-(void)titleVSelectClick:(NSInteger )index{
    if (index == _titleV.index) {
        return;
    }
    if (index == 0) {
        [_pageVC setViewControllers:@[_serveProjectListViewController] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
        }];
    }
    if (index == 1) {
        [_pageVC setViewControllers:@[_shareListViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        }];
    }
    
    
}
-(void)cancelBtnClick:(UIButton *)sender{
    
    _searchTF.text = @"";
    _searchTF.placeholder = @"服务团队";
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark delegate
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    //    if (_titleV.index == 1) {
    return nil;
    //    }
    //    return [PJ_ShareListViewController new];
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    //    if (_titleV.index == 0) {
    return nil;
    //    }
    //    return [PJ_ServeProjectListViewController new];
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (!completed) {
        return;
    }
    
    if ([previousViewControllers.firstObject isKindOfClass:[ServeProjectListViewController class]]) {
        _titleV.index = 0;
    }
    if ([previousViewControllers.firstObject isKindOfClass:[ShareListViewController class]]) {
        _titleV.index = 1;
    }
    
}
#pragma mark -- textField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    [_keywordView addKeyWord:textField.text];
    _keywordView.hidden = YES;
    //    if (_returnWord) {
    //        _returnWord(textField.text);
    //    }
    _serveProjectListViewController.keyWord = textField.text;
    _shareListViewController.keyWord = textField.text;
    
    return YES;
    
}
#pragma mark --
- (UIScrollView *)findScrollView:(UIView *)target{
                   UIScrollView * scrollView;
                   for(id subview in target.subviews){
                                    if([subview isKindOfClass:UIScrollView.class]){
                                             scrollView=subview;
                                             break;
                               }}
                  return  scrollView;
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
