//
//  PLZQRCodeViewController.h
//  YSTNewGreatWallMedium
//
//  Created by penglaizhi on 2017/12/14.
//  Copyright © 2017年 zhubiao. All rights reserved.
//我的二维码
//传入一个模型即可生成二维码

#import <UIKit/UIKit.h>
//#import "PLZBaseViewController.h"
#import "PLZMineM.h"//示例模型
#import "SGQRCode.h"
@interface PLZQRCodeViewController : UIViewController
/*通过传模型完成赋值操作*/
@property (nonatomic,strong) DataMine *datMine;

@end
