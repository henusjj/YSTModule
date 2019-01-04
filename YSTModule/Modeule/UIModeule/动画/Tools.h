//
//  Tools.h
//  AnimationDemo
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
+(UIButton *)createBtnTitle:(NSString *)title Selector:(SEL)selector  target:(id)target;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
