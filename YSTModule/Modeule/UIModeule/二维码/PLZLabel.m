//
//  PLZLabel.m
//  YSTNewGreatWallMedium
//
//  Created by penglaizhi on 2017/12/14.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "PLZLabel.h"

@implementation PLZLabel


#define markWidth 15

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

+(UILabel *)creatLabelBoldFont:(CGFloat )font color:(NSString *)color title:(NSString *)title {
    
    UILabel *label = [[UILabel alloc]init];
    
    label.text = title;
    
    label.numberOfLines = 0;

//    label.textColor = [UIColor ColorWithString:color];
    
    label.font = [UIFont boldSystemFontOfSize:font];
    
    return label;
}
+(UILabel *)creatLabelFont:(CGFloat )font color:(NSString *)color title:(NSString *)title {
    
    UILabel *label = [[UILabel alloc]init];
    
    label.text = title;
    
    label.numberOfLines = 0;
    
//    label.textColor = [UIColor ColorWithString:color];
    
    label.font = [UIFont systemFontOfSize:font];
    
    return label;
}
+(UILabel *)creatLabelFont:(CGFloat )font backGroundColor:(NSString *)backGroundColor color:(NSString *)color title:(NSString *)title {
    
    UILabel *label = [[UILabel alloc]init];
    
    label.text = title;
    
    label.numberOfLines = 0;
    
//    label.textColor = [UIColor ColorWithString:color];
    
//    label.backgroundColor = [UIColor ColorWithString:backGroundColor];
    
    label.font = [UIFont systemFontOfSize:font];
    
    return label;
}
+(UILabel *)creatLineSizeLabelFont:(CGFloat )font color:(NSString *)color title:(NSString *)title spacing:(CGFloat)spacing{
    
    UILabel *label = [[UILabel alloc]init];
    
    label.text = title;
    
//    label.textColor = [UIColor ColorWithString:color];
    
    label.font = [UIFont systemFontOfSize:font];
    
    label.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attributedString;
    
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [label sizeToFit];
    
    return label;
}
+(UILabel *)creatLabelFont:(CGFloat )font color:(NSString *)color title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment frame:(CGRect)frame{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    
    label.textAlignment = textAlignment;
    
    label.numberOfLines = 0;
    
    label.text = title;
    
//    label.textColor = [UIColor ColorWithString:color];
    
    label.font = [UIFont systemFontOfSize:font];
    
    return label;
}
+(UILabel *)creatLabelFont:(CGFloat)size fontText:(NSString *)FontText color:(NSString *)color title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment frame:(CGRect)frame {
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    
    label.textAlignment = textAlignment;
    
    label.font = [UIFont fontWithName:FontText size:size];
    
    label.numberOfLines = 0;
    
    label.text = title;
    
//    label.textColor = [UIColor ColorWithString:color];
    
    return label;
}
+(UILabel *)creatLabelFontNew:(UIFont *)font color:(NSString *)color title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment frame:(CGRect)frame {
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    
    label.textAlignment = textAlignment;
    
    label.font = font;
    
    label.numberOfLines = 0;
    
    label.text = title;
    
//    label.textColor = [UIColor ColorWithString:color];
    
    return label;
}
//+(UILabel *)creatTagLabelFont:(UIFont *)font color:(NSString *)color title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment frame:(CGRect)frame
//{
//    
//    UILabel *label = [[UILabel alloc]initWithFrame:frame];
//    
//    label.textAlignment = textAlignment;
//
//    label.textColor = [UIColor ColorWithString:color];
//
//    label.layer.masksToBounds = YES;
//    
//    label.layer.cornerRadius = 2;
//    
//    label.layer.borderWidth = 1;
//    
//    label.layer.borderColor = [UIColor ColorWithString:color].CGColor;
//    
//    label.font = font;
//    
//    label.text = title;
//    
//    CGFloat wid = [UILabel getWidthWithTitle:title font:font];
//    
//    CGRect rect = label.frame;
//    
//    rect.size.width = wid+10*SCALE_WIDTH;
//    
//    label.frame = rect;
//    
//    return label;
//}

@end
