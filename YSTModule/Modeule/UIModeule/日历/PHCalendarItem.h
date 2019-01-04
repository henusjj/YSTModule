//
//  PHCalendarItem.h
//  PHPackAge
//
//  Created by wdx on 16/8/10.
//  Copyright © 2016年 wdx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSInteger{
    PHCalendarItemType1=1,
    PHCalendarItemType2=2
} PHCalendarItemType;
@interface PHCalendarItem : UIButton

@property (nonatomic,strong)UIImageView * viewImg;
@property (nonatomic,strong)UIButton     * labelTitle;
//@property (nonatomic,strong)UILabel     * lunarCalendar;


@property (nonatomic,assign)BOOL isToday;
@property (nonatomic,assign)PHCalendarItemType itemType;
@property (nonatomic,assign)NSInteger day;
@property (nonatomic,strong)NSString * lunarDay;


@end
