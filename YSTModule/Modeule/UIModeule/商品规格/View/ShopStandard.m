//
//  ShopStandard.m
//  YSTModule
//
//  Created by 节庆霞 on 2018/7/6.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "ShopStandard.h"
#import "StandardKind.h"//规格样式
#import "TPKeyboardAvoidingScrollView.h"//滑动试图
#import "NSString+Hex.h"//计算文字宽高
#define Font(size) [UIFont systemFontOfSize:SCREEN_WIDTH/375 * size]
// ---->比例宽
#define SCALE__WIDTH(w)  SCREEN_WIDTH/375 * w

@interface ShopStandard ()<standButtonDelegete,UITextFieldDelegate>
@property (nonatomic,strong)UIView *shopView;//规格大View
@property (nonatomic,strong)UIImageView *shopImage;//商品图片
@property (nonatomic,strong)UILabel *moneyLabel;//商品价格
@property (nonatomic,strong)UILabel *kuCunLabel;//库存
@property (nonatomic,strong)UILabel *selectedLabel;//选择了什么
@property (nonatomic,strong)UITextField *numField;//商品数量
@property (nonatomic) NSInteger numCount;//商品数量

@property (nonatomic,strong)NSMutableDictionary *selectedDic;//选择的
@property (nonatomic,strong)NSMutableDictionary *endDic;//最终的数据
@property (nonatomic,strong)NSMutableDictionary *mainDic;//数据源

@end
@implementation ShopStandard

- (instancetype)initWithFrame:(CGRect)frame productId:(NSString *)productid
{
    if([super initWithFrame:frame]){
        [self setStandardData:productid];
    }
    return self;
}

#pragma mark - 规格数据请求
- (void)setStandardData:(NSString *)productid
{
    
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Stantard" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    NSDictionary * dic= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    self.mainDic = dic[@"content"];
    [self setUI];
    
    //设置默认规格
    NSArray *specArray = self.mainDic[@"spec"];
    if(specArray.count == 1){
        NSDictionary *specDic = specArray[0];
        NSArray *subspecArray = specDic[@"subspec"];
        
        [self.selectedDic setObject:subspecArray[0] forKey:@"10000"];
        
        
    }else if (specArray.count == 2){
        
        NSArray *subspecArray = specArray[0][@"subspec"];
        NSArray *subspecArray1 = specArray[1][@"subspec"];
        [self.selectedDic setObject:subspecArray[0] forKey:@"10000"];
        [self.selectedDic setObject:subspecArray1[0] forKey:@"10001"];
        
    }
    
    [self KindMessage:self.selectedDic];
    
}


#pragma mark - 布局
- (void)setUI{
    
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
    
    //商品背景白色View
    self.shopView = [[UIView alloc]initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH, SCREEN_HEIGHT - 180)];
    self.shopView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.shopView];
    
    //加入购物车按钮
    UIButton *shopBtn = [self creatButton:CGRectMake(0, self.shopView.height - SCALE__WIDTH(50),SCREEN_WIDTH/2 , SCALE__WIDTH(50)) backColor:[UIColor orangeColor] text:@"加入购物车" textColor:[UIColor whiteColor] font:Font(17) addTarget:self Action:@selector(shoppingAction:)];
    shopBtn.tag = 100;
    [self.shopView addSubview:shopBtn];
    //立即购买按钮
    UIButton *nowBuyBtn = [self creatButton:CGRectMake(SCREEN_WIDTH/2, self.shopView.height - SCALE__WIDTH(50),SCREEN_WIDTH/2 , SCALE__WIDTH(50)) backColor:[UIColor redColor] text:@"立即购买" textColor:[UIColor whiteColor] font:Font(17) addTarget:self Action:@selector(shoppingAction:)];
    nowBuyBtn.tag = 101;
    [self.shopView addSubview:nowBuyBtn];
    
    //商品图片
    self.shopImage = [[UIImageView alloc]initWithFrame:CGRectMake(10,-20, 100, 100)];
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.mainDic[@"imageUrl"]]]];
    self.shopImage.layer.masksToBounds = YES;
    self.shopImage.layer.cornerRadius = 5.0;
    [self.shopView addSubview:self.shopImage];
    
    //价格
    NSString *moneyStr = [NSString stringWithFormat:@"¥%.2f",[self.mainDic[@"maxPrice"] floatValue]];
    
    if([self.mainDic[@"minPrice"]floatValue] != [self.mainDic[@"maxPrice"] floatValue]){
        moneyStr = [NSString stringWithFormat:@"¥%.2f-%.2f",[self.mainDic[@"minPrice"] floatValue],[self.mainDic[@"maxPrice"] floatValue]];
    }
    
    self.moneyLabel = [self creatLabel:CGRectMake(self.shopImage.right+10, 10, self.shopView.width - 100 - 30, 20) backColor:[UIColor clearColor] text:moneyStr textColor:[UIColor redColor] font:Font(16) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [self.shopView addSubview:self.moneyLabel];
    
    //库存
    self.kuCunLabel = [self creatLabel:CGRectMake(self.shopImage.right+10, self.moneyLabel.bottom + 10, self.shopView.width - 100 - 30, 20) backColor:[UIColor clearColor] text:[NSString stringWithFormat:@"库存：%@",self.mainDic[@"defaultNum"]] textColor:[UIColor blackColor] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [self.shopView addSubview:self.kuCunLabel];
    //设置库存数量
    self.numCount = [self.mainDic[@"defaultNum"] integerValue];
    
    
    //选择
    self.selectedLabel = [self creatLabel:CGRectMake(self.shopImage.right+10, self.kuCunLabel.bottom + 10, self.shopView.width - 100 - 30, 20) backColor:[UIColor clearColor] text:@"请选择规格" textColor:[UIColor blackColor] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [self.shopView addSubview:self.selectedLabel];
    
    
    //内容
    TPKeyboardAvoidingScrollView *scrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, self.shopImage.bottom + 20, self.shopView.width, self.shopView.height - SCALE__WIDTH(50) - self.shopImage.bottom - 20)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.shopView addSubview:scrollView];
    
    //计算view有多高
    CGFloat viewH = 10;
    NSArray *specArray = self.mainDic[@"spec"];
    for (int i = 0; i < specArray.count; i ++) {
        NSDictionary *dic = [specArray objectAtIndex:i];
        NSArray *mainArray = dic[@"subspec"];
        
        
        CGFloat x = 0;
        CGFloat y = 35;
        CGFloat space = 15;
        
        
        for (NSInteger j = 0; j < mainArray.count; j++) {
            NSDictionary *dic1 = [mainArray objectAtIndex:j];
            NSString *nameStr = [NSString stringWithFormat:@"%@",dic1[@"name"]];
            CGFloat itemW = [nameStr CallatelabelSizeWidth:[UIFont systemFontOfSize:12] lineHeight:30];
            
            x = x + itemW+ 15 + space;
            
            
            if(j < mainArray.count - 1){
                NSDictionary *dic2 = [mainArray objectAtIndex:j + 1];
                NSString *nameStr1 = [NSString stringWithFormat:@"%@",dic2[@"name"]];
                
                CGFloat itemW1 = [nameStr1 CallatelabelSizeWidth:[UIFont systemFontOfSize:12] lineHeight:30];
                if(x + (itemW1 + 15) >SCREEN_WIDTH - 20){
                    x = 0;
                    y += 40;
                }
                
            }
            
        }
        
        StandardKind *standView = [[StandardKind alloc]initWithFrame:CGRectMake(0, viewH, SCREEN_WIDTH, y + 40) contentDic:specArray[i]];
        standView.tag = 10000 + i;
        standView.delegte = self;
        [scrollView addSubview:standView];
        
        viewH += y + 40;
    }
    
    //购买数量
    UILabel *numLabel = [self creatLabel:CGRectMake(10,viewH + 30, 100, 25) backColor:[UIColor clearColor] text:@"购买数量" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft numOnLines:1];
    
    [scrollView addSubview:numLabel];
    
    UIButton *addBtn = [self creatButton:CGRectMake(SCREEN_WIDTH - 20 - 26, viewH + 40, 30, 30) backColor:[UIColor clearColor] text:@"+" textColor:[UIColor blackColor] font:Font(17) addTarget:self Action:@selector(addBtnAction)];
    addBtn.layer.masksToBounds = YES;
    addBtn.layer.borderWidth = .5;
    [scrollView addSubview:addBtn];
    
    self.numField = [self creatTextFiled:CGRectMake(addBtn.left - 49, addBtn.top, 50, 30) placeholder:@"" Font:Font(17) NSTextAlignment:NSTextAlignmentCenter];
    self.numField.backgroundColor = [UIColor whiteColor];
    self.numField.text = @"1";
    self.numField.layer.masksToBounds = YES;
    self.numField.layer.borderWidth = .5;
    self.numField.keyboardType = UIKeyboardTypeNumberPad;
    self.numField.delegate = self;
    [self.numField addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [scrollView addSubview:self.numField];
    
    UIButton *clubBtn = [self creatButton:CGRectMake(self.numField.left -29, addBtn.top, 30, 30) backColor:[UIColor whiteColor] text:@"-" textColor:[UIColor blackColor] font:Font(17) addTarget:self Action:@selector(clubBtnAction)];
    clubBtn.layer.masksToBounds = YES;
    clubBtn.layer.borderWidth = .5;
    [scrollView addSubview:clubBtn];
    
    UIButton *closeBtn_ = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 15, 25, 25)];
    [closeBtn_ setImage:[UIImage imageNamed:@"alertClose"] forState:UIControlStateNormal];
    [closeBtn_ addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shopView addSubview:closeBtn_];
    
}

#pragma mark -选择的信息
- (void)selectedInfoView:(NSInteger)viewtag selectedButtonMessage:(NSDictionary *)dic
{
    //    NSLog(@"选择的是第%ld栏的规格 -----------选择的规格信息%@",viewtag,dic);
    [self.selectedDic setObject:dic forKey:[NSString stringWithFormat:@"%ld",viewtag]];
    NSLog(@"选择的规格=====%@",self.selectedDic);
    
    [self KindMessage:self.selectedDic];
}


#pragma mark - 处理上半部分信息展示
- (void)KindMessage:(NSMutableDictionary *)dic
{
    NSString *selectedStr = @"";
    //有几种规格
    NSArray *specArray = self.mainDic[@"spec"];
    if(specArray.count == 1){
        if([[dic allKeys] containsObject:@"10000"]){
            
            selectedStr = [NSString stringWithFormat:@"%@",dic[@"10000"][@"id"]];
        }else{
            return;
        }
        
    }else if (specArray.count == 2){
        if([[dic allKeys] containsObject:@"10000"] && [[dic allKeys] containsObject:@"10001"]){
            selectedStr = [NSString stringWithFormat:@"%@,%@",dic[@"10000"][@"id"],dic[@"10001"][@"id"]];
            
        }else{
            return;
        }
    }
    
    NSArray *standardArray = self.mainDic[@"standard"];
    for (int i = 0; i < standardArray.count; i ++) {

        NSDictionary *smallDic = [standardArray objectAtIndex:i];
        //判断选中的是否与数据源里面的数据匹配（如果匹配则更改上面商品展示的信息）
        NSString *specificationsid = [NSString stringWithFormat:@"%@",smallDic[@"specificationsid"]];
        if([selectedStr isEqualToString:specificationsid]){
            
            self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[smallDic[@"salePrice"] floatValue]];
            self.numCount = [smallDic[@"KuNum"] integerValue];
            self.kuCunLabel.text = [NSString stringWithFormat:@"库存：%@",smallDic[@"KuNum"]];
            
            
            if(specArray.count == 1){
                self.selectedLabel.text = [NSString stringWithFormat:@"已选择:%@",dic[@"10000"][@"name"]];
                
            }else if(specArray.count == 2){
                self.selectedLabel.text = [NSString stringWithFormat:@"已选择%@-%@",dic[@"10000"][@"name"],dic[@"10001"][@"name"]];
                
            }
            //把选中的规格信息放进最终的字典里面（该model里面的数据放进去）
            [self.endDic setObject:smallDic[@"standardId"] forKey:@"spid"];//规格spid3
            NSDictionary *classDic = [smallDic[@"classify"] objectAtIndex:0];
            [self.endDic setObject:[NSString stringWithFormat:@"%@",classDic[@"classId"]] forKey:@"stid"];//种类stid
            [self.endDic setObject:self.selectedLabel.text forKey:@"selectedMessage"];//选中的规格
            [self.endDic setObject:smallDic[@"status"] forKey:@"status"];//1。上架/0.下架
            
            
            return;
        }
        
    }
    
}

#pragma mark - 加入购物车/立即购买按钮点击事件
- (void)shoppingAction:(UIButton *)sender{
    
    //判断库存
    if([self.numField.text integerValue] > self.numCount){
        
        NSLog(@"库存不足");
        
        return;
    }
    //判断商品是否已下架
    if([self.endDic[@"status"]integerValue] == 0){
        NSLog(@"商品已下架");
        return;
    }
    
    //最终的加入
    [self.endDic setObject:self.numField.text forKey:@"num"];
    if(sender.tag == 100){//加入购物车
        
    }else if (sender.tag == 101){//立即购买
    }
    [self closeAction];
}


#pragma mark - 加号点击事件
- (void)addBtnAction
{
    [self.numField resignFirstResponder];
    if([self.numField.text integerValue] >= self.numCount){
        
        self.numField.text = [NSString stringWithFormat:@"%ld",self.numCount];
        
        NSLog(@"库存不足");
        
    }else{
        
        self.numField.text = [NSString stringWithFormat:@"%ld",[self.numField.text integerValue]+1];
    }
    
    
}

#pragma mark - 减号点击事件
- (void)clubBtnAction
{
    [self.numField resignFirstResponder];
    if([self.numField.text integerValue] > 1){
        
        self.numField.text = [NSString stringWithFormat:@"%ld",[self.numField.text integerValue]-1];
        
    }
}
#pragma mark - 数量输入
- (void)TextChange:(UITextField *)textField
{
    if(self.numField == textField){
        if([textField.text isEqualToString:@"0"]){
            self.numField.text = @"1";
        }
    }
    
}
#pragma mark - 数量限制
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.numField == textField){
        if(textField.text.length == 0){
            self.numField.text = @"1";
        }else if([textField.text integerValue] > self.numCount){
            
            self.numField.text = [NSString stringWithFormat:@"%ld",self.numCount];
            
           NSLog(@"提示库存不足");
            
        }
    }
}
#pragma mark - 叉叉按钮点击事件
- (void)closeAction
{
    [self removeFromSuperview];
    
    if([self.delegate respondsToSelector:@selector(selectedDic:selectedStr:)]){
        [self.delegate selectedDic:self.endDic selectedStr:self.selectedLabel.text];
    }
    
}
- (NSMutableDictionary *)selectedDic
{
    if(!_selectedDic){
        _selectedDic = [NSMutableDictionary dictionary];
    }
    return _selectedDic;
}
- (NSMutableDictionary *)endDic
{
    if(!_endDic){
        _endDic = [NSMutableDictionary dictionary];
    }
    return _endDic;
}
- (NSMutableDictionary *)mainDic
{
    if(!_mainDic){
        _mainDic = [NSMutableDictionary dictionary];
    }
    return _mainDic;
    
}


- (UIButton *)creatButton:(CGRect)frame backColor:(UIColor *)backColor_ text:(NSString *)text_ textColor:(UIColor *)textColor_  font:(UIFont *)font_ addTarget:(id)add_ Action:(SEL)action_
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = backColor_;
    [button setTitle:text_ forState:UIControlStateNormal];
    [button setTitleColor:textColor_ forState:UIControlStateNormal];
    button.titleLabel.font = font_;
    [button addTarget:add_ action:action_ forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/*
 
 *
 *自定义TextField
 
 */

- (UITextField *)creatTextFiled:(CGRect)frame placeholder:(NSString *)placeholderN Font:(UIFont *)font NSTextAlignment:(NSTextAlignment)alignment
{
    UITextField *textFiled = [[UITextField alloc]initWithFrame:frame];
    textFiled.textAlignment = alignment;
    textFiled.placeholder = placeholderN;
    textFiled.font = font;
    
    return textFiled;
}

/*
 
 *
 *自定义Label
 
 */

- (UILabel *)creatLabel:(CGRect)frame backColor:(UIColor *)backColor_ text:(NSString *)text_ textColor:(UIColor *)textColor_  font:(UIFont *)font_ textAlignment:(NSTextAlignment)textAli_ numOnLines:(NSInteger)numOnLines_
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = backColor_;
    label.frame = frame;
    label.text = text_;
    label.textColor = textColor_;
    label.textAlignment = textAli_;//NSTextAlignmentLeft
    label.font = font_;//[UIFont systemFontOfSize:17]
    label.numberOfLines = numOnLines_;
    return label;
}

@end
