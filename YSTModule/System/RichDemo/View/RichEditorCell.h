//
//  RichEditorCell.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RichEditorCell,RichEditView;

@protocol RichEditorCellDelegate <NSObject>
/**
  富文本编辑器调整文本高度的方法

 @param cell 编辑器Cell
 @param cellHeight cell高度
 */
-(void)richEditorCell:(RichEditorCell *)cell cellHeight:(CGFloat)cellHeight;

/**
 编辑器开始编辑
 */
-(void)richEitorBeginEditor;

@end

@interface RichEditorCell : UITableViewCell


@property (nonatomic,weak) id <RichEditorCellDelegate> richCellDelegate;
/** 可添加最多图片数量 */
@property (nonatomic,assign) NSInteger ImgMax;
/** 可添加最多视频数量 */
@property (nonatomic,assign) NSInteger videoMax;
/** 编辑框 */
@property (nonatomic,strong)RichEditView * rishView;
/** 商品回显数组 */
@property (nonatomic,strong)NSArray *desecArr;
/** 编辑框名称 */
@property (nonatomic,copy)NSString *editorName;
@end
