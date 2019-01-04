//
//  IdentificttionCell.m
//  YSTViewsDemo
//
//  Created by penglaizhi on 2018/6/7.
//  Copyright © 2018年 决心. All rights reserved.


#import "IdentificttionCell.h"

@interface IdentificttionCell ()<UITextFieldDelegate>

@property (nonatomic,strong) UIView *viewAll;

@end
#define cellHeight 44
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
@implementation IdentificttionCell

+(instancetype)cellWithtableViewForLabelAndTextField:(UITableView *)tableview
{
    static NSString *ID = @"IdentificttionCell";
    
    IdentificttionCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[IdentificttionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell p_makeupViewForLabelAndTextField];
    }
    
    return cell;
}
-(void)p_makeupViewForLabelAndTextField
{
    if (kScreenWidth==320) {
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, cellHeight-1)];
    }else{
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 90, cellHeight-1)];
        
    }
    self.labelTitle.font = [UIFont systemFontOfSize:14];
    self.labelTitle.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    self.labelTitle.text = @"请输入姓名";
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.labelTitle.frame)+10, 0, kScreenWidth-CGRectGetMaxX(self.labelTitle.frame)-15, cellHeight)];
    self.textField.placeholder = @"请输入...";
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldActionForCountNum) forControlEvents:(UIControlEventEditingChanged)];
    
    self.viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-1, kScreenWidth, 1)];
    self.viewLine.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    [self.contentView addSubview:self.viewLine];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.textField];
    
    
}
#pragma mark - 创建带点击验证码的cell
+(instancetype)cellWithtableViewForLabelAndFieldAndCode:(UITableView *)tableview
{
    static NSString *ID = @"IdentificttionCellCode";
    
    IdentificttionCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[IdentificttionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell p_makeupViewForLabelAndFieldAndCode];
    }
    
    return cell;
}
-(void)p_makeupViewForLabelAndFieldAndCode
{
    if (kScreenWidth==320) {
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, cellHeight-1)];
    }else{
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 90, cellHeight-1)];
        
    }
    self.labelTitle.font = [UIFont systemFontOfSize:14];
    self.labelTitle.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    self.labelTitle.text = @"输入验证码";
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.labelTitle.frame)+10, 0, 110, cellHeight-1)];
    self.textField.placeholder = @"请输入...";
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldActionForCountNum) forControlEvents:(UIControlEventEditingChanged)];
    self.buttonCode = [[YSTButtonCode alloc] init];
//    self.buttonCode = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.buttonCode setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    self.buttonCode.frame = CGRectMake(kScreenWidth-110 , 7, 100, cellHeight-14);
    self.buttonCode.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.buttonCode setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    self.buttonCode.backgroundColor = [UIColor whiteColor];
    self.buttonCode.layer.masksToBounds = YES;
    self.buttonCode.layer.cornerRadius = 2;
    self.buttonCode.layer.borderColor = [UIColor redColor].CGColor;
    self.buttonCode.layer.borderWidth = 1;
    
    self.viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-1, kScreenWidth, 1)];
    self.viewLine.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    [self.contentView addSubview:self.viewLine];
    [self.contentView addSubview:self.buttonCode];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.textField];
    
    
}
-(void)setCountNum:(NSString *)countNum
{
    _countNum = countNum;
    
}
-(void)textFieldActionForCountNum
{
    NSInteger countNum = [self.countNum integerValue];
    
    UITextField *textField = self.textField;
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > countNum) {
                textField.text = [toBeString substringToIndex:countNum];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > countNum) {
            textField.text = [toBeString substringToIndex:countNum];
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
//    if (textField.text.length>0) {
//        if (self.countNum.length==11) {
//            
//        }else{
//            self.fieldBlock(textField.text);
//        }
//        
//    }else{
        self.fieldBlock(textField.text);
        NSLog(@"%@这个内容为%@",self.labelTitle.text,self.textField.text);
//    }
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
