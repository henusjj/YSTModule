//
//  RichEditImgCellView.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "RichEditCellView.h"

@interface RichEditImgCellView : RichEditCellView
@property (nonatomic,copy)void(^deleBlock)(NSUInteger row);
@end
