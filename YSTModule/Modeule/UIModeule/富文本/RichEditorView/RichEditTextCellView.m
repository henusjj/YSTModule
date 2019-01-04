//
//  RichEditTextCellView.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "RichEditTextCellView.h"

@interface RichEditTextCellView ()<UITextViewDelegate>

@end

@implementation RichEditTextCellView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    _textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _textView.scrollEnabled = NO;
    //    _textView.inputAccessoryView = [self textToolView];
    _textView.font = [UIFont systemFontOfSize:17];
    _textView.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    _textView.delegate = self;
    [self addSubview:_textView];
}
/** 计算高度 */
-(void)calculateHeight{
    [_textView sizeToFit];
    _textView.width = self.width;
    if (_textView.height < 20) {
        _textView.height = 20;
    }
    
    self.height = _textView.bottom;
    
    
    if (_textChange) {
        _textChange(_textView.text,self.row);
        NSLog(@"%lu ::  %@",(unsigned long)self.row,_textView.text);
        
    }
}
-(void)setModel:(RichEditModel *)model{
    [super setModel:model];
    _textView.text = model.content;
    [self calculateHeight];
}
-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    
    if (_placeHolder) {
        _textView.placeholder = placeHolder;
    }
}


#pragma mark -- textView toolView
-(UIView *)textToolView{
    UIView * textToolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    textToolView.backgroundColor =[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    
    CGFloat btnW = 25;
    for (int i = 0; i < 2; i ++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        //        btn.backgroundColor = [UIColor whiteColor];
        [textToolView addSubview:btn];
        btn.centerY = textToolView.height / 2;
        btn.right   = textToolView.width - 10 - ((btnW + 20)* i);
        [btn setBackgroundImage:[UIImage imageNamed:i == 0 ? @"pict":@"shop"] forState:UIControlStateNormal];
        
        btn.tag = 100 + i;
        
        [btn addTarget:self action:@selector(toolViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return textToolView;
}
#pragma mark -- btnClick
-(void)toolViewBtnClick:(UIButton *)sender{
    NSRange cursorRange = [self selectedRangeInTextView:_textView];
    NSString * currentReplaceText = [_textView.text substringToIndex:cursorRange.location];
    NSString * nextText = [_textView.text substringFromIndex:cursorRange.location + cursorRange.length];
    if (_insert) {
        _insert(self.row,sender.tag,currentReplaceText,nextText);
    }
    
    
    //    if (sender.tag == 100) {
    //        PHImagePickerController * imgPikcer =[PHImagePickerController new];
    //        imgPikcer.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //        [((UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController) presentViewController:imgPikcer animated:YES completion:^{
    //        }];
    //        imgPikcer.block = ^(UIImage *image) {
    //            if (_insertImg) {
    //
    //                _insertImg(self.row,@"http://img.wanchezhijia.com/A/2015/5/6/9/48/c6344b4e-07a8-48a4-b5b9-b08cc7269d62.jpg",currentReplaceText,nextText);
    //            }
    //
    //        };
    //    }
    //    if (sender.tag == 101) {
    //
    //    }
    
}

/** 获取 textView 的光标位置 */
- (NSRange) selectedRangeInTextView:(UITextView*)textView
{
    UITextPosition* beginning = textView.beginningOfDocument;
    
    UITextRange* selectedRange = textView.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [textView offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [textView offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}
/** 把光标 移动到指定的位置 */
-(void)moveCursorToLocation:(NSUInteger)location{
    
    self.textView.selectedRange = NSMakeRange(location,0);
}
-(void)textViewbecomeFirstResponse{
    [_textView becomeFirstResponder];
}

#pragma  mark -- textView delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //    textView.text = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSRange cursorRange = [self selectedRangeInTextView:_textView];
    if (cursorRange.location == 0 && text.length == 0) {
        
        if (_clearAtFirstPlace) {
            _clearAtFirstPlace(self.row);
        }
        return NO;
    }
    //    [self calculateHeight];
    
    return YES;
}
-(void)textViewDidChange:(PlaceholderTextView *)textView{
    [self calculateHeight];
    
    if (textView.hasText) { // textView.text.length
        textView.placeholder = @"";
        
    } else {
        textView.placeholder=_placeHolder;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:_placeHolder]){
        textView.text=@"";
    }
}

@end
