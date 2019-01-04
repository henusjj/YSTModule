//
//  PLZMineM.h
//  YSTNewGreatWallMedium
//
//  Created by penglaizhi on 2018/1/9.
//  Copyright © 2018年 zhubiao. All rights reserved.
//”我的“model

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DataMine;


@interface PLZMineM : NSObject

@property (nonatomic, assign) BOOL success;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) DataMine *data;

@property (nonatomic, assign) NSInteger count;

@end

@interface DataMine : NSObject

@property (nonatomic, copy) NSString *fansCount;//粉丝数

@property (nonatomic, copy) NSString *vip;//会员标识

@property (nonatomic, copy) NSString *qA;//问答数

@property (nonatomic, copy) NSString *videoCount;//视频数

@property (nonatomic, copy) NSString *liveCount;//直播数

@property (nonatomic, copy) NSString *company;//公司

@property (nonatomic, copy) NSString *address;//地址

@property (nonatomic, copy) NSString *informationCount;//咨询数

@property (nonatomic, copy) NSString *nickName;//会员昵称

@property (nonatomic, copy) NSString *focusCount;//关注数

@property (nonatomic, copy) NSString *memberId;//id

@property (nonatomic, copy) NSString *memberName;//名字

@property (nonatomic, copy) NSString *job;//职位

@property (nonatomic, copy) NSString *introduce;//描述

@property (nonatomic, copy) NSString *logo;//头像

@property (nonatomic, copy) NSString *homePage;//主页id

@property (nonatomic, copy) NSString *tag;//标签

@property (nonatomic, copy) NSString *memberType;//是否高级会员，1：是

@property (nonatomic,assign) BOOL isOther;

@property (nonatomic,assign) CGFloat heightForDes;//全部简介高度

@property (nonatomic,assign) CGFloat heightForDesIfPlay;//播放视频的时候

@property (nonatomic,copy) NSString *status;//关注状态、0未关注，1已关注，2互相关注

@property (nonatomic,copy) NSString *videoUrl;//视频地址、

@property (nonatomic,strong) NSArray *imgUrl;//图册数组

@property (nonatomic, strong) NSString *uuid;
@end
