//
//  RichEditModel.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,RichEditCellViewType) {
    RichEditCellViewTypeText = 0,
    RichEditCellViewTypeImg = 1,
    // 为 适应项目 添加的 视频类型
    RichEditCellViewTypeVideo = 2,
};
@interface RichEditModel : NSObject
-(instancetype)initWithCellType:(RichEditCellViewType )cellType content:(NSString *)content;
-(instancetype)initWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl;
@property (nonatomic,strong)NSString * content;

@property (nonatomic,assign)RichEditCellViewType cellType;

// 为 适应项目 添加的 商品类型 所对应的 属性
@property (nonatomic,strong)NSString *  goodsId;
@property (nonatomic,strong)NSString *  goodsName;
@property (nonatomic,strong)NSString *  goodsImgUrl;
@property (nonatomic,strong)NSString *  goodsPrice;


// 为 适应项目 添加的 视频类型 所对应的 属性
@property (nonatomic,strong)NSString *  videoUrl;
@property (nonatomic,strong)NSString *  videoCoverUrl;
@end
