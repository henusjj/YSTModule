//
//  AppraiseListM.h
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/26.
//  Copyright © 2018年 yst.com. All rights reserved.
//商品评价和服务评价模型

#import <Foundation/Foundation.h>
@class AppraiseContentN,BiglistGoods;

@interface AppraiseListM : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) AppraiseContentN *content;

@property (nonatomic, assign) NSInteger code;

@end
@interface AppraiseContentN : NSObject

@property (nonatomic, assign) NSInteger countBest;

@property (nonatomic, strong) NSArray<BiglistGoods *> *bigList;

@property (nonatomic, strong) NSArray<BiglistGoods *> *lista;

@property (nonatomic, assign) NSInteger countAll;

@property (nonatomic, assign) NSInteger countLittle;

@property (nonatomic, assign) NSInteger countNo;

@end
#pragma mark - 商品评价列表的小模型(修整以后，服务评价和商品评价合并)
@interface BiglistGoods : NSObject
/*评论内容*/
@property (nonatomic, copy) NSString *content;
/*评论id*/
@property (nonatomic, copy) NSString *commentId;
/*被操作人id（写评论的人的id）*/
@property (nonatomic, copy) NSString *commentMemberId;
/*商品售价*/
@property (nonatomic, copy) NSString *productSalePrice;
/*点赞数*/
@property (nonatomic, copy) NSString *fabulousNum;
/*创建时间*/
@property (nonatomic, copy) NSString *createdTime;
/*图片地址*/
@property (nonatomic, copy) NSString *imgUrl;
/*商品名*/
@property (nonatomic, copy) NSString *productName;
/*回复评论*/
@property (nonatomic, strong) NSArray *returnContent;
/*回复评论的数组（断returnContent）*/
@property (nonatomic, strong) NSArray *arrReturnContent;
/*回复评论的数组（断returnConten高度）*/
@property (nonatomic, assign) CGFloat floatHeight;
/*商品规格*/
@property (nonatomic, copy) NSString *productSpecificationName;
/*是否含有图片 0没有 1 有*/
@property (nonatomic, assign) BOOL isPicture;
/*1*/
@property (nonatomic, copy) NSString *logoAttachmentAddress;
/*评论人昵称*/
@property (nonatomic, copy) NSString *nickname;
/*评论时间*/
@property (nonatomic, copy) NSString *commentTime;
/*评论星级*/
@property (nonatomic, assign) NSInteger startNum;
/*评论图片的张数*/
@property (nonatomic, strong) NSArray *arrPicture;
/*阅读数*/
@property (nonatomic, copy) NSString *readNum;
/*是否点赞*/
@property (nonatomic, assign) BOOL isPraise;

//#pragma mark - 服务评价列表的小模型
//@end@interface listAForServe : NSObject

//@property (nonatomic, copy) NSString *content;
//
//@property (nonatomic, assign) NSInteger commentid;
/*服务价格*/
@property (nonatomic, copy) NSString *servicePrice;
/*服务标题*/
@property (nonatomic, copy) NSString *serviceTitle;
/*购买时间*/
@property (nonatomic, copy) NSString *payTime;

//@property (nonatomic, assign) NSInteger fabulousNum;
//
//@property (nonatomic, copy) NSString *createdTime;
//
//@property (nonatomic, copy) NSString *imgUrl;
//
//@property (nonatomic, copy) NSString *returnContent;
//
//@property (nonatomic, copy) NSString *productSpecificationName;
//
//@property (nonatomic, assign) BOOL isPicture;
//
//@property (nonatomic, copy) NSString *logoAttachmentAddress;
//
//@property (nonatomic, copy) NSString *nickname;
//
//@property (nonatomic, copy) NSString *commentTime;
/*服务id*/
@property (nonatomic, copy) NSString *serviceId;
/*是否是服务:1是，0不是*/
@property (nonatomic, assign) BOOL isServer;

//@property (nonatomic, assign) NSInteger startNum;
//
//@property (nonatomic, assign) NSInteger readNum;

@end


