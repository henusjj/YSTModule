//
//  StandardKind.m
//  YSTModule
//
//  Created by 节庆霞 on 2018/7/6.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "StandardKind.h"
#import "NSString+Hex.h"
#define RGB_COLOR(r, g, b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]

@implementation StandardKind

- (instancetype)initWithFrame:(CGRect)frame contentDic:(NSDictionary *)contentdic
{
    if([super initWithFrame:frame]){
        [self setUI:contentdic];
    }
    return self;
}
#pragma mark - 页面搭建
- (void)setUI:(NSDictionary *)dic
{
    //主题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,  10, SCREEN_WIDTH -20, 15)];
    titleLabel.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview:titleLabel];
    
    CGFloat x = 0;
    CGFloat y = 35;
    CGFloat space = 15;//间距
    self.mainArray = dic[@"subspec"];
    for (int i = 0; i < self.mainArray.count; i++) {
        NSDictionary *dic = [self.mainArray objectAtIndex:i];
        NSString *name = [NSString stringWithFormat:@"%@",dic[@"name"]];
        CGFloat itemW = [name CallatelabelSizeWidth:[UIFont systemFontOfSize:12] lineHeight:30];
        
        UIButton *button = [self creatButton:CGRectMake(15 + x , y, itemW + 15, 30) backColor:RGB_COLOR(244, 245, 246) text:name textColor:RGB_COLOR(87, 88, 89) font:[UIFont systemFontOfSize:12] addTarget:self Action:@selector(buttonAction:)];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0;
        button.tag = 1000 + i;
        [self addSubview:button];
        
        x = x + itemW+ 15 + space;
        
        if(i < self.mainArray.count - 1){
            NSDictionary *dict = [self.mainArray objectAtIndex:i+1];
            NSString *nameStr = [NSString stringWithFormat:@"%@",dict[@"name"]];
            
            CGFloat itemW1 = [nameStr CallatelabelSizeWidth:[UIFont systemFontOfSize:12] lineHeight:30];
            if(x + (itemW1 + 15) >SCREEN_WIDTH - 20){
                x = 0;
                y += 40;
            }
            
        }
        if(i == 0){
            button.backgroundColor = [UIColor redColor];
            button.selected = YES;
        }
        
        
    }
    
    
    //分割线
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(10,self.frame.size.height-0.5, SCREEN_WIDTH - 20, 0.5)];
    line.backgroundColor =RGB_COLOR(228, 228, 228);;
    [self addSubview:line];
    
    
}
#pragma mark - 按钮点击事件
- (void)buttonAction:(UIButton *)sender
{
    for (int i = 0; i < self.mainArray.count; i++) {
        
        UIButton *button = (UIButton *)[self viewWithTag:1000 + i];
        
        if (sender.tag != 1000 + i) {
            
            button.backgroundColor = RGB_COLOR(242, 245, 246);
            button.selected = NO;
            button.userInteractionEnabled = YES;
            
        }else{
            button.backgroundColor = [UIColor redColor];
            button.selected = YES;
        }
        
    }
    
    NSDictionary *dic = [self.mainArray objectAtIndex:sender.tag-1000];
    if([self.delegte respondsToSelector:@selector(selectedInfoView:selectedButtonMessage:)]){
        [self.delegte selectedInfoView:self.tag selectedButtonMessage:dic];
    }
    
    
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

@end
