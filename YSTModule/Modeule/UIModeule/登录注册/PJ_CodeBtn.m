//
//  PJ_CodeBtn.m
//  PuJiTown
//
//  Created by 李晨芳 on 2018/2/23.
//  Copyright © 2018年 yst.com. All rights reserved.
//

#import "PJ_CodeBtn.h"

@implementation PJ_CodeBtn

-(void)TheGetCodeDown:(UIColor *)titleColor withSecondColor:(UIColor *)color WithSeconds:(NSInteger)TotalSeconds{
    if (TotalSeconds <= 0) {
        return;
    }
    __block NSInteger time = TotalSeconds-1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:@"重新发送" forState:UIControlStateNormal];
                [self setTitleColor:color forState:UIControlStateNormal];
                //  [self.layer setBorderColor:titleColor.CGColor];
                [self setUserInteractionEnabled:YES];
            });
        }else{
            int seconds = time % (int)TotalSeconds;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"%.2d秒后重发", seconds] forState:UIControlStateNormal];
                [self setTitleColor:color forState:UIControlStateNormal];
                [self setUserInteractionEnabled:NO];
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end
