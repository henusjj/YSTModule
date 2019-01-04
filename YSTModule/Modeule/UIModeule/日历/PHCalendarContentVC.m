//
//  PHCalendarContentVC.m
//  PHPackAge
//
//  Created by wdx on 16/8/9.
//  Copyright © 2016年 wdx. All rights reserved.
//

#import "PHCalendarContentVC.h"
#import "PHCalendarItem.h"
#define selectedDaySet @"selectedDaySet"
#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseFestival @[@"除夕",@"春节",@"中秋",@"五一",@"国庆",@"儿童",@"圣诞",@"七夕",@"端午"]

#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]

#define ChineseWeatherFestival @[@"立春",@"雨水",@"惊蛰",@"春分",@"清明",@"谷雨",@"立夏",@"小满",@"忙种",@"夏至",@"小暑",@"大暑",@"立秋",@"处暑",@"寒露",@"霜降",@"白露",@"秋分",@"立冬",@"小雪",@"大雪",@"冬至",@"小寒",@"大寒"]

@interface PHCalendarContentVC ()
@property (nonatomic,strong)UIScrollView * contentScroll;
@property (nonatomic,strong)NSUserDefaults * userDefaults;
@end

@implementation PHCalendarContentVC

+(instancetype)instantMonthPageWithCurrentYear:(NSInteger )year andMonth:(NSInteger)month{
    PHCalendarContentVC * phCalendar=[PHCalendarContentVC new];
    phCalendar.currentYear=year;
    phCalendar.currentMonth=month;
    return phCalendar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self newView];
    
    // Do any additional setup after loading the view.
}
-(void)loadData{
     _userDefaults=[NSUserDefaults standardUserDefaults];
    _days=[self totalDaysInMonthOfDate:[NSDate date]];
    _dayOfWeekOfFirstDay=[self weekdayOfFirstDayInDate];

}
-(void)newView{
    self.view.backgroundColor = [UIColor whiteColor];

    CGFloat setY=0;
    CGFloat itemW=(self.view.width-20)/7;
    for (int i =(int)_dayOfWeekOfFirstDay-1; i < _days+_dayOfWeekOfFirstDay-1; i ++) {
        CGFloat x=i % 7 * itemW + 10;
        CGFloat y=i / 7 * itemW +0;
        PHCalendarItem * item=[[PHCalendarItem alloc]initWithFrame:CGRectMake(x, y, itemW, itemW)];
        item.layer.cornerRadius=itemW/2;
        item.layer.borderColor=self.view.backgroundColor.CGColor;
        item.layer.borderWidth=5;
        item.layer.masksToBounds=YES;
       
        item.day=(NSInteger)i-_dayOfWeekOfFirstDay+2;

        [item addTarget:self action:@selector(itemBtn:) forControlEvents:UIControlEventTouchUpInside];
        setY=item.bottom;
        item.selected=[self judgeIsSelected:item];
        
        NSString * dateString=[NSString stringWithFormat:@"%ld-%ld-%ld",(long)_currentYear,(long)_currentMonth,i-_dayOfWeekOfFirstDay+2];
//        item.lunarDay=[self chineseCalendarOfDate:[self getDayWithString:dateString]];
   
        
        if ([[self getDayWithString:dateString] isEqualToDate:[self nowDate]]) {
            item.isToday=YES;
        }
        
         [self.view addSubview:item];
    }
}
-(BOOL)judgeIsSelected:(PHCalendarItem *)sender{
   NSMutableArray * dayArray=[_userDefaults valueForKey:selectedDaySet];
    
    for (NSMutableDictionary * dayDic in dayArray) {
        if ([[NSString stringWithFormat:@"%@",[dayDic valueForKey:@"year"]] integerValue]==_currentYear) {
            if ([[NSString stringWithFormat:@"%@",[dayDic valueForKey:@"month"]] integerValue]==_currentMonth) {
                if ([[NSString stringWithFormat:@"%@",[dayDic valueForKey:@"day"]] integerValue]==sender.day) {
                    return YES;
                }
            }
        }
    }
    return NO;
}
-(void)itemBtn:(PHCalendarItem *)sender{

    NSMutableArray * dayArray=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]valueForKey:selectedDaySet]];
    if (!dayArray) {
        dayArray=[NSMutableArray array];
    }

    NSString * dayString=[NSString stringWithFormat:@"%ld",(long)sender.day];
    NSString * monthString=[NSString stringWithFormat:@"%ld",(long)_currentMonth];
    NSString * yearString=[NSString stringWithFormat:@"%ld",(long)_currentYear];
    NSMutableDictionary * dayDic=[NSMutableDictionary dictionaryWithDictionary:@{@"day":dayString,@"month":monthString,@"year":yearString}];
    
    if (sender.selected) {
        [dayArray removeObject:dayDic];
    }else{
        [dayArray addObject:dayDic];
    }
    [_userDefaults setObject:dayArray forKey:selectedDaySet];
    
    sender.selected=!sender.selected;
}


// 获取date当前月的第一天是星期几
- (NSInteger)weekdayOfFirstDayInDate {
    
    NSString * dateString=[NSString stringWithFormat:@"%ld-%ld-%d",(long)_currentYear,(long)_currentMonth,01];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[self getDayWithString:dateString]];
    [components setDay:1];

    NSDate *firstDate = [calendar dateFromComponents:components];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDate];
    return firstComponents.weekday;
}
// 获取date当前月的总天数
- (NSInteger)totalDaysInMonthOfDate:(NSDate *)date {
    NSString * dateString=[NSString stringWithFormat:@"%ld-%ld-%d",(long)_currentYear,(long)_currentMonth,01];
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self getDayWithString:dateString]];
    return range.length;
}
// 根据字符串 获取对应的天
-(NSDate *)getDayWithString:(NSString *)dayString{
    NSDateFormatter * fo=[NSDateFormatter new];
    [fo setDateFormat:@"yyyy-MM-dd"];
    fo.timeZone=[NSTimeZone timeZoneForSecondsFromGMT:8*3600];
    NSDate * date1=[fo dateFromString:dayString];
    return date1;
}
// 获取当前天
-(NSDate *)nowDate{

    NSDateFormatter * fo=[[NSDateFormatter alloc]init];
    [fo setDateFormat:@"yyyy-MM--dd"];
    NSString * dateString=[fo stringFromDate:[NSDate date]];
    fo.timeZone=[NSTimeZone timeZoneForSecondsFromGMT:8*3600];
    NSDate * date=[fo dateFromString:dateString];
    return date;
}


- (NSString *)chineseCalendarOfDate:(NSDate *)date {
    
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    //NSString *dayDate;
    
    NSCalendar *normalDate = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *Datecomponents = [normalDate components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    NSString * lunarDay;
    
    if (components.day ==1 ) {
        lunarDay =ChineseMonths[components.month -1];
    } else {
        lunarDay =ChineseDays[components.day -1];
        
    }
    
    //农历节日

    if (components.day ==1 && components.month ==1) {
        
        lunarDay = [NSString stringWithFormat:@"%@",ChineseFestival[1]]; //春节
        
    } if(components.month ==8 && components.day ==15){
        
        lunarDay = [NSString stringWithFormat:@"%@",ChineseFestival[2]];//中秋
        
    }else if(components.day ==1 && components.month ==1){
        
        lunarDay = [NSString stringWithFormat:@"%@",ChineseFestival[0]];//除夕
        
    }else if(components.month ==7 && components.day ==7){
        
        lunarDay = [NSString stringWithFormat:@"%@",ChineseFestival[7]];//七夕
        
    }else if(components.month ==5 && components.day ==5){
        
        lunarDay = [NSString stringWithFormat:@"%@",ChineseFestival[8]];//端午
        
    }
    
    //阳历节日
    
    if (Datecomponents.month ==6 && Datecomponents.day ==1) {       //儿童节
        
        lunarDay = [NSString stringWithFormat:@"%@",ChineseFestival[5]];
        
    }else if(Datecomponents.month ==10 && Datecomponents.day ==1){  //国庆节
        
        lunarDay = [NSString stringWithFormat:@"%@",ChineseFestival[4]];
        
    }else if(Datecomponents.month ==5 && Datecomponents.day ==1){   //劳动节
        
        lunarDay = [NSString stringWithFormat:@"%@",ChineseFestival[3]];
        
    }else if(Datecomponents.month ==12 && Datecomponents.day ==25){ //圣诞节
        
        lunarDay = [NSString stringWithFormat:@"%@",ChineseFestival[6]];
        
    }
    
    
    
    
//    [self getLunarSpecialDate:Datecomponents.year Month:Datecomponents.month Day:Datecomponents.day];
    
    //除夕另外提出放在所有节日的末尾执行，除夕是在春节前一天，即把components当天时间前移一天，放在所有节日末尾，避免其他节日全部前移一天
    
    NSTimeInterval timeInterval_day =60 * 60 *24;
    
    NSDate *nextDay_date = [NSDate dateWithTimeInterval:timeInterval_day sinceDate:date];
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    
    unsigned unitFlags =NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit;
    
    components = [localeCalendar components:unitFlags fromDate:nextDay_date];
    
    if ( 1 == components.month &&1 == components.day ) {
        return @"除夕";
    }
    return lunarDay;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
