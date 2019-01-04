//
//  NSString+Hex.m
//  iPhone
//
//  Created by 阿凡树 QQ：729397005 on 14-6-18.
//  Copyright (c) 2014年 优米网. All rights reserved.
//

#import "NSString+Hex.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Hex)
- (int)intHexValue {
    unsigned int hex;
    NSScanner * scanner = [NSScanner scannerWithString:self];
    [scanner scanHexInt: &hex];
    return hex;
}

/**
 * 使用该函数计算字符串的高度
 * parameters : 不传参
 */
- (CGFloat)CallateLabelSizeHeight:(UIFont*)LabelFont_ lineWidth:(CGFloat)lineWidth_{
    
    CGSize size = CGSizeMake(lineWidth_,20000);
    NSDictionary *attribute = @{NSFontAttributeName:LabelFont_};
    CGSize labelsize = [self boundingRectWithSize:size
                                          options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                       attributes:attribute context:nil].size;
    
    return labelsize.height+0.5;
    
}

/**
 * 使用该函数计算字符串的宽度
 * parameters : 不传参
 */
- (CGFloat)CallatelabelSizeWidth:(UIFont*)LabelFont_ lineHeight:(CGFloat)lineHeight_{
    
    CGSize size = CGSizeMake(20000,lineHeight_);
    NSDictionary *attribute = @{NSFontAttributeName:LabelFont_};
    CGSize labelsize = [self boundingRectWithSize:size
                                          options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                       attributes:attribute context:nil].size;
    
    return labelsize.width+0.5;
    
}

/**
 * 使用MD5
 * 加密
 */

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


@end
