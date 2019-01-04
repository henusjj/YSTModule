//
//  RichEditView.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RichEditImgCellView,RichEditTextCellView,RichEditModel;

@interface RichEditView : UIView
@property (nonatomic,strong)UIColor * textColor;
@property (nonatomic,strong)UIColor * placeHolderColor;
@property (nonatomic,strong)NSString * placeHolder;
@property (nonatomic,strong)UIFont * textFont;

/** 替换当前文字 在下一行插入一张图片 下下行插入文字cell */
@property (nonatomic,strong)void (^insert)(NSUInteger row,NSUInteger btnTag,NSString * currentWillReplaceText,NSString *nextInsertText);

/**
 数据源
 */
@property (nonatomic,strong)NSMutableArray * datas;

/**
 高度改变后的回调
 */
@property (nonatomic,strong)void (^heightChange)(CGFloat height);


/** 插入 img and text  */
-(void)insertImgAndText:(NSUInteger)row imgUrl:(NSString *)imgUrl currentWillReplaceText:(NSString *)currentWillReplaceText nextInsertText:(NSString *)nextInsertText;
/** 插入 model  */
-(void)insertModel:(RichEditModel *)model row:(NSUInteger)row currentWillReplaceText:(NSString *)currentWillReplaceText nextInsertText:(NSString *)nextInsertText;
/** 添加 图片  */
-(void)addImgUrl:(NSString  *)imgUrl;
/** 添加 视频  */
-(void)addVideoUrl:(NSString  *)videoUrl coverUrl:(NSString *)coverUrl;

//-(void)layoutCellView;
/** 获取内容 */
-(NSString *)getContentText;
/** 发布内容为空 */
-(BOOL)isEmpty;
/** 发布内容字数 */
-(NSUInteger)getTextCount;
/** 获取添加的商品个数 */
-(NSUInteger)getGoodsCount;
/** 获取添加的图片个数 */
-(NSUInteger)getImgsCount;
/** 获取添加视频个数 */
-(NSInteger)getVideoCount;

-(void)isbecomeFirst;
@end
