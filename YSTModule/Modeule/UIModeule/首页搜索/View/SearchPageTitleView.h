//
//  SearchPageTitleView.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchPageTitleView : UIView
@property (nonatomic,assign)NSUInteger index;
@property (nonatomic,copy)void(^selectCallBack)(NSUInteger index);
@end
