//
//  RichEditModel.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "RichEditModel.h"

@implementation RichEditModel
-(instancetype)initWithCellType:(RichEditCellViewType )cellType content:(NSString *)content{
    if (self=[super init]) {
        
        _cellType = cellType;
        _content  = content;
    }
    return self;
}
-(instancetype)initWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl{
    if (self = [super init]) {
        _cellType = RichEditCellViewTypeVideo;
        _content = videoUrl;
        _videoCoverUrl = videoCoverUrl;
        _videoUrl = videoUrl;
        
    }
    return self;
}
@end
