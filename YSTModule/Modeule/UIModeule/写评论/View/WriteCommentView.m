//
//  WriteCommentView.m
//  YSTModule
//
//  Created by 冯亮亮 on 2018/7/10.
//  Copyright © 2018年 冯亮. All rights reserved.
//
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例
#define SCALE_HEIGHT  kScreenHeight/667.f //适配比例
#define FONT(A,IFBOLD)       IFBOLD ? [UIFont boldSystemFontOfSize:kScreenWidth > 320 ? A : A/1.3]: [UIFont systemFontOfSize:kScreenWidth > 320 ? A : A/1.3]

#import "WriteCommentView.h"
@interface WriteCommentView()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *commentText;
@property(nonatomic,strong)UIView *commentsView;
@end
@implementation WriteCommentView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self initUIWithFrame:frame];
    }
    return self;
}

- (void)createCommentsView {
    if (!_commentsView) {
        
        _commentsView = [[UIView alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT - 49 * SCALE_HEIGHT - 40.0 * SCALE_HEIGHT, SCREEN_WIDTH, 140.0 * SCALE_HEIGHT)];
        _commentsView.backgroundColor = [UIColor whiteColor];
        
        _commentText = [[UITextView alloc] initWithFrame:CGRectInset(_commentsView.bounds, 5.0 * SCALE_HEIGHT, 5.0 * SCALE_WIDTH)];
        _commentText.layer.borderColor   = [UIColor lightGrayColor].CGColor;
        _commentText.layer.borderWidth   = 1.0 * SCALE_HEIGHT;
        _commentText.layer.cornerRadius  = 2.0 * SCALE_HEIGHT;
        _commentText.layer.masksToBounds = YES;
        
        _commentText.inputAccessoryView  = _commentsView;
        _commentText.backgroundColor     = [UIColor clearColor];
        _commentText.returnKeyType       = UIReturnKeyDone;
        _commentText.delegate            = self;
        _commentText.font                = FONT(15, 0);
        [_commentsView addSubview:_commentText];
    }
    [self.window addSubview:_commentsView];//添加到window上或者其他视图也行，只要在视图以外就好了
    [_commentText becomeFirstResponder];//让textView成为第一响应者（第一次）这次键盘并未显示出来，（个人觉得这里主要是将commentsView设置为commentText的inputAccessoryView,然后再给一次焦点就能成功显示）
}-(void)initUIWithFrame:(CGRect)frame
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(15 * SCALE_WIDTH, 10 * SCALE_HEIGHT, 200 * SCALE_WIDTH, 30 * SCALE_HEIGHT)];
    self.backView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    self.backView.layer.cornerRadius = 15 * SCALE_HEIGHT;
    [self addSubview:self.backView];
    
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * SCALE_WIDTH, 7.5 * SCALE_HEIGHT, 15 * SCALE_WIDTH, 15 * SCALE_HEIGHT)];
    self.iconImageView.image = [UIImage imageNamed:@"edit"];
    [self.backView addSubview:self.iconImageView];
    
    
    self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5 * SCALE_WIDTH, CGRectGetMinY(self.iconImageView.frame) - 5 * SCALE_HEIGHT, 70 * SCALE_WIDTH, self.iconImageView.frame.size.height + 10 * SCALE_HEIGHT)];
    self.placeLabel.textColor = [UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f];
    self.placeLabel.textAlignment = NSTextAlignmentLeft;
    self.placeLabel.font = FONT(13, 0);
    self.placeLabel.text = @"写评论";
    [self.backView addSubview:self.placeLabel];
    
    
    self.writeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.writeButton.frame = self.backView.frame;
    [self.writeButton addTarget:self action:@selector(clickWriteCommentButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.writeButton];
    
    
    
    self.zanView = [[CustomButtonView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.backView.frame) + 5 * SCALE_WIDTH, 0 * SCALE_HEIGHT, 50 * SCALE_WIDTH, 50 * SCALE_HEIGHT)];
    self.zanView.backgroundColor = [UIColor whiteColor];
    self.zanView.iconImageView.selected = NO;
    [self.zanView.iconImageView setBackgroundImage:[UIImage imageNamed:@"AppraiseListdianzan"] forState:UIControlStateNormal];
    [self.zanView.iconImageView setBackgroundImage:[UIImage imageNamed:@"zanNewLight"] forState:UIControlStateSelected];
    [self.zanView.iconButton addTarget:self action:@selector(zanAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.zanView];
    
    
    self.shareView = [[CustomButtonView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.zanView.frame),CGRectGetMinY(self.zanView.frame),self.zanView.frame.size.width,self.zanView.frame.size.height)];
    self.shareView.backgroundColor = [UIColor whiteColor];
    [self.shareView.iconImageView setBackgroundImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    [self addSubview:self.shareView];

    
    self.collectView = [[CustomButtonView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.shareView.frame),CGRectGetMinY(self.shareView.frame),self.shareView.frame.size.width,self.shareView.frame.size.height)];
    self.collectView.backgroundColor = [UIColor whiteColor];
    [self.collectView.iconImageView setBackgroundImage:[UIImage imageNamed:@"shoucang2"] forState:UIControlStateNormal];
    [self.collectView.iconImageView setBackgroundImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateSelected];
    [self addSubview:self.collectView];

    
}
#pragma mark  =====   点击写评论按钮
-(void)clickWriteCommentButton:(UIButton *)sender
{
//    //这里是为了防止连续点击
//    sender.userInteractionEnabled = NO;
//    [sender performSelector:@selector(setUserInteractionEnabled:) withObject:@YES afterDelay:1];
    [self showCommentText];
}
- (void)showCommentText {
    [self createCommentsView];
    [self.commentText becomeFirstResponder];//再次让textView成为第一响应者（第二次）这次键盘才成功显示
}
//点击textView右下角回收键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
#pragma mark  =====  点赞按钮
-(void)zanAction:(UIButton *)sender
{
    if (self.zanView.iconImageView.selected == YES) {

        self.zanView.iconImageView.selected = NO;
        
    }else{
        self.zanView.iconImageView.selected = YES;
    }
}
@end
