//
//  NSString+Hex.h
//  iPhone
//
//  Created by 阿凡树 QQ：729397005 on 14-6-18.
//  Copyright (c) 2014年 优米网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hex)

//把字符串转化为16进制
- (int)intHexValue;

/**
 * 使用该函数计算字符串的高度
 * parameters : 不传参
 */
- (CGFloat)CallateLabelSizeHeight:(UIFont*)LabelFont_ lineWidth:(CGFloat)lineWidth_;

/**
 * 使用该函数计算字符串的宽度
 * parameters : 不传参
 */
- (CGFloat)CallatelabelSizeWidth:(UIFont*)LabelFont_ lineHeight:(CGFloat)lineHeight_;

/**
 * 使用MD5
 * 加密
 */

- (NSString *)md5;

@end
