//
//  Timer.m
//  YSTModule
//
//  Created by 史玉金 on 2018/7/5.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "Timer.h"

@interface Timer ()
@property(nonatomic,strong)UILabel *timers;
@end

@implementation Timer{
    dispatch_source_t _timer;

}
-(void)viewWillDisappear:(BOOL)animated{
//    销毁计时器
//    if (_timers) {
//        dispatch_source_cancel(_timer);
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"倒计时";
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *timer=[[UILabel alloc]init];//WithFrame:CGRectMake(0, 100, 200, 50)];
    timer.font=[UIFont systemFontOfSize:13];
    timer.layer.borderColor=[UIColor grayColor].CGColor;
    timer.layer.borderWidth = 0.5;
    timer.textColor=[UIColor blueColor];
    timer.layer.cornerRadius=5;
    timer.textAlignment = NSTextAlignmentCenter;
    timer.numberOfLines=0;
    timer.text=@"";
    [self.view addSubview:timer];
    self.timers=timer;
    [self.timers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).mas_offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(20);
    }];

    UILabel *timer1=[[UILabel alloc]init];//WithFrame:CGRectMake(0, 100, 200, 50)];
    timer1.font=[UIFont systemFontOfSize:15];
    timer1.layer.borderColor=[UIColor grayColor].CGColor;
    timer1.layer.borderWidth = 0.5;
    timer1.textColor=[UIColor grayColor];
    timer1.layer.cornerRadius=5;
    timer1.textAlignment = NSTextAlignmentCenter;
    timer1.numberOfLines=0;
    timer1.text=@"手动pop之后,请看控制台.";
    [self.view addSubview:timer1];
    [timer1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-10);
//        make.height.mas_equalTo(20);
    }];
    
    __block int timeout =10;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);//每秒执行
    
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if (timeout<=0) {
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //NSLog(@"计时结束");
                //                [VGNotiCenter postNotificationName:@"orderShixiao" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            
            int minutes = timeout/60;
            
            int seconds = timeout%60;
            //  NSString *strTime = [NSString stringWithFormat:@"%d 分钟 %d 秒", minutes, seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.timers.text = [NSString stringWithFormat:@"剩%d分%d秒自动关闭",minutes,seconds];
                
                //  label.text = [NSString stringWithFormat:@"支付剩余时间  %@",strTime];
            });
            
            timeout--;
            NSLog(@"倒计时=-----%d",timeout);
        }
        
    });
    
    dispatch_resume(_timer);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
