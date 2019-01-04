//
//  ActionSheetAView.h
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/22.
//  Copyright © 2018年 yst.com. All rights reserved.
//自定义选择图片（照片）弹框

#import <UIKit/UIKit.h>
//typedef void (^selectButtonForActionSheet)(NSInteger index);

@interface ActionSheetAView : UIView

//@property (nonatomic,copy) selectButtonForActionSheet selectButton;
//-(instancetype)creatActionSheetViewWithTitle:(NSString *)title otherTitles:(NSArray *)array cancleTitle:(NSString *)cancleTitle delegate:(id)delegate;

+(UIView *)creatActionSheetViewWithTitle:(NSString *)title otherTitles:(NSArray *)array cancleTitle:(NSString *)cancleTitle delegate:(id)delegate;


@end
