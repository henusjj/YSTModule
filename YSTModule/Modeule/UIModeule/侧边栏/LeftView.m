//
//  LeftView.m
//  PSDrawerController
//
//  Created by YSTQZY on 18/6/15.
//  Copyright © 2018年 YSTQZY. All rights reserved.
//

#import "LeftView.h"
#import "PSDrawerManager.h"
#import "UIView+leoAdd.h"

static NSString *const reUse = @"reUse";

#define kBackgroundColor [UIColor colorWithRed:13.f / 255.f green:184.f / 255.f blue:246.f / 255.f alpha:1]

@interface LeftView ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSArray *>*dataArray;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LeftView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBackgroundColor;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
