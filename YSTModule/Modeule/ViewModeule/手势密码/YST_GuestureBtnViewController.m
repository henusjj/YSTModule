//
//  YST_GuestureBtnViewController.m
//  YSTModule
//
//  Created by yst on 2018/7/6.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "YST_GuestureBtnViewController.h"
#import "ZLGuestureLock.h"

@interface YST_GuestureBtnViewController ()
@property (nonatomic, strong) UILabel *label;

@end

@implementation YST_GuestureBtnViewController
-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 50)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        
        
    }
    return _label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.label];
    
    [ZLGuestureLock clearGuestureLockPassword]; //just for test
    
    //Working with delegate:
    //DBGuestureLock *lock = [DBGuestureLock lockOnView:self.view delegate:self];
    
    //Working with block:
    ZLGuestureLock *lock = [ZLGuestureLock lockOnView:self.view onPasswordSet:^(ZLGuestureLock *lock, NSString *password) {
        if (lock.firstTimeSetupPassword == nil) {
            lock.firstTimeSetupPassword = password;
            NSLog(@"varify your password");
            self.label.text = @"Enter your password again:";
        }
    } onGetCorrectPswd:^(ZLGuestureLock *lock, NSString *password) {
        if (lock.firstTimeSetupPassword && ![lock.firstTimeSetupPassword isEqualToString:ZLFirstTimeSetupPassword]) {
            lock.firstTimeSetupPassword = ZLFirstTimeSetupPassword;
            NSLog(@"password has been setup!");
            self.label.text = @"password has been setup!";
        } else {
            NSLog(@"login success");
            self.label.text = @"login success!";
        }
    } onGetIncorrectPswd:^(ZLGuestureLock *lock, NSString *password) {
        if (![lock.firstTimeSetupPassword isEqualToString:ZLFirstTimeSetupPassword]) {
            NSLog(@"Error: password not equal to first setup!");
            self.label.text = @"Not equal to first setup!";
        } else {
            NSLog(@"login failed");
            self.label.text = @"login failed!";
        }
    }];
    
    [self.view addSubview:lock];
    
    self.label.text = @"Please set your password:"; //for test
    [self.view setBackgroundColor:[UIColor colorWithRed:0.133 green:0.596 blue:0.933 alpha:1.00]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
