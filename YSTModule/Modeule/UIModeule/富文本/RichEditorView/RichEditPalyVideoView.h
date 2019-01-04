//
//  RichEditPalyVideoView.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RichEditPalyVideoView : UIView
/**
 播放器alloc
 
 @param frame frame
 @param videoUrl 视频地址
 @return 对象
 */
-(instancetype)initWithFrame:(CGRect)frame withVideoUrl:(NSString *)videoUrl;

/** 播放展示 */
-(void)showPlayer;
@end
