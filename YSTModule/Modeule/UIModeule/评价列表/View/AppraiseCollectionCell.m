//
//  AppraiseCollectionCell.m
//  PuJiTown
//
//  Created by penglaizhi on 2018/6/26.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "AppraiseCollectionCell.h"

@interface AppraiseCollectionCell ()
/*评价的图片*/
@property (nonatomic,strong) UIImageView *imageV;

@end

@implementation AppraiseCollectionCell
#pragma mark - 重写initWithFrame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_makeupViewForPLZGoodsCollectionCell];
    }
    return self;
}
-(void)p_makeupViewForPLZGoodsCollectionCell
{
    self.imageV = [[UIImageView alloc] init];
    self.imageV.contentMode = UIViewContentModeScaleAspectFill;
    self.imageV.clipsToBounds = YES;
    
    [self.contentView addSubview:self.imageV];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.offset(0);
    }];
}
-(void)setStrUrl:(NSString *)strUrl
{
    _strUrl = strUrl;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"mine_minerelease_thirdimage"]];
}

@end
