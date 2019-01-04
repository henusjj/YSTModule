//
//  RichEditTextCellView.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "RichEditCellView.h"
#import "PlaceholderTextView.h"

@interface RichEditTextCellView : RichEditCellView
@property (nonatomic,strong)PlaceholderTextView * textView;

@property (nonatomic,strong)void (^textChange)(NSString * text,NSUInteger row);
@property (nonatomic,strong)NSString * placeHolder;
/** 替换当前文字 在下一行插入一张图片 下下行插入文字cell */
@property (nonatomic,strong)void (^insertImg)(NSUInteger row,NSString * imgUrl,NSString * currentWillReplaceText, NSString *nextInsertText);
/** 替换当前文字 在下一行插入一张图片 下下行插入文字cell */
@property (nonatomic,strong)void (^insert)(NSUInteger row,NSUInteger btnTag,NSString * currentWillReplaceText,NSString *nextInsertText);

@property (nonatomic,strong)void (^clearAtFirstPlace)(NSUInteger row);
-(void)textViewbecomeFirstResponse;

/** 把光标 移动到指定的位置 */
-(void)moveCursorToLocation:(NSUInteger)location;
@end
