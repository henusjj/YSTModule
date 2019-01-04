//
//  UIView+D_Category.h
//  类方法
//
//  Created by yst－dgz on 2017/5/25.
//  Copyright © 2017年 yst－dgz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (D_Category)
@property(nonatomic)CGFloat left;
@property(nonatomic)CGFloat top;
@property(nonatomic)CGFloat right;
@property(nonatomic)CGFloat bottom;

@property(nonatomic)CGFloat width;
@property(nonatomic)CGFloat height;

@property(nonatomic)CGFloat centerX;
@property(nonatomic)CGFloat centerY;

@property(nonatomic,readonly)CGFloat screenX;
@property(nonatomic,readonly)CGFloat screenY;
@property(nonatomic,readonly)CGFloat screenViewX;
@property(nonatomic,readonly)CGFloat screenViewY;
@property(nonatomic,readonly)CGRect screenFrame;

@property(nonatomic)CGPoint origin;
@property(nonatomic)CGSize size;

@property(nonatomic)BOOL visible;

- (UIView*)descendantOrSelfWithClass:(Class)cls;

- (UIView*)ancestorOrSelfWithClass:(Class)cls;

- (void)removeAllSubviews;

- (CGPoint)offsetFromView:(UIView*)otherView;


- (void)addSubviews:(NSArray *)views;

+ (UILabel *)labelWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)alignment text:(NSString *)text;



@end
