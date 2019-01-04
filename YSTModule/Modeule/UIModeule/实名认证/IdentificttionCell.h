//
//  IdentificttionCell.h
//  YSTViewsDemo
//
//  Created by penglaizhi on 2018/6/7.
//  Copyright © 2018年 决心. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSTButtonCode.h"
typedef void (^textFieldTextBlock)(NSString *text);

@interface IdentificttionCell : UITableViewCell

@property (nonatomic,copy) textFieldTextBlock fieldBlock;
/*允许输入的字数*/
@property (nonatomic,copy) NSString *countNum;
/*左边的标题*/
@property (nonatomic,strong) UILabel *labelTitle;
/*输入框*/
@property (nonatomic,strong) UITextField *textField;
/*线*/
@property (nonatomic,strong) UIView *viewLine;
/*验证码*/
@property (nonatomic,strong) YSTButtonCode *buttonCode;


/*创建label和textfield的cell*/
+(instancetype)cellWithtableViewForLabelAndTextField:(UITableView *)tableview;
/*创建带发送按钮的cell*/
+(instancetype)cellWithtableViewForLabelAndFieldAndCode:(UITableView *)tableview;



@end
