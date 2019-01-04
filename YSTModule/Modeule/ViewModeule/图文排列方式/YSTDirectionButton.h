//
//  YSTDirectionButton.h
//  ShopCarListDemo
//
//  Created by penglaizhi on 2018/6/13.
//  Copyright © 2018年 决心. All rights reserved.
//

#import <UIKit/UIKit.h>


/*图片的位置：1左，2右，3上，4下*/
typedef NS_ENUM(NSInteger, buttonImageType)
{
    imageLeft  = 1,
    imageRight,
    imageTop,
    imageBottom
};

@interface YSTDirectionButton : UIButton
/*图片和文字的间距*/
@property (nonatomic,assign) CGFloat spaceIL;
/*排列类型*/
@property (nonatomic,assign) buttonImageType type;

@end
