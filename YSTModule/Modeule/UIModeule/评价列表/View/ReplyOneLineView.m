//
//  ReplyOneLineView.m
//  PuJiTown
//
//  Created by penglaizhi on 2018/6/11.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "ReplyOneLineView.h"


@interface ReplyOneLineView ()
/*整个的视图*/
@property (nonatomic,strong) UIView *viewF;
/*评论内容输入框*/
@property (nonatomic,strong) UITextField *textField;
/*回复按钮*/
@property (nonatomic,strong) UIButton *buttonReply;

@end

@implementation ReplyOneLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_makeupViewInReplyOneLineView];
    }
    return self;
}
-(void)p_makeupViewInReplyOneLineView
{
    self.textField = [[UITextField alloc] init];
    self.buttonReply = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.buttonReply setTitle:@"回复" forState:(UIControlStateNormal)];
    //    self.buttonReply sett
}
@end
