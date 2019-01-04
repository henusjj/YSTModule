//
//  UITextView+Placeholder.h
//  TextView
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Placeholder)
/**
 textView placeholder text
 */
@property (nonatomic ,copy)NSString *placeholder;
/**
 textView placeholder textColor
 */
@property (nonatomic ,strong)NSDictionary *placeholderAttributes;
/**
 the max inputLenth
 */
@property (nonatomic ,assign)NSInteger maxInputLength;
@end
