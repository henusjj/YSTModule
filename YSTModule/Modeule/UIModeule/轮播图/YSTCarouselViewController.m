//
//  YSTCarouselViewController.m
//  YSTModule
//
//  Created by YSTQZY on 2018/6/14.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "YSTCarouselViewController.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "TYCyclePagerViewCell.h"

@interface YSTCarouselViewController ()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation YSTCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"轮播图";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addPagerView];
    [self addPageControl];
    
    [self loadData];
    
//    UIButton *buttonVack = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    [buttonVack setTitle:@"back" forState:(UIControlStateNormal)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonVack];
//    [buttonVack addTarget:self action:@selector(buttonBackN) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)buttonBackN
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
    pagerView.layer.borderWidth = 1;
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    // registerClass or registerNib
    [self.view addSubview:pagerView];
    _pagerView = pagerView;
}

- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
    pageControl.pageIndicatorSize = CGSizeMake(12, 6);
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pagerView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200);
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
}

- (void)loadData {
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i < 7; ++i) {
        if (i == 0) {
            [datas addObject:[UIColor redColor]];
            continue;
        }
        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
    }
    _datas = [datas copy];
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
    //[_pagerView scrollToItemAtIndex:3 animate:YES];
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame)*0.8, CGRectGetHeight(pageView.frame)*0.8);
    layout.itemSpacing = 15;
    //layout.minimumAlpha = 0.3;
    return layout;
}

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.backgroundColor = _datas[index];
    cell.label.textColor = [UIColor blackColor];
    cell.label.text = [NSString stringWithFormat:@"%ld",index];
    return cell;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
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
