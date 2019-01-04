//
//  RichEditCellView.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RichEditModel.h"


@interface RichEditCellView : UIView
@property (nonatomic,assign)NSUInteger row;
@property (nonatomic,strong)RichEditModel * model;
@end
