//
//  ImgShowView.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgShowView : UIView
@property (nonatomic,strong)NSArray<NSDictionary *> * imgs;
@property (nonatomic,copy)void(^heightChangeCallBack)(CGFloat height);
@end
