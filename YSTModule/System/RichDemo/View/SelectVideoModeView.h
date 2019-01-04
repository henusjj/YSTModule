//
//  SelectVideoModeView.h
//  健桥
//
//  Created by 冯亮亮 on 2018/1/2.
//  Copyright © 2018年 yst-fll. All rights reserved.
//  点击添加视频的加号弹出来的选择框

#import <UIKit/UIKit.h>
@class SelectVideoModeView;
@protocol SelectVideoModeViewDelegete <NSObject>
@optional
//点击拍摄(直接返回视频相关参数)
-(void)shotActionReturnArr:(NSMutableArray *)array;
//取消按钮代理事件
-(void)videoCancelButton;
//传递上传成功之后传递拼接好的参数
-(void)passModelType:(NSString *)modelType urlStr:(NSString *)urlStr;

@end
@interface SelectVideoModeView : UIView
@property(nonatomic, assign)id<SelectVideoModeViewDelegete>delegete;
@property(nonatomic, strong)UIView *backView;//背景
@property(nonatomic, strong)UIImageView *shotImageView;//拍摄
@property(nonatomic, strong)UIImageView *localImageView;//本地
@property(nonatomic, strong)UILabel *shotLabel;//拍摄label
@property(nonatomic, strong)UILabel *localLabel;//本地label
@property(nonatomic, strong)UIButton *shotButton;//拍摄按钮
@property(nonatomic, strong)UIButton *localButton;//本地按钮
@property(nonatomic, strong)UIButton *cancelButton;//取消按钮


@end
