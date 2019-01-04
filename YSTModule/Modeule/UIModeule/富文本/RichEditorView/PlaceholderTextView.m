//
//  PlaceholderTextView.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "PlaceholderTextView.h"

@implementation PlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = [UIColor lightGrayColor];
        self.placeholder = @"";
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    [self.placeholder drawInRect:CGRectMake(0, 10, self.frame.size.width, self.frame.size.height) withAttributes:attrs];
}

// 布局子控件的时候需要重绘
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
    
}
// 设置属性的时候需要重绘，所以需要重写相关属性的set方法
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
    
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (text.length) { // 因为是在文本改变的代理方法中判断是否显示placeholder，而通过代码设置text的方式又不会调用文本改变的代理方法，所以再此根据text是否不为空判断是否显示placeholder。
        self.placeholder = @"";
    }
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    if (attributedText.length) {
        self.placeholder = @"";
    }
    [self setNeedsDisplay];
}
-(void)setMaxNum:(NSInteger)maxNum{
    
    _maxNum = maxNum;
    
    NSString *toBeString = self.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > maxNum) {
                
                self.text = [toBeString substringToIndex:maxNum];
//                [[PJ_CommonTool getCurrentVC].view makeToast:[NSString stringWithFormat:@"最多输入%ld个字",maxNum] duration:1 position:CSToastPositionTop];
            }
        }else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
        
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        
        if (toBeString.length > maxNum) {
            
            self.text = [toBeString substringToIndex:maxNum];
//            [[PJ_CommonTool getCurrentVC].view makeToast:[NSString stringWithFormat:@"最多输入%ld个字",maxNum] duration:1 position:CSToastPositionTop];
            
        }
        
    }
    
}
@end
