//
//  RichEditView.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "RichEditView.h"
#import "RichEditImgCellView.h"
#include "RichEditTextCellView.h"
#import "RichEditModel.h"

@implementation RichEditView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initData];
        [self initUI];
        [self layoutCellView];
    }
    return self;
}
-(void)setDatas:(NSMutableArray *)datas{
    _datas = datas;
    [self initUI];
    [self layoutCellView];
}
-(void)initData{
    _datas = [NSMutableArray array];
    
        for (int i = 0; i < 10; i ++) {
            RichEditModel * model;
            if (i % 2 == 0 ) {
                model = [[RichEditModel alloc]initWithCellType:RichEditCellViewTypeText content:@"hello"];
            }
            else
            {
                model = [[RichEditModel alloc]initWithCellType:RichEditCellViewTypeImg content:@"http://img.wanchezhijia.com/A/2015/5/6/9/48/c6344b4e-07a8-48a4-b5b9-b08cc7269d62.jpg"];
            }
            [_datas addObject:model];
        }
    
    
    [_datas addObject:[[RichEditModel alloc]initWithCellType:RichEditCellViewTypeText content:@""]];
    
    [self initUI];
}
-(void)initUI{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    for (int i = 0; i < _datas.count; i ++) {
        RichEditModel * model = _datas[i];
        
        
        if (model.cellType == RichEditCellViewTypeText) {
            RichEditTextCellView * textView  = [[RichEditTextCellView alloc]initWithFrame:CGRectMake(0, 0, self.width, 20)];
            [self addSubview:textView];
            textView.model = model;
            textView.row = i;
            if (_textColor) {
                textView.textView.textColor = _textColor;
            }
            if (_textFont) {
                textView.textView.font = _textFont;
            }
            
            if (_datas.count == 1 && textView.model.content.length <= 0) {
                textView.placeHolder = @"请输入正文...";
                if (_placeHolder) {
                    textView.placeHolder = _placeHolder;
                }
                if (_placeHolderColor) {
                    textView.textView.placeholderColor = _placeHolderColor;
                }
                
                
            }
            
            textView.textChange = ^(NSString * text,NSUInteger row) {
                [self layoutCellView];
                [self replaceTextOfDatasWithRow:row text:text];
            };
            textView.insert = ^(NSUInteger row, NSUInteger btnTag, NSString *currentWillReplaceText, NSString *nextInsertText) {
                /**  把图片的添加 交给外部进行处理 */
                //                if (_insert) {
                //                    _insert(row,btnTag,currentWillReplaceText,nextInsertText);
                //                }
                
                /**  把图片的添加 自己进行处理 */
                
                //                if (btnTag == 100) {// 图片
                //
                //                    PHImagePickerTool * imgPikcer =[PHImagePickerTool new];
                //                    imgPikcer.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //                    [((UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController) presentViewController:imgPikcer animated:YES completion:^{
                //                    }];
                //                    imgPikcer.block = ^(UIImage *image) {
                //                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{// 模拟网络请求
                //                            [self insertImgAndText:row imgUrl:@"http://img.wanchezhijia.com/A/2015/5/6/9/48/c6344b4e-07a8-48a4-b5b9-b08cc7269d62.jpg" currentWillReplaceText:currentWillReplaceText nextInsertText:nextInsertText];
                //                        });
                //
                //
                //                    };
                //
                //                }else{// 商品
                //
                //                       [self insertImgAndText:row imgUrl:@"http://img.wanchezhijia.com/A/2015/5/6/9/48/c6344b4e-07a8-48a4-b5b9-b08cc7269d62.jpg" currentWillReplaceText:currentWillReplaceText nextInsertText:nextInsertText];
                //                }
                //
                
                
                
            };
            
            
            
            textView.clearAtFirstPlace = ^(NSUInteger row) {
                [self textCellClearClickAtFirstPlaceAtRow:row];
            };
            
        }
        if (model.cellType == RichEditCellViewTypeImg || model.cellType == RichEditCellViewTypeVideo) {
            RichEditImgCellView * imgView  = [[RichEditImgCellView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width/2)];
            imgView.row = i;
            [self addSubview:imgView];
            imgView.model = model;
            imgView.deleBlock = ^(NSUInteger row) {
                [self deleteRow:row];
                [self initUI];
                [self layoutCellView];
                //                [self becomeTextCellFirstResponseWithRow:row - 1];
            };
        }
    }
    
}
-(void)layoutCellView{
    
    CGFloat setY = 0;
    
    for (int i = 0;  i < self.subviews.count; i ++) {
        UIView * cellView = self.subviews[i];
        cellView.top = setY;
        
        //        cellView.top = 100;
        setY = cellView.bottom + 10;
    }
    
    
    
    self.height = setY;
    if (self.height < 100) {
        self.height = 100;
    }
    
    
    if (self.heightChange) {
        self.heightChange(self.height);
    }
    
    
}
#pragma mark -- 数据 的操作  以及界面的刷新
/** 替换datas 中的文字 */
-(void)replaceTextOfDatasWithRow:(NSInteger )row text:(NSString *)text{
    RichEditModel * model = _datas[row];
    model.content = text;
    [_datas replaceObjectAtIndex:row withObject:model];
    NSLog(@"%ld------ : %@",(long)row,model.content);
}

/** 插入文字 */
-(void)insertTextCell:(NSUInteger)row text:(NSString *)text{
    RichEditModel * model = [[RichEditModel alloc]initWithCellType:RichEditCellViewTypeText content:text];
    [_datas insertObject:model atIndex:row];
    
}
/** 插入一张图片 （链接） */
-(void)insertImgCell:(NSUInteger)row img:(NSString *)imgUrl{
    RichEditModel * model = [[RichEditModel alloc]initWithCellType:RichEditCellViewTypeImg content:imgUrl];
    [_datas insertObject:model atIndex:row];
    
}
/** 插入 img and text  */
-(void)insertImgAndText:(NSUInteger)row imgUrl:(NSString *)imgUrl currentWillReplaceText:(NSString *)currentWillReplaceText nextInsertText:(NSString *)nextInsertText{
    
    
    [self replaceTextOfDatasWithRow:row text:currentWillReplaceText];
    [self insertImgCell:row+1 img:imgUrl];
    [self insertTextCell:row + 2 text:nextInsertText];
    [self initUI];
    [self layoutCellView];
    [self becomeTextCellFirstResponseWithRow:row+2];
    [self moveCursorToLocation:0 row:row +2];
}



/** 以特定下表找到 对应的的cell  如果 为文字 则 将其 置为第一相应 */
-(void)becomeTextCellFirstResponseWithRow:(NSUInteger)row{
    RichEditTextCellView * textCell = self.subviews[row];
    if ([textCell isKindOfClass:[RichEditTextCellView class]]) {
        [textCell textViewbecomeFirstResponse];
    }
}
/** 查看 某一行是 img还是text */
-(RichEditCellViewType )getCellTypeWithRow:(NSUInteger )row{
    RichEditModel * model = _datas[row];
    return model.cellType;
}
/** 删除 某一行 */
-(void)deleteRow:(NSUInteger)row{
    [_datas removeObjectAtIndex:row];
}
/** 把光标移动到 指定的位置 */
-(void)moveCursorToLocation:(NSUInteger )location row:(NSUInteger )row{
    RichEditTextCellView * cellView = self.subviews[row];
    if ([cellView isKindOfClass:[RichEditTextCellView class]]) {
        [cellView moveCursorToLocation:location];
    }
}
/** 当 textCell 的 光标在首位  并且点击删除键时 */
-(void)textCellClearClickAtFirstPlaceAtRow:(NSUInteger )row{
    if (row <= 0) {
        return;
    }
    /** 查看当前 cell 的文字内容 */
    RichEditModel * model = _datas[row];
    NSString * currentText = model.content;
    /** 查看前一个 cell 是什么类型*/
    RichEditModel * beforeModel = _datas[row -1];
    NSString * beforeText = beforeModel.content;
    RichEditCellViewType beforeCellType = beforeModel.cellType;
    
    if (beforeCellType == RichEditCellViewTypeImg || beforeCellType == RichEditCellViewTypeVideo) { // 如果 前一行是图片 或者 商品
        [self deleteRow:row - 1];
        [self initUI];
        [self layoutCellView];
        [self becomeTextCellFirstResponseWithRow:row-1];
        
        [self moveCursorToLocation:0 row:row-1];
    }else{// 如果 前一行是文字
        if(currentText.length == 0)// 如果当前行没有内容
        {
            [self deleteRow:row];
            [self initUI];
            [self layoutCellView];
            [self becomeTextCellFirstResponseWithRow:row - 1];
            
            
        }
        else  //  如果当前行有内容
        {
            
            // 把当前行的 文字 拼接到 上一行的后面  并把当前删除
            [self replaceTextOfDatasWithRow:row -1 text:[beforeModel.content stringByAppendingString:currentText]];
            [_datas removeObjectAtIndex:row];
            [self initUI];
            //  把光标移动到 拼接处
            [self layoutCellView];
            [self becomeTextCellFirstResponseWithRow:row-1];
            
            [self moveCursorToLocation:beforeText.length row:row-1];
            //            [self deleteRow:row];
            
            
        }
    }
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
/** 插入 model  */
-(void)insertModel:(RichEditModel *)model row:(NSUInteger)row currentWillReplaceText:(NSString *)currentWillReplaceText nextInsertText:(NSString *)nextInsertText{
    if (model.cellType == RichEditCellViewTypeText) {
        [self insertTextCell:row text:model.content];
    }
    if (model.cellType == RichEditCellViewTypeImg) {
        [self replaceTextOfDatasWithRow:row text:currentWillReplaceText];
        [self insertImgCell:row+1 img:model.content];
        [self insertTextCell:row + 2 text:nextInsertText];
        
        
        [self initUI];
        [self layoutCellView];
        [self becomeTextCellFirstResponseWithRow:row+2];
        [self moveCursorToLocation:0 row:row +2];
    }
    if (model.cellType == RichEditCellViewTypeVideo) {
        
        
        
        [self replaceTextOfDatasWithRow:row text:currentWillReplaceText];
        [_datas insertObject:model atIndex:row+1];
        [self insertTextCell:row + 2 text:nextInsertText];
        
        
        [self initUI];
        [self layoutCellView];
        [self becomeTextCellFirstResponseWithRow:row+2];
        [self moveCursorToLocation:0 row:row +2];
        
    }
    
}
/** 添加 图片  */
-(void)addImgUrl:(NSString  *)imgUrl{
    // 判断  最后一个 是什么类型的 model
    RichEditModel * lastModel = self.datas.lastObject;
    if (lastModel.cellType != RichEditCellViewTypeText) {
        RichEditModel * textModel = [[RichEditModel alloc]initWithCellType:RichEditCellViewTypeText content:@""];
        [self.datas addObject:textModel];
    }
    RichEditModel * imgModel = [[RichEditModel alloc]initWithCellType:RichEditCellViewTypeImg content:imgUrl];
    [self.datas addObject:imgModel];
    
    RichEditModel * nextModel = [[RichEditModel alloc]initWithCellType:RichEditCellViewTypeText content:@""];
    [self.datas addObject:nextModel];
    
    [self initUI];
    [self layoutCellView];
    
}
/** 添加 视频  */
-(void)addVideoUrl:(NSString  *)videoUrl coverUrl:(NSString *)coverUrl{
    // 判断  最后一个 是什么类型的 model
    RichEditModel * lastModel = self.datas.lastObject;
    if (lastModel.cellType != RichEditCellViewTypeText) {
        RichEditModel * textModel = [[RichEditModel alloc]initWithCellType:RichEditCellViewTypeText content:@""];
        [self.datas addObject:textModel];
    }
    RichEditModel * imgModel = [[RichEditModel alloc]initWithVideoCoverUrl:coverUrl videoUrl:videoUrl];
    [self.datas addObject:imgModel];
    
    RichEditModel * nextModel = [[RichEditModel alloc]initWithCellType:RichEditCellViewTypeText content:@""];
    [self.datas addObject:nextModel];
    
    [self initUI];
    [self layoutCellView];
    
}
/** 获取内容 */
-(NSString *)getContentText{
    NSMutableString * textAtt = [NSMutableString stringWithString:@""];
    
    for (RichEditTextCellView   * view  in self.subviews) {
        if ([view isKindOfClass:[RichEditTextCellView class]]) {
            [textAtt appendString:view.textView.text];
        };
        
    }
    textAtt =[NSMutableString stringWithString:[textAtt stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    textAtt =[NSMutableString stringWithString:[textAtt stringByReplacingOccurrencesOfString:@"\r" withString:@""]];
    return textAtt;
    
}

/** 发布内容为空 */
-(BOOL)isEmpty{
    
    
    //    BOOL isEpy = YES;
    
    
    
    NSMutableString * textAtt = [NSMutableString stringWithString:@""];
    
    for (RichEditTextCellView   * view  in self.subviews) {
        if ([view isKindOfClass:[RichEditTextCellView class]]) {
            [textAtt appendString:view.textView.text];
        };
        
    }
    //    textAtt =[NSMutableString stringWithString:[textAtt stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    textAtt =[NSMutableString stringWithString:[textAtt stringByReplacingOccurrencesOfString:@"\r" withString:@""]];
    
    if (textAtt.length < 2) {
        return YES;
    }
    if ([textAtt isEqualToString:@"请输入店铺故事内容"]) {
        return YES;
    }
    
    return NO;
    
}
/** 发布内容字数 */
-(NSUInteger)getTextCount{
    NSMutableString * textAtt = [NSMutableString stringWithString:@""];
    
    for (RichEditTextCellView   * view  in self.subviews) {
        if ([view isKindOfClass:[RichEditTextCellView class]]) {
            [textAtt appendString:view.textView.text];
        };
        
    }
    //    textAtt =[NSMutableString stringWithString:[textAtt stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    textAtt =[NSMutableString stringWithString:[textAtt stringByReplacingOccurrencesOfString:@"\r" withString:@""]];
    return textAtt.length;
}
/** 获取添加的图片个数 */
-(NSUInteger)getImgsCount{
    NSUInteger goodsCount = 0;
    
    for (RichEditModel  * model  in _datas) {
        NSString * type = [NSString stringWithFormat:@"%lu",(unsigned long)model.cellType];
        if ([type isEqualToString:@"1"]) {
            goodsCount ++;
        }
    }
    return goodsCount;
    
}
/** 获取添加的商品个数 */
-(NSUInteger)getGoodsCount{
    NSUInteger goodsCount = 0;
    
    for (RichEditModel  * model  in _datas) {
        NSString * type = [NSString stringWithFormat:@"%lu",(unsigned long)model.cellType];
        if ([type isEqualToString:@"2"]) {
            goodsCount ++;
        }
    }
    return goodsCount;
}

/** 获取添加视频个数 */
-(NSInteger)getVideoCount{
    NSUInteger goodsCount = 0;
    
    for (RichEditModel  * model  in _datas) {
        NSString * type = [NSString stringWithFormat:@"%lu",(unsigned long)model.cellType];
        if ([type isEqualToString:@"2"]) {
            goodsCount ++;
        }
    }
    return goodsCount;
}
-(void)isbecomeFirst{
    
    
}
-(void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
}
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
}
@end
