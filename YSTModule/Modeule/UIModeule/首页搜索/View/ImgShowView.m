//
//  ImgShowView.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "ImgShowView.h"

@implementation ImgShowView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)initUI{
    
    [self refreshUI];
}

#pragma mark --

-(void)setImgs:(NSArray<NSDictionary *> *)imgs{
    _imgs = imgs;
    [self refreshUI];

    
}

-(void)refreshUI{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat setY = 0;
    
    
    
    CGFloat space = 5;
    NSInteger column=3;
    
    CGFloat imgW = (self.width + space) /column - space;
    CGFloat imgH = imgW;
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    
    
    //
    for (int i = 0; i < _imgs.count; i ++) {
        NSDictionary * model = _imgs[i];
        
        imgX = i%column * (imgW + space);
        imgY = i/column * (imgH + space);
        if ( _imgs.count == 1) {
            imgW = self.width;
            imgH = self.width * 0.5;
        }
        
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.backgroundColor  =[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:0.8];//[UIColor colorWithR: G:230 B:230 alpha:0.8];
        [self addSubview:imgView];
        imgView.image = [UIImage imageNamed:@"moren"];
//        [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img]] placeholderImage:[UIImage imageNamed:@"moren"]];
        
        setY = imgView.bottom;
        
        
    }
    
    
    self.height = setY;
    if (_heightChangeCallBack) {
        _heightChangeCallBack(self.height);
    }
    
}

@end
