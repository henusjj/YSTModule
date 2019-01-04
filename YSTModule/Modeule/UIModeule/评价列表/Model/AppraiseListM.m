//
//  AppraiseListM.m
//  PuJiTown
//
//  Created by penglaizhi on 2018/5/26.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "AppraiseListM.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例
@implementation AppraiseListM

@end

@implementation AppraiseContentN
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"bigList":[BiglistGoods class],@"lista":[BiglistGoods class]};
}
@end

@implementation BiglistGoods
-(void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = imgUrl;
    self.arrPicture = [imgUrl componentsSeparatedByString:@","];
    
}
-(void)setCommentTime:(NSString *)commentTime
{
    _commentTime = commentTime;
    if (commentTime.length==16) {
        return;
    }
    if (commentTime.length>16) {
        _commentTime = [commentTime substringToIndex:16];
    }else{
        _commentTime = [self getDateStringWithTimeStr:commentTime dateStyle:@"yyyy-MM-dd HH:mm"];

    }

}
-(void)setCreatedTime:(NSString *)createdTime
{
    _createdTime = createdTime;
    if (createdTime.length==16) {
        return;
    }

    if (createdTime.length>16) {
        _createdTime = [createdTime substringToIndex:16];
    }else{
        _createdTime = [self getDateStringWithTimeStr:createdTime dateStyle:@"yyyy-MM-dd HH:mm"];
    }
}
-(void)setPayTime:(NSString *)payTime
{
    _payTime = payTime;
    if (payTime.length==16) {
        return;
    }

    if (payTime.length==13) {
       _createdTime = [self getDateStringWithTimeStr:payTime dateStyle:@"yyyy-MM-dd HH:mm"];
    }

}
// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
- (NSString *)getDateStringWithTimeStr:(NSString *)str dateStyle:(NSString *)dateStyle {
    NSTimeInterval time=[str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SS"];
    [dateFormatter setDateFormat:dateStyle];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

-(void)setReturnContent:(NSArray *)returnContent
{
    _returnContent = returnContent;
    self.arrReturnContent = returnContent;
//    self.arrReturnContent = [returnContent componentsSeparatedByString:@","];
    
    for (int i = 0; i<self.arrReturnContent.count; i++) {
        CGSize size = CGSizeMake(kScreenWidth-61-50*SCALE_WIDTH, MAXFLOAT);//设置高度宽度的最大限度
        CGRect rect = [self.arrReturnContent[i] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil];
        CGFloat cellHeight = rect.size.height;
        if (cellHeight<13&&cellHeight>0) {
            cellHeight = 13;
        }
        self.floatHeight = self.floatHeight+cellHeight;
        
    }
}
@end

//@implementation listAForServe
//
//@end

