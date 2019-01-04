//
//  UIView+Helper.m
//  专卖商城 - iOS
//
//  Created by penghui on 2017/12/29.
//  Copyright © 2017年 重庆易耀通科技股份有限公司. All rights reserved.
//

#import "UIView+Helper.h"
#import <objc/runtime.h>

static void *emptyViewKey = &emptyViewKey;
@implementation UIView (Helper)

#pragma mark -- 当tableView  为空时要显示的界面
//getter
- (UIView *)emptyView {
    return  objc_getAssociatedObject(self, &emptyViewKey);
}
//setter
- (void)setEmptyView:(UIView *)emptyView {
    objc_setAssociatedObject(self,  &emptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)addEmptyView:(UIView *)emptyView{
    self.emptyView = emptyView;
    self.emptyView.hidden = YES;
    if (![self.subviews containsObject:self.emptyView]) {
        [self addSubview:self.emptyView];
    }
}
@end
