//
//  PLZScanQrcodeVC.h
//  YSTNewGreatWallMedium
//
//  Created by penglaizhi on 2017/12/14.
//  Copyright © 2017年 zhubiao. All rights reserved.
//二维码扫描(复杂)
///使用说明：1.本控制器和PLZQRCodeViewController控制器相关联，这个是扫描，后者是自己的二维码展示，其中使用了一个数据模型，建议保持使用；2.包括处理扫描结果、识别相册内二维码、开启手机灯光等功能，对应方法都有注释，只需在里面实现即可。

#import <UIKit/UIKit.h>
#import "SGQRCode.h"
@interface PLZScanQrcodeVC : UIViewController

@property (nonatomic,strong) UIButton *buttonRight;

@property (nonatomic,strong) UIButton *buttonLeft;

//需要点击view退出编辑的，重写这个方法
//-(void)tapEndEditAction;

//返回按钮事件
-(void)plzForPopAction;

//右边按钮的点击事件
-(void)PlzBaseMakeUpViewForButtonRight;

//@property (nonatomic) int new11111;

@end
