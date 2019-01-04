//
//  YSTShopCarCell.m
//  ShopCarListDemo
//
//  Created by penglaizhi on 2018/6/12.
//  Copyright © 2018年 决心. All rights reserved.
//

#import "YSTShopCarCell.h"


@interface YSTShopCarCell ()<UITextFieldDelegate>
/*选择按钮*/
@property (nonatomic,strong) UIButton *buttonChoose;
/*商品图*/
@property (nonatomic,strong) UIButton *imageVIcon;
/**商品名**/
@property (nonatomic,strong) UILabel *labelTitle;
/**减按钮*/
@property (strong,nonatomic) UIButton *buttonMinus;
/*加按钮*/
@property (nonatomic,strong) UIButton *buttonAdd;
/**件数*/
@property (nonatomic,strong) UITextField *textField;
/*价格*/
@property (nonatomic,strong) UILabel *labelPrice;
/*底部的线*/
@property (nonatomic,strong) UIView *viewLine;
/*购物车加减号和数量view*/
@property (nonatomic,strong) UIView *viewDown;
/*传输商品信息*/
@property (nonatomic,strong) NSMutableDictionary *dicPram;

@end

@implementation YSTShopCarCell
-(NSMutableDictionary *)dicPram
{
    if (_dicPram==nil) {
        _dicPram = [NSMutableDictionary dictionary];
    }
    return _dicPram;
}
+(instancetype)cellWithtableViewForGoodsCarN:(UITableView *)tableview
{
    static NSString *ID = @"YSTShopCarCell";
    
    YSTShopCarCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[YSTShopCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell p_makeupViewForPLZCarView];
    }
    
    return cell;
    
}


-(void)p_makeupViewForPLZCarView
{
    self.buttonChoose = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.buttonChoose setImage:[UIImage imageNamed:@"购物车_未选中"] forState:(UIControlStateNormal)];
    //    [self.buttonChoose setImage:[UIImage imageNamed:@""] forState:(UIControlStateSelected)];
    //    self.buttonChoose.backgroundColor = [UIColor redColor];
    [self addSubview:self.buttonChoose];
    [self.buttonChoose addTarget:self action:@selector(buttonChooseInPLZCarViewAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.imageVIcon = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.imageVIcon.backgroundColor = [UIColor grayColor];
    [self addSubview:self.imageVIcon];
    [self.imageVIcon addTarget:self action:@selector(imageVIconActionInCarCell) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.text = @"There is no doubt that!";
    self.labelTitle.numberOfLines = 2;
    //    self.labelTitle = [PJ_CreatLabel creatLabelFont:13 color:@"222222" title:@"There is no doubt that!There is no doubt that!There is no doubt that!"];
    //    self.labelTitle.numberOfLines = 0;
    [self addSubview:self.labelTitle];
    
    self.labelPrice = [[UILabel alloc] init];
    self.labelPrice.text = @"￥：225";
    //    self.labelPrice = [PJ_CreatLabel creatLabelFont:10 color:@"222222" title:@"$225"];
    [self addSubview:self.labelPrice];
    
    self.viewDown = [[UIView alloc] init];
    [self addSubview:self.viewDown];
    UIView *viewLineDown1 = [[UIView alloc] init];
    UIView *viewLineDown2 = [[UIView alloc] init];
    viewLineDown1.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    viewLineDown2.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    [self.viewDown addSubview:viewLineDown1];
    [self.viewDown addSubview:viewLineDown2];
    self.viewDown.layer.masksToBounds = YES;
    self.viewDown.layer.cornerRadius = 2;
    self.viewDown.layer.borderColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1].CGColor;
    self.viewDown.layer.borderWidth = 1;
    
    
    self.buttonMinus = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    //    [self.buttonMinus setImage:[UIImage imageNamed:@"home_Reduction"] forState:(UIControlStateNormal)];
    self.buttonAdd = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    [self.buttonAdd setImage:[UIImage imageNamed:@"home_add"] forState:(UIControlStateNormal)];
    //    self.buttonAdd.backgroundColor = [UIColor purpleColor];
    //    self.buttonMinus.backgroundColor = [UIColor blackColor];
    [self.buttonAdd setTitle:@"+" forState:(UIControlStateNormal)];
    [self.buttonMinus setTitle:@"-" forState:(UIControlStateNormal)];
    self.buttonAdd.titleLabel.font = [UIFont systemFontOfSize:20];
    self.buttonMinus.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.buttonAdd setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] forState:(UIControlStateNormal)];
    [self.buttonMinus setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] forState:(UIControlStateNormal)];
    
    self.textField = [[UITextField alloc] init];
    //    self.textField.layer.masksToBounds = YES;
    //    self.textField.layer.cornerRadius = 2;
    
    //    self.textField.borderStyle = UITextBorderStyleLine;
    self.textField.textAlignment = NSTextAlignmentCenter;
    [self.viewDown addSubview:self.buttonAdd];
    [self.viewDown addSubview:self.buttonMinus];
    [self.viewDown addSubview:self.textField];
    
    [self.textField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.buttonMinus addTarget:self action:@selector(buttonMinusInPLZCarViewAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.buttonAdd addTarget:self action:@selector(buttonAddInPLZCarViewAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.delegate = self;
    self.viewLine = [[UIView alloc] init];
    [self addSubview:self.viewLine];
    self.viewLine.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.trailing.offset(0);
        make.height.mas_equalTo(1);
        make.leading.offset(10);
    }];
    
    [self.buttonChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(6*SCALE_WIDTH);
        make.width.height.mas_equalTo(25*SCALE_WIDTH);
        make.centerY.equalTo(self.imageVIcon);
        
    }];
    [self.imageVIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.buttonChoose.mas_trailing).offset(11*SCALE_WIDTH);
        make.top.offset(10*SCALE_WIDTH);
        make.width.height.mas_equalTo(70*SCALE_WIDTH);
        make.bottom.offset(-10);
        
    }];
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.imageVIcon.mas_trailing).offset(10);
        make.top.equalTo(self.imageVIcon.mas_top).offset(10);
        //        make.trailing.equalTo(self.labelPrice.mas_leading).offset(-10);
        make.trailing.offset(-20);
    }];
    [self.viewDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.offset(-20);
        make.top.equalTo(self.labelTitle.mas_bottom).offset(3);
        make.width.mas_equalTo(42*SCALE_WIDTH+32);
        make.height.mas_equalTo(21*SCALE_WIDTH);
//        make.bottom.offset(-10);
    }];
    [self.buttonAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(21*SCALE_WIDTH);
        make.bottom.top.trailing.offset(0);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.bottom.equalTo(self.buttonAdd);
        make.trailing.equalTo(self.buttonAdd.mas_leading).offset(-1);
        make.width.mas_equalTo(30);
    }];
    [self.buttonMinus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.equalTo(self.buttonAdd);
        make.trailing.equalTo(self.textField.mas_leading).offset(-1);
    }];
    [viewLineDown1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.buttonAdd.mas_leading);
        make.top.bottom.offset(0);
        make.width.mas_equalTo(1);
    }];
    [viewLineDown2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.textField.mas_leading);
        make.top.bottom.offset(0);
        make.width.mas_equalTo(1);
    }];
    
    //    [self.buttonAdd mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.width.height.mas_equalTo(21*SCALE_WIDTH);
    //        make.trailing.offset(-12*SCALE_WIDTH);
    //        make.top.equalTo(self.labelTitle.mas_bottom).offset(10);
    //    }];
    //
    //    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.height.bottom.equalTo(self.buttonAdd);
    //        make.trailing.equalTo(self.buttonAdd.mas_leading);
    //        make.width.mas_equalTo(30);
    //    }];
    //    [self.buttonMinus mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.width.height.bottom.equalTo(self.buttonAdd);
    //        make.trailing.equalTo(self.textField.mas_leading);
    //    }];
    [self.labelPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.trailing.offset(-11*SCALE_WIDTH);
        make.leading.equalTo(self.imageVIcon.mas_trailing).offset(10);
        make.trailing.equalTo(self.buttonMinus.mas_leading).offset(10);
        make.top.equalTo(self.buttonAdd.mas_top);
    }];
    //    if (self.labelTitle.mas_bottom<self.buttonAdd.mas_bottom) {
    //        [self.labelTitle mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.bottom.offset(-10);
    //
    //        }];
    //
    //    }else{
    //        [self.labelTitle mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.bottom.equalTo(self.buttonAdd.mas_bottom);
    //
    //        }];
    //
    //
    //    }
    
}
#pragma mark - 某个商品是否选中
-(void)buttonChooseInPLZCarViewAction
{
    
    if (self.childM.isSelect) {
//        self.buttonChoose.selected = NO;
        //        self.buttonChoose.backgroundColor = [UIColor redColor];
        [self.buttonChoose setImage:[UIImage imageNamed:@"购物车_未选中"] forState:(UIControlStateNormal)];
        self.childM.isSelect = NO;
        NSLog(@"取消选中");
    }else{
//        self.buttonChoose.selected = YES;
        //        self.buttonChoose.backgroundColor = [UIColor greenColor];
        NSLog(@"选中");
        [self.buttonChoose setImage:[UIImage imageNamed:@"购物车_选中"] forState:(UIControlStateNormal)];
        self.childM.isSelect = YES;
    }
    self.dicPram = [self.childM mj_keyValues];
    self.dicPram[@"type"] = @"2";//1代表商户，2代表具体商品
    self.dicPram[@"select"] = @"1";//1代表是选不选中，2代表是进行加运算,3进行减运算，4进行输入运算
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseGoodCarWithIndex" object:nil userInfo:self.dicPram];
    
}
#pragma mark - 点击加号和减号
-(void)buttonMinusInPLZCarViewAction
{
    NSLog(@"点击了减号");
    
    if ([self.textField.text integerValue]<2) {
        NSLog(@"不能再减少了");
        return;
    }else{
        NSInteger newCount = [self.textField.text integerValue]-1;
        self.textField.text = [NSString stringWithFormat:@"%ld",newCount];
        
    }
    self.childM.count = self.textField.text;
    self.dicPram = [self.childM mj_keyValues];
    self.dicPram[@"type"] = @"2";//1代表商户，2代表具体商品
    self.dicPram[@"select"] = @"3";//1代表是选不选中，2代表是进行加运算,3进行减运算，4进行输入运算

    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseGoodCarWithIndex" object:nil userInfo:self.dicPram];
    
}
-(void)buttonAddInPLZCarViewAction
{
    NSLog(@"点击了jia号");
    
    if ([self.textField.text integerValue]==99) {
        NSLog(@"不能更多了");
        return;

    }else{
        NSInteger newCount = [self.textField.text integerValue]+1;
        self.textField.text = [NSString stringWithFormat:@"%ld",newCount];
        
    }
    self.childM.count = self.textField.text;
    self.dicPram = [self.childM mj_keyValues];
    self.dicPram[@"type"] = @"2";//1代表商户，2代表具体商品
    self.dicPram[@"select"] = @"2";//1代表是选不选中，2代表是进行加运算,3进行减运算，4进行输入运算

    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseGoodCarWithIndex" object:nil userInfo:self.dicPram];
    
}
-(void)textFieldDidChange
{
    if (self.textField.text.length>2) {
        self.textField.text = [self.textField.text substringToIndex:2];
    }
    CGFloat priceT = [_childM.price doubleValue]*[_childM.count integerValue];
    CGFloat priceT2 = [_childM.price doubleValue]*[self.textField.text integerValue];
    
    self.childM.count = self.textField.text;
    //新的价格
    CGFloat priceT3 = priceT2-priceT;
    self.dicPram = [self.childM mj_keyValues];
    self.dicPram[@"priceT3"] = [NSString stringWithFormat:@"%.2f",priceT3];//1代表商户，2代表具体商品
    self.dicPram[@"select"] = @"4";//1代表是选不选中，2代表是进行加运算,3进行减运算，4进行输入运算

    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseGoodCarWithIndex" object:nil userInfo:self.dicPram];
    
}

-(void)setChildM:(ShopChild *)childM
{
    _childM = childM;
    self.labelTitle.text = childM.shopName;
    self.textField.text = childM.count;
    self.labelPrice.text = [NSString stringWithFormat:@"￥：%@",childM.price];
    if (childM.isSelect) {
        [self.buttonChoose setImage:[UIImage imageNamed:@"购物车_选中"] forState:(UIControlStateNormal)];
    }else{
        [self.buttonChoose setImage:[UIImage imageNamed:@"购物车_未选中"] forState:(UIControlStateNormal)];
        
    }
}
#pragma mark - 输入框结束编辑---如果输入框是空或者0就置为1
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length<1||[textField.text isEqualToString:@"0"]||[textField.text isEqualToString:@"00"]) {
        textField.text = @"1";
        [self textFieldDidChange];
    }
}
#pragma mark - 点击商品图
-(void)imageVIconActionInCarCell
{
    self.dicPram = [self.childM mj_keyValues];
    self.dicPram[@"typeNew"] = @"1";//1代表是点击商品图，2跳转店铺
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"needPushINshopCarList" object:nil userInfo:self.dicPram];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
