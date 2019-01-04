//
//  UIView+D_Category.m
//  类方法
//
//  Created by yst－dgz on 2017/5/25.
//  Copyright © 2017年 yst－dgz. All rights reserved.
//

#import "UIView+D_Category.h"

@implementation UIView (D_Category)


-(BOOL)visible{
    return !self.hidden;
}


- (void)setVisible:(BOOL)visible{
    self.hidden = !visible;
}

/******************************设置View左边x坐标*******************************/
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

/****************************设置View顶部y坐标*********************************/
- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

/****************************设置View右边x坐标*********************************/
- (CGFloat)right {
    return self.frame.origin.x +self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
/****************************设置View底部y坐标*************************************/

- (CGFloat)bottom {
    return self.frame.origin.y +self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

/*****************************设置View的中心坐标********************************/
- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center =CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center =CGPointMake(self.center.x, centerY);
}

/**************************设置View的宽度***********************************/
- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

/*****************************设置View的高度********************************/
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)screenX {
    CGFloat x = 0;
    for (UIView* view =self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

- (CGFloat)screenY {
    CGFloat y = 0;
    for (UIView* view =self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view =self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view =self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX,self.screenViewY,self.width,self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y =0;
    for (UIView* view =self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}
/*
 - (CGFloat)orientationWidth {
 return UIInterfaceOrientationIsLandscape(TTInterfaceOrientation())
 ? self.height : self.width;
 }
 
 - (CGFloat)orientationHeight {
 return UIInterfaceOrientationIsLandscape(TTInterfaceOrientation())
 ? self.width : self.height;
 }
 */
//- (UIView*)descendantOrSelfWithClass:(Class)cls {
//    if ([self isKindOfClass:cls])
//        return self;
//    
//    for (UIView* childin self.subviews) {
//        UIView* it = [childdescendantOrSelfWithClass:cls];
//        if (it)
//            return it;
//    }
//    
//    return nil;
//}
//
//- (UIView*)ancestorOrSelfWithClass:(Class)cls {
//    if ([selfisKindOfClass:cls]) {
//        return self;
//    } else if (self.superview) {
//        return [self.superviewancestorOrSelfWithClass:cls];
//    } else {
//        return nil;
//    }
//}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child =self.subviews.lastObject;
        [child removeFromSuperview];
    }
}



- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


//- (void)addSubviews:(NSArray *)views
//{
//    for (UIView *vin views) {
//        [self addSubview:vin];
//    }
//}

+ (UILabel *)labelWithFrame:(CGRect)frame
                   fontSize:(CGFloat)fontSize
              textAlignment:(NSTextAlignment)alignment
                       text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = alignment;
    label.text = text;
    label.textColor = [UIColor blackColor];
    label.lineBreakMode =NSLineBreakByWordWrapping;
    return label;
}

@end
