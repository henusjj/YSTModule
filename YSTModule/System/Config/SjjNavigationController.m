//
//  SjjNavigationController.m
//  ALL-Demo
//
//  Created by 史玉金 on 2018/6/19.
//  Copyright © 2018年 henusjj.com. All rights reserved.
//

#import "SjjNavigationController.h"
//#import "SjjBaseControllerViewViewController.h"

@interface SjjNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, weak) id popDelegate;
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *popRecognizer;
@property(nonatomic,assign) BOOL isSystemSlidBack;//是否开启系统右滑返回
@end

@implementation SjjNavigationController
//APP生命周期中 只会执行一次
+ (void)initialize
{
    //导航栏主题 title文字属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.translucent = NO;

    //导航栏背景图
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"tabBarBj"] forBarMetrics:UIBarMetricsDefault];
    [navBar setBarTintColor:[UIColor whiteColor]];
    [navBar setTintColor:[UIColor blackColor]];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:17]}];
    
//    [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:[UIImage new]];//去掉阴影线
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
    self.navigationBar.translucent=NO;
    //默认开启系统右划返回
    self.isSystemSlidBack = YES;
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    
    //只有在使用转场动画时，禁用系统手势，开启自定义右划手势
    _popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    //下面是全屏返回
    //        _popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    _popRecognizer.edges = UIRectEdgeLeft;
    [_popRecognizer setEnabled:NO];
    [self.view addGestureRecognizer:_popRecognizer];
}

//解决手势失效问题
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (_isSystemSlidBack) {
        self.interactivePopGestureRecognizer.enabled = YES;
        [_popRecognizer setEnabled:NO];
    }else{
        self.interactivePopGestureRecognizer.enabled = NO;
        [_popRecognizer setEnabled:YES];
    }
}

//根视图禁用右划返回
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count == 1 ? NO : YES;
}

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"G_Back_0"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem.tintColor=[UIColor blackColor];


    }
    viewController.hidesBottomBarWhenPushed = YES;

    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    

    //这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
//    //解决iPhone X push页面时 tabBar上移的问题
//    CGRect frame = self.tabBarController.tabBar.frame;
//    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
//    self.tabBarController.tabBar.frame = frame;
}


-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
//    if ([viewController isKindOfClass:[UIViewController class]]) {
//        UIViewController * vc = (UIViewController *)viewController;
//
//            [vc.navigationController setNavigationBarHidden:NO animated:animated];
//    }
}

/**
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated
{
    id vc = [self getCurrentViewControllerClass:ClassName];
    if(vc != nil && [vc isKindOfClass:[UIViewController class]])
    {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    
    return NO;
}

/*!
 *  获得当前导航器显示的视图
 *
 *  @param ClassName 要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil;
 */
-(instancetype)getCurrentViewControllerClass:(NSString *)ClassName
{
    Class classObj = NSClassFromString(ClassName);
    
    NSArray * szArray =  self.viewControllers;
    for (id vc in szArray) {
        if([vc isMemberOfClass:classObj])
        {
            return vc;
        }
    }
    
    return nil;
}


-(void)back{
    [self popViewControllerAnimated:YES];
    
}

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
