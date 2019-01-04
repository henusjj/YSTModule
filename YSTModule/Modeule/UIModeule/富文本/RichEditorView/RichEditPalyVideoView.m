//
//  RichEditPalyVideoView.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "RichEditPalyVideoView.h"
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"

#define SCREEN_WIDTH      [UIScreen mainScreen].bounds.size.width //屏宽
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height //屏高


@interface RichEditPalyVideoView ()
@property (nonatomic,copy)NSString *videoUrl;//播放地址
@property (nonatomic, strong) SelVideoPlayer *player;//播放器
@end

@implementation RichEditPalyVideoView

//初始化View
-(instancetype)initWithFrame:(CGRect)frame withVideoUrl:(NSString *)videoUrl{
    if (self = [super initWithFrame:frame]) {
        _videoUrl = videoUrl;
        [self addView];
    }
    return self;
}
//布局UI
-(void)addView{
    
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0;
    
    //退出播放器按钮
    
    UIButton *closeButton =[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 40, 40)];
    [closeButton setImage:[UIImage imageNamed:@"G_Back_0"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
//    [QuickControlTool createButtonWithFrame:CGRectMake(10, 30, 40, 40) backgroundColor:[UIColor clearColor] title:nil titleColor:nil font:nil image:@"G_Back_0" imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) target:self action:@selector(closeButtonClick)];
    [self addSubview:closeButton];
    
    //播放器
    SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
    configuration.shouldAutoPlay = YES;     //自动播放
    configuration.supportedDoubleTap = YES;     //支持双击播放暂停
    configuration.shouldAutorotate = YES;   //自动旋转
    configuration.repeatPlay = YES;     //重复播放
    configuration.statusBarHideState = SelStatusBarHideStateFollowControls;     //设置状态栏隐藏
    configuration.sourceUrl = [NSURL URLWithString:_videoUrl];     //设置播放数据源
    configuration.videoGravity = SelVideoGravityResizeAspect;   //拉伸方式
    
    CGFloat width = self.frame.size.width;
    _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(0, 100, width, 300) configuration:configuration];
    _player.center =self.center;
    [self addSubview:_player];
    
}
//退出播放器方法
-(void)closeButtonClick{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT, 0, 0);
    }completion:^(BOOL finished) {
        [_player _deallocPlayer];
        [self removeFromSuperview];
    }];
    
}
//播放器展示动画
-(void)showPlayer{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.alpha =1;
    }completion:^(BOOL finished) {
        
    }];
}

@end
