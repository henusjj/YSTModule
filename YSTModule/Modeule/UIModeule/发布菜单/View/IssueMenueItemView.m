//
//  IssueMenueItemView.m
//  YSTModule
//
//  Created by 李慧静 on 2018/6/27.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "IssueMenueItemView.h"
#import "IssueMenueItem.h"
#import "IssueMenueButton.h"
const float YSTButtonImageTitleHeightRate = 4.0;
const float YSTDefaultColumns = 3;
const float YSTMarginBetweenImageAndTitle = 10;
const float YSTDefaultSpaceToBottom1 = 40;

#define YSTDefaultButtonDiametr1 ([UIScreen mainScreen].bounds.size.width - (3 + 1) * [UIScreen mainScreen].bounds.size.width * 0.1) / 3

@interface IssueMenueItemView ()
@property (strong, nonatomic) NSMutableArray *buttons;
/** 是否需要调整按钮尺寸 */
@property (assign, nonatomic, getter=isNeedAdjustButtonFrame) BOOL needAdjustButtonFrame;

@end

@implementation IssueMenueItemView
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.columns = YSTDefaultColumns;
    self.buttonDiameter = YSTDefaultButtonDiametr1;
    self.spaceToBottom = YSTDefaultSpaceToBottom1;
    self.buttonTitleColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    self.needAdjustButtonFrame = YES;
    self.alpha = 1;
    
    
}

+ (instancetype)menuWithFrame:(CGRect)frame items:(NSArray *)items{
    
    IssueMenueItemView *menu=[[self alloc] initWithFrame:frame];
    
    menu.items=items;
    
    return menu;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    [self setUpButtons];
}

// 创建按钮
- (void)setUpButtons
{
    int itemsCount = (int)self.items.count;
    
    for (int i = 0; i < itemsCount; i++) {
        IssueMenueButton *btn = [IssueMenueButton buttonWithType:UIButtonTypeCustom];
        btn.heightRate = YSTButtonImageTitleHeightRate;
        btn.imageTitleMargin = YSTMarginBetweenImageAndTitle;
        btn.tag = 20+i;
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(btnDownClick:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(btnUpClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.buttons addObject:btn];
        
        IssueMenueItem *item = self.items[i];
        [btn setImage:item.image forState:UIControlStateNormal];
        [btn setTitle:item.title forState:UIControlStateNormal];
        
        // 按钮先移动到看不见的地方
        //        btn.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
    }
}
// 按下功能按钮
- (void)btnDownClick:(IssueMenueButton *)btn
{
    self.needAdjustButtonFrame = NO;
    
}

// 松开功能按钮
- (void)btnUpClick:(IssueMenueButton *)btn
{
    //    [btn shrink];
    self.needAdjustButtonFrame = NO;
    if ([self.delegate respondsToSelector:@selector(springMenu:didClickButtonWithIndex:)]) {
        [self.delegate springMenu:self didClickButtonWithIndex:btn.tag];
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isNeedAdjustButtonFrame) {
        [self adjustButtonsFrame];
    }
}
// 调整按钮frame
- (void)adjustButtonsFrame
{
    CGFloat row = 0;
    CGFloat column = 0;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.buttonDiameter;
    CGFloat btnH = self.buttonDiameter + self.buttonDiameter / YSTButtonImageTitleHeightRate + YSTMarginBetweenImageAndTitle;
    CGFloat margin = (kScreenWidth - self.columns * btnW) / (self.columns + 1);
    int itemsCount = (int)self.items.count;
    
    // 计算总行数
    NSInteger rows = self.items.count / self.columns;
    rows = self.items.count % self.columns ? rows + 1 : rows;
    
    // 计算第一行按钮初始Y值
    CGFloat originY = kScreenHeight - (margin + btnH) * rows - self.spaceToBottom;
    
    for (int i = 0; i < itemsCount; i++) {
        row = i / self.columns;
        column = i % self.columns;
        btnX = margin + column * (margin + btnW);
        btnY = row * (margin + btnH - YSTMarginBetweenImageAndTitle) + originY;
        
        IssueMenueButton *btn = self.buttons[i];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
    }
}


// 显示menu
- (void)becomeActive
{
    self.alpha = 1.0;
    self.needAdjustButtonFrame = YES;
    
    // 每隔按钮隔0.1秒做动画
    [_buttons enumerateObjectsUsingBlock:^(IssueMenueButton *btn, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:0.5 delay:0.05 * idx usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            // 复位按钮形变
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1;
            if (idx == 0) {
                self.backgroundColor = [UIColor whiteColor];
                
            }
        } completion:nil];
    }];
}

// 取消显示menu
- (void)resignActive
{
    self.needAdjustButtonFrame = NO;
    
    for (NSInteger i = self.buttons.count - 1; i >= 0; i--) {
        IssueMenueButton *btn = self.buttons[i];
        
        [UIView animateWithDuration:0.2 delay:0.05 * (self.buttons.count -i) options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0, kScreenHeight-btn.frame.origin.y);
            transform = CGAffineTransformScale(transform, 0.2, 0.2);
            
            btn.transform = transform;
            // 背景和底部按钮动画和最后一个消失的按钮一致
            if (i == 0) {
                self.backgroundColor = [UIColor clearColor];
                if ([self.delegate respondsToSelector:@selector(resignCurrentActive:)]) {
                    //通知当前menu的btns已经隐藏完毕
                    [self.delegate resignCurrentActive:self];
                }
            }
            
        } completion:^(BOOL finished) {
            // 这里不要从父控件移除，每次都创建没必要，简单地设置为透明或者隐藏都行
            if (i == 0) {
                //                [self removeFromSuperview];
                self.alpha = 0;
                if ([self.delegate respondsToSelector:@selector(resignCurrentActiveEnd:)]) {
                    //通知当前menu的btns已经隐藏完毕
                    [self.delegate resignCurrentActiveEnd:self];
                }
            }
        }];
    }
}
@end
