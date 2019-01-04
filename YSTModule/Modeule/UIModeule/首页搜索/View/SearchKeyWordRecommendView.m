//
//  SearchKeyWordRecommendView.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "SearchKeyWordRecommendView.h"
#import "TagView.h"

@interface SearchKeyWordRecommendView ()

@property (nonatomic,strong)TagView * tagHistory;
@property (nonatomic,strong)TagView * tagHot;
@end

@implementation SearchKeyWordRecommendView
-(instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)]) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat setY = 10;
    CGFloat leftSpace = 10;
    
    
    UIView * viewHistory = [[UIView alloc]initWithFrame:CGRectMake(leftSpace, setY, kScreenWidth-leftSpace*2, 30)];
    [self addSubview:viewHistory];
    setY = viewHistory.bottom + 10;
    
    
    {//
        UIButton * btnHistory = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        btnHistory.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        btnHistory.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnHistory setImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
        [btnHistory setTitle:@"  搜索历史" forState:UIControlStateNormal];
        [btnHistory setTitleColor:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:0.8] forState:UIControlStateNormal];
        [viewHistory addSubview:btnHistory];
        
        
        
        UIButton * btnClear = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
        btnClear.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        btnClear.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnClear setTitle:@"清除" forState:UIControlStateNormal];
        [btnClear setTitleColor:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:0.8] forState:UIControlStateNormal];
        [viewHistory addSubview:btnClear];
        btnClear.right = viewHistory.width-10;
        [btnClear addTarget:self action:@selector(btnClear) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
    TagView * tagHistory = [[TagView alloc]initWithFrame:CGRectMake(leftSpace, setY, kScreenWidth-leftSpace*2, 30)];
    __block typeof(tagHistory) weakHistory = tagHistory;
    
    [self addSubview:tagHistory];
    tagHistory.tags = [self getHistory];
    setY = tagHistory.bottom + 10;
    _tagHistory = tagHistory;
    tagHistory.clickCall = ^(NSUInteger index) {
        [self searchWith:weakHistory.tags[index]];
    };
    
    
    
    UIButton * btnHot = [[UIButton alloc]initWithFrame:CGRectMake(leftSpace, setY, kScreenWidth-leftSpace*2, 30)];
    btnHot.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    btnHot.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnHot setImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
    [btnHot setTitle:@"  热门搜索" forState:UIControlStateNormal];
    [btnHot setTitleColor:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:0.8] forState:UIControlStateNormal];
    [self addSubview:btnHot];
    setY = btnHot.bottom + 10;
    
    
    TagView * tagHot = [[TagView alloc]initWithFrame:CGRectMake(leftSpace, setY, kScreenWidth-leftSpace*2, 30)];
    __block typeof(tagHot) weakTagHot = tagHot;
    [self addSubview:tagHot];
    setY = tagHot.bottom + 10;
    tagHot.clickCall = ^(NSUInteger index) {
        [self searchWith:weakTagHot.tags[index]];
    };
    _tagHot = tagHot;
    
    
    [self layout];
}
-(void)layout{
    CGFloat setY = 10;
    for (UIView * view in self.subviews) {
        view.top = setY;
        setY = view.bottom;
    }
}


-(void)refresUI{
    _tagHistory.tags = [self getHistory];
    [self layout];
}
#pragma mark -- 点击事件
-(void)btnClear{
    [self clearHistory];
    
}
-(void)searchWith:(NSString *)keyWord{
    self.hidden = YES;
    
    if (_searchCall) {
        _searchCall(keyWord);
    }
}


-(void)addKeyWord:(NSString *)keyWord{
    NSMutableArray * searchHistory =  [NSMutableArray arrayWithArray:[self getHistory]];
    
    if (!keyWord || [self isEmptyString:keyWord]) {
        return;
    }
    
    if ([searchHistory containsObject:keyWord]) {
        [searchHistory removeObject:keyWord];
    }
    [searchHistory addObject:keyWord];
    
    if (searchHistory.count > 10) {
        [searchHistory removeObjectAtIndex:0];
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:searchHistory forKey:@"searchHistoryKey"];
    
    
    [self refresUI];
}
-(NSMutableArray *)getHistory{
    NSMutableArray * searchHistory = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchHistoryKey"];
    if (!searchHistory) {
        searchHistory = [NSMutableArray array];
    }
    return searchHistory;
}
-(void)clearHistory{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"searchHistoryKey"];
    [self refresUI];
}
- (BOOL)isEmptyString:(NSString *)string
{
    return (!self || string.length <1  || [string isEqualToString:@"(null)"] || [string isEqualToString:@"<null>"] || [string isEqualToString:@"null"]);
}

-(void)getHotKey{
    
    
    
    
}
@end
