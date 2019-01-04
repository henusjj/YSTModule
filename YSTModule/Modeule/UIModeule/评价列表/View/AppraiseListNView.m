//
//  AppraiseListNView.m
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/19.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "AppraiseListNView.h"

#import "AppraiseListTableView.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例
@interface AppraiseListNView ()
/*顶部view*/
@property (nonatomic,strong) UIView *viewTop;
/*顶部view的button（父）*/
@property (nonatomic,strong) UIView *viewTopButton;


/*盛放两个评价*/
@property (nonatomic,strong) UIScrollView *scrollV;



@end

@implementation AppraiseListNView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_makeupViewInAppraiseListNView];
    }
    return self;
}
-(void)p_makeupViewInAppraiseListNView
{
    self.viewTop = [[UIView alloc] init];
    self.viewTop.backgroundColor = [UIColor redColor];
    
    self.buttonBack = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.buttonBack setImage:[UIImage imageNamed:@"returnWhite"] forState:(UIControlStateNormal)];
    
    self.viewTopButton = [[UIView alloc] init];
    self.viewTopButton.layer.masksToBounds = YES;
    self.viewTopButton.layer.cornerRadius = 12;
    self.viewTopButton.layer.borderWidth = 1;
    self.viewTopButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    
    NSArray *arrTitle = @[@"服务评价",@"商品评价"];
    for (int i=0; i<arrTitle.count; i++) {
        UIButton *buttonTitle = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.viewTopButton addSubview:buttonTitle];
        buttonTitle.titleLabel.font = [UIFont systemFontOfSize:13];
        [buttonTitle setTitle:arrTitle[i] forState:(UIControlStateNormal)];
        if (i==0) {
            [buttonTitle setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
            buttonTitle.backgroundColor = [UIColor whiteColor];
            
        }else{
            [buttonTitle setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            buttonTitle.backgroundColor = nil;
            
            
        }
        buttonTitle.tag = 160+i;
        [buttonTitle addTarget:self action:@selector(buttonTitleActionInAppraiseListNView:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [buttonTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.offset(0);
            make.width.mas_equalTo((kScreenWidth-208*SCALE_WIDTH)/2);
            make.leading.mas_equalTo((kScreenWidth-208*SCALE_WIDTH)/2*i);
        }];
        
    }
    
    
    [self addSubview:self.viewTop];
    [self.viewTop addSubview:self.viewTopButton];
    [self.viewTop addSubview:self.buttonBack];
    
    [self.viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.offset(0);
        make.height.mas_equalTo(kNavHeight);
    }];
    [self.viewTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kNavHeight-34);
        make.bottom.offset(-10);
        make.leading.offset(104*SCALE_WIDTH);
        make.trailing.offset(-104*SCALE_WIDTH);
    }];
    [self.buttonBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(5);
        make.top.offset(kNavHeight-40);
        make.width.height.mas_equalTo(30);
    }];
    
    
    self.scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavHeight, kScreenWidth, kScreenHeight-kNavHeight)];
    self.scrollV.contentSize = CGSizeMake(kScreenWidth*2, 1);
    self.scrollV.pagingEnabled = YES;
    self.scrollV.scrollEnabled = NO;
    
    //    self.backgroundColor = [UIColor redColor];
    [self addSubview:self.scrollV];
    for (int i = 0; i<2; i++) {
        AppraiseListTableView *viewList = [[AppraiseListTableView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight-kNavHeight)];
        viewList.type = i+1;
        viewList.tag = 220+i;
        
        [self.scrollV addSubview:viewList];
    }
    
    
}
#pragma mark - 点击标题的事件
-(void)buttonTitleActionInAppraiseListNView:(UIButton *)sender
{
    for (int i = 160; i<162; i++) {
        UIButton *buttonTitle = (UIButton *)[self viewWithTag:i];
        [buttonTitle setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        buttonTitle.backgroundColor = nil;
        
    }
    [sender setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    sender.backgroundColor = [UIColor whiteColor];
    
    
    switch (sender.tag) {
        case 160:
        {
            NSLog(@"点击了服务评价");
            self.scrollV.contentOffset = CGPointMake(0, 0);
            AppraiseListTableView *listTableV = (AppraiseListTableView *)[self viewWithTag:220];
            if (listTableV.arrAppraiseList.count<1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AppraiseTypeForList" object:@"1"];
            }
            //            self.appraiseBlock(0);
        }
            break;
            
        case 161:
        {
            NSLog(@"点击了商品评价");
            self.scrollV.contentOffset = CGPointMake(kScreenWidth, 0);
            //            self.appraiseBlock(1);
            AppraiseListTableView *listTableV = (AppraiseListTableView *)[self viewWithTag:221];
            if (listTableV.arrAppraiseList.count<1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AppraiseTypeForList" object:@"5"];
            }
            
        }
            break;
            
        default:
            break;
    }
}
-(void)setArrGoods:(NSArray *)arrGoods
{
    _arrGoods = arrGoods;
    AppraiseListTableView *listTableV = (AppraiseListTableView *)[self viewWithTag:221];
    listTableV.appraiseM = self.appraiseM;
    
    listTableV.arrAppraiseList = arrGoods;
}
-(void)setArrServe:(NSArray *)arrServe
{
    _arrServe = arrServe;
    AppraiseListTableView *listTableV = (AppraiseListTableView *)[self viewWithTag:220];
    listTableV.appraiseM = self.appraiseM;
    listTableV.arrAppraiseList = arrServe;
}

@end
