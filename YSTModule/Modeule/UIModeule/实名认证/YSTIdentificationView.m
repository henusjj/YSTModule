//
//  YSTIdentificationView.m
//  YSTViewsDemo
//
//  Created by penglaizhi on 2018/6/7.
//  Copyright © 2018年 决心. All rights reserved.
//

#import "YSTIdentificationView.h"
#import "IdentificttionCell.h"
#import "YSTButtonCode.h"

@interface YSTIdentificationView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
/*提示语*/
@property (nonatomic,strong) UILabel *labelRemind;
/*确认提交*/
@property (nonatomic,strong) UIButton *buttonOK;

@property (nonatomic,strong) NSMutableDictionary *dic;
/*验证码指向cell验证码按钮*/
@property (nonatomic,strong)YSTButtonCode *buttonCode;
@end
#define cellHeight 44
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define kNavHeight ([[UIApplication sharedApplication] statusBarFrame].size.height + 44)


@implementation YSTIdentificationView
-(NSMutableDictionary *)dic
{
    if (_dic == nil) {
        _dic = [NSMutableDictionary dictionary];
        _dic[@"phone"] = self.strPhone;
    }
    return _dic;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_makeupViewForYSTIdentificationView];
    }
    return self;
}

-(void)p_makeupViewForYSTIdentificationView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingInViewAction)];
    [self addGestureRecognizer:tap];
    
    self.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, cellHeight*4+20) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self addSubview:self.tableView];

    self.labelRemind = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.tableView.frame), kScreenWidth-30, 40)];
    self.labelRemind.numberOfLines = 0;
    self.labelRemind.text = @"提示：请认真填写身份信息，该信息将作为您提现的重要认证";
    self.labelRemind.textColor = [UIColor greenColor];
    self.labelRemind.font = [UIFont systemFontOfSize:12];
    
    self.buttonOK = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.buttonOK setTitle:@"提交信息" forState:(UIControlStateNormal)];
    [self.buttonOK setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.buttonOK.layer.masksToBounds = YES;
    self.buttonOK.layer.cornerRadius = 4;
    self.buttonOK.backgroundColor = [UIColor redColor];
    self.buttonOK.frame = CGRectMake(15, CGRectGetMaxY(self.labelRemind.frame)+50, kScreenWidth-30, 44);
    [self.buttonOK addTarget:self action:@selector(buttonOKActionInYSTIdentificationView) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self addSubview:self.labelRemind];
    [self addSubview:self.buttonOK];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) weakself = self;
    //这里第一个cell必须是手机号，最后一个cell必须是验证码，其他不限内容，不限行数
    if (indexPath.row==self.arrTitle.count-2&&indexPath.section==1) {
        IdentificttionCell *cell = [IdentificttionCell cellWithtableViewForLabelAndFieldAndCode:tableView];
        NSString *strTitle = [self.arrTitle lastObject];
        cell.labelTitle.text = strTitle;
        self.buttonCode = cell.buttonCode;
        cell.textField.placeholder = [self.arrPlaceholder lastObject];
        [cell.buttonCode addTarget:self action:@selector(buttonCodeActionInYSTIdentificationView) forControlEvents:(UIControlEventTouchUpInside)];
        cell.fieldBlock = ^(NSString *text) {
            weakself.dic[strTitle] = text;
        };
        cell.countNum = [self.arrCountNum lastObject];
        return cell;
    }
    
    IdentificttionCell *cell = [IdentificttionCell cellWithtableViewForLabelAndTextField:tableView];
    NSString *strTitle = @"";
    
    if (indexPath.section==0) {
        strTitle = [self.arrTitle firstObject];
        cell.labelTitle.text = strTitle;
        cell.textField.placeholder = [self.arrPlaceholder firstObject];
        cell.textField.text = self.strPhone;
        cell.textField.userInteractionEnabled = NO;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.countNum = [self.arrCountNum firstObject];
    }else{
        strTitle = self.arrTitle[indexPath.row+1];
        cell.labelTitle.text = strTitle;
        cell.textField.placeholder = self.arrPlaceholder[indexPath.row+1];
        cell.countNum = self.arrCountNum[indexPath.row+1];
        cell.fieldBlock = ^(NSString *text) {
            weakself.dic[strTitle] = text;
        };
    }
    cell.fieldBlock = ^(NSString *text) {
        weakself.dic[strTitle] = text;
    };
    
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return self.arrTitle.count-1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(void)setArrTitle:(NSArray *)arrTitle
{
    _arrTitle = arrTitle;
    [self.tableView reloadData];
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, cellHeight*arrTitle.count+20);
    self.labelRemind.frame = CGRectMake(15, CGRectGetMaxY(self.tableView.frame), kScreenWidth-30, 40);
    self.buttonOK.frame = CGRectMake(15, CGRectGetMaxY(self.labelRemind.frame)+50, kScreenWidth-30, 44);

}
-(void)setArrCountNum:(NSArray *)arrCountNum
{
    _arrCountNum = arrCountNum;
    [self.tableView reloadData];
    //    self
}
-(void)setArrPlaceholder:(NSArray *)arrPlaceholder
{
    _arrPlaceholder = arrPlaceholder;
    [self.tableView reloadData];
}
#pragma mark - 点击提交信息
-(void)buttonOKActionInYSTIdentificationView
{
    [self endEditing:YES];
    NSString *strID = self.dic[@"身份证"];
    NSString *strCode = self.dic[@"验证码"];
    if (strID.length<16) {//限制16位以上，可以减少非正常数据调用接口，以节省开支
        NSLog(@"身份证号不得低于16位");
        return;
    }else if(strCode.length<4){//限制16位以上，可以减少非正常数据调用接口，以节省开支
        NSLog(@"验证码不得低于4位");

    }else{
        self.okBlock(self.dic);
    }
}
#pragma mark - 点击发送验证码
-(void)buttonCodeActionInYSTIdentificationView
{
    
    [self endEditing:YES];
    //设置点击后变的颜色（前），读秒结束变的颜色（后），读秒共计时长
    [self.buttonCode TheGetCodeDown:[UIColor redColor] withSecondColor:[UIColor grayColor] WithSeconds:60];

    self.codeBlock(self.dic);
    
}
-(void)endEditingInViewAction
{
    [self endEditing:YES];
}
#pragma mark - 非必传set方法
-(void)setFontRemind:(UIFont *)fontRemind
{
    _fontRemind = fontRemind;
    self.labelRemind.font = fontRemind;
}
-(void)setColorRemind:(UIColor *)colorRemind
{
    _colorRemind = colorRemind;
    self.labelRemind.textColor = colorRemind;
    
}
-(void)setImageButton:(UIImage *)imageButton
{
    _imageButton = imageButton;
    [self.buttonOK setBackgroundImage:imageButton forState:(UIControlStateNormal)];
}
@end
