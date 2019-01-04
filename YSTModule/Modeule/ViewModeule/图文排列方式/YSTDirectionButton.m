//
//  YSTDirectionButton.m
//  ShopCarListDemo
//
//  Created by penglaizhi on 2018/6/13.
//  Copyright © 2018年 决心. All rights reserved.
//

#import "YSTDirectionButton.h"

@implementation YSTDirectionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setType:(buttonImageType)type
{
    _type = type;
    if (self.spaceIL==0) {
        self.spaceIL = 5;
    }
    /* 获取按钮文字的宽度 获取按钮图片和文字的间距 获取图片宽度 */
    CGFloat space = self.spaceIL;// 图片和文字的间距
    
    NSString *titleString = self.titleLabel.text;
    CGFloat titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width;
    CGFloat titleHeight = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].height;
    UIImage * btnImage = self.imageView.image;// 11*6
    CGFloat imageWidth = btnImage.size.width;
    CGFloat imageHeight = btnImage.size.height;

    /*当然，为了防止文字内容过多，要做一点预防*/
    CGFloat btnWidth = self.frame.size.width;//按钮的宽度
    if (titleWidth > btnWidth - imageWidth - space) {
        titleWidth = btnWidth- imageWidth - space;
    }
    
    switch (type) {
        case 1:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -self.spaceIL, 0, 0)];

        }
            break;
        case 2:
        {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth+space*0.5), 0, (imageWidth+space*0.5))];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, (titleWidth + space*0.5), 0, -(titleWidth + space*0.5))];

        }
            break;
        case 3:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(-(imageHeight*0.5 + space*0.5), titleWidth*0.5, imageHeight*0.5 + space*0.5, -titleWidth*0.5)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(titleHeight*0.5 + space*0.5, -imageWidth*0.5, -(titleHeight*0.5 + space*0.5), imageWidth*0.5)];

        }
            break;
        case 4:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake((imageHeight*0.5 + space*0.5), titleWidth*0.5, -imageHeight*0.5 - space*0.5, -titleWidth*0.5)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(-titleHeight*0.5 - space*0.5, -imageWidth*0.5, (titleHeight*0.5 + space*0.5), imageWidth*0.5)];

        }
            break;

        default:
            break;
    }

}

@end
