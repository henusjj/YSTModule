//
//  AlertPopView.m
//  YSTModule
//
//  Created by 李晨芳 on 2018/7/5.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "AlertPopView.h"
#import "PJ_MaskTool.h"
#define topHeight 260*SCALE_WIDTH
#define kWidth 220*SCALE_WIDTH
#define kHeight 115.5*SCALE_WIDTH
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例
#define SCALE_HEIGHT  kScreenHeight/667.f //适配比例

@interface AlertPopView()

@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * subTitle;
@property(nonatomic,copy)NSString * leftBtnTitle;
@property(nonatomic,copy)NSString * rightBtnTitle;
@property(nonatomic,copy)void(^btnClickBlock)(NSInteger clickIndex);


@end

@implementation AlertPopView
- (instancetype)initWithTitle:(NSString *)title subTile:(NSString *)subTile leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle clickBlock:(void(^)(NSInteger clickIndex)) btnClickBlock
{
    self = [super initWithFrame:CGRectMake((kScreenWidth - kWidth)/2., topHeight, kWidth, kHeight)];
    if (self) {
        _title = title;
        _subTitle = subTile;
        _leftBtnTitle = leftBtnTitle;
        _rightBtnTitle = rightBtnTitle;
        self.btnClickBlock = btnClickBlock;
        [self creatUI];
    }
    return self;
}
-(void)creatUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 4.0;
    
    //标题
    UILabel * titleLabel = [[UILabel alloc]init];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(18 * SCALE_WIDTH);
        make.leading.equalTo(self).offset(10 * SCALE_WIDTH);
        make.trailing.equalTo(self).offset(-10 * SCALE_WIDTH);
    }];
    titleLabel.textColor = [UIColor  blackColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 1;
    titleLabel.text = _title;
    //子标题
    UILabel * subTitleLabel = [[UILabel alloc]init];
    [self addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(6.5 * SCALE_WIDTH);
        make.leading.equalTo(self).offset(10 * SCALE_WIDTH);
        make.trailing.equalTo(self).offset(-10 * SCALE_WIDTH);
    }];
    subTitleLabel.textColor = [UIColor lightGrayColor];
    subTitleLabel.font = [UIFont systemFontOfSize:13];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    subTitleLabel.numberOfLines = 1;
    subTitleLabel.text = _subTitle;
    //线
    UIView * conLine = [[UIView alloc]init];
    [self addSubview:conLine];
    [conLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-40*SCALE_WIDTH);
        make.leading.trailing.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    conLine.backgroundColor = [UIColor lightGrayColor];
    UIView * verLine = [[UIView alloc]init];
    [self addSubview:verLine];
    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.mas_equalTo(0.5);
        make.top.equalTo(conLine.mas_bottom);
        make.centerX.equalTo(conLine);
    }];
    verLine.backgroundColor = [UIColor lightGrayColor];
    //取消确定按钮
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(verLine.mas_leading);
        make.bottom.equalTo(self);
        make.top.equalTo(conLine.mas_bottom);
    }];
    if (_leftBtnTitle.length == 0) {
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        [cancelBtn setTitle:_leftBtnTitle forState:UIControlStateNormal];
    }
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cancelBtn.tag = 1000;
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //确定
    UIButton * ensureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:ensureBtn];
    [ensureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(verLine.mas_trailing);
        make.trailing.equalTo(self);
        make.bottom.equalTo(self);
        make.top.equalTo(conLine.mas_bottom);
    }];
    if (_leftBtnTitle.length == 0) {
        [ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
    }else{
        [ensureBtn setTitle:_rightBtnTitle forState:UIControlStateNormal];
    }
    [ensureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    ensureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    ensureBtn.tag = 1001;
    [ensureBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    titleLabel.backgroundColor = [UIColor randomColor];
    //    subTitleLabel.backgroundColor = [UIColor randomColor];
}
#pragma mark - 取消和确定按钮点击
-(void)btnClick:(UIButton *)btn
{
    if (self.btnClickBlock) {
        self.btnClickBlock(btn.tag - 1000);
    }
    [self dismiss];
}
#pragma mark - 出现
-(void)show
{
    [PJ_MaskTool addMaskToWindow];
    UIView * maskBG = (UIView *)[[[UIApplication sharedApplication] delegate].window viewWithTag:10000];
 
    [maskBG addSubview:self];
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [PJ_MaskTool removeMaskFromWindow];
    }];
}
@end
