//
//  TagView.h
//  ComponentNavPage
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagView : UIView
@property (nonatomic,strong)NSArray * tags;
@property (nonatomic,copy)void(^clickCall)(NSUInteger index);

@end
