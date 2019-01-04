//
//  Yist_Module_WkWebViewController.m
//  YSTModule
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "Yist_Module_WkWebViewController.h"
#import <WebKit/WebKit.h>
#define progressBarHeight 3

@interface Yist_Module_WkWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong)   WKWebView *wkWeb;

@property (nonatomic, strong)   UIProgressView *mProgressView;//进度条

@end

@implementation Yist_Module_WkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Web";
    UIButton *buttonVack = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [buttonVack setTitle:@"back" forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonVack];
    [buttonVack addTarget:self action:@selector(buttonBackN) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.wkWeb];
    [self.view addSubview:self.mProgressView];
    [self.wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
}

-(void)buttonBackN{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//增加kvo监听，获得页面title和加载进度值
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.wkWeb addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.wkWeb addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}

-(WKWebView *)wkWeb{
    if (!_wkWeb) {
        _wkWeb = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height)];
        _wkWeb.UIDelegate = self;
        _wkWeb.navigationDelegate = self;
    }
    return _wkWeb;
}

-(UIProgressView *)mProgressView{
    if (!_mProgressView) {
        
        CGRect barFrame = CGRectMake(0,kNavHeight, SCREEN_WIDTH, progressBarHeight);
        _mProgressView = [[UIProgressView alloc] initWithFrame:barFrame];
        _mProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _mProgressView.progressTintColor = [UIColor greenColor];
    }
    return _mProgressView;
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
//    [HudHelp showLoadView:@"加载中" andView:self.bgView];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    [HudHelp hideLoading:self.bgView];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
//    [HudHelp hideLoading:self.bgView];
//    [HudHelp showErrorWithMessage:@"加载失败" sencInt:HUD_SHOWTIME];
}

#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"]){
        if (object == self.wkWeb){
            self.mProgressView.alpha = 1;
            [self.mProgressView setProgress:self.wkWeb.estimatedProgress animated:YES];
            if(self.wkWeb.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    self.mProgressView.alpha = 0;
                } completion:^(BOOL finished) {
                    [self.mProgressView setProgress:0.0f animated:NO];
                }];
            }
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:@"title"]){//网页title
        if (object == self.wkWeb){
            self.title = self.wkWeb.title;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


//KVO 一定要移除，要不然会崩溃
- (void)dealloc{
    [self.wkWeb removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWeb removeObserver:self forKeyPath:@"title"];
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
