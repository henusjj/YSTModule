//
//  TypeVC.m
//  AnimationDemo
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "TypeVC.h"

@interface TypeVC ()

@end

@implementation TypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:165.0/255.0 green:225.0/255.0 blue:234.0/255.0 alpha:0.9];
    [self initPublicType];
    [self initPrivateType];
}


-(void)initPublicType{
    NSArray * titleArr = @[@"fade",@"push",@"moveIn",@"reveal"];
    for (int i=0; i<4; i++) {
        CGFloat btnWidth = (ScreenWidth-gap*2-gap)/2;
        UIButton *btn = [Tools createBtnTitle:[titleArr objectAtIndex:i] Selector:@selector(PublicTypeClick:) target:self];
        btn.frame = CGRectMake(gap+(btnWidth+gap)*(i%2), 80+(i/2)*(btnHeight+20), btnWidth, btnHeight);
        btn.tag = i;
        [self.view addSubview:btn];
    }
}

-(void)initPrivateType{
    UIButton * lastBtn = [self.view viewWithTag:3];
    NSArray * titleArr = @[@"cube",@"oglFlip",@"suckEffect",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"];
    for (int i=0; i<8; i++) {
        CGFloat btnWidth = (ScreenWidth-gap*2-gap)/2;
        UIButton *btn = [Tools createBtnTitle:[titleArr objectAtIndex:i] Selector:@selector(PrivateTypeClick:) target:self];
        btn.frame = CGRectMake(gap+(btnWidth+gap)*(i%2), lastBtn.frame.origin.y+btnHeight+50+(i/2)*(btnHeight+20), btnWidth, btnHeight);
        btn.tag = i;
        [self.view addSubview:btn];
    }
}

//公有Type
-(void)PublicTypeClick:(UIButton *)btn{
    NSString * type;
    switch (btn.tag) {
        case 0:
            type = @"fade";
            break;
        case 1:
            type = @"push";
            break;
        case 2:
            type = @"moveIn";
            break;
        case 3:
            type = @"reveal";
            break;
        default:
            break;
    }
    CATransition *animation2 = [CATransition animation];
    animation2.duration = 1.0f;
    animation2.type =  type;
    animation2.subtype = kCATransitionFromRight;
    animation2.fillMode = kCAFillModeForwards;
    animation2.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [self.view.layer addAnimation:animation2 forKey:@"animation"];
}


//私有Type
-(void)PrivateTypeClick:(UIButton *)btn{
    NSString * type;
    switch (btn.tag) {
        case 0:
            type = @"cube";
            break;
        case 1:
            type = @"oglFlip";
            break;
        case 2:
            type = @"suckEffect";
            break;
        case 3:
            type = @"rippleEffect";
            break;
        case 4:
            type = @"pageCurl";
            break;
        case 5:
            type = @"pageUnCurl";
            break;
        case 6:
            type = @"cameraIrisHollowOpen";
            break;
        case 7:
            type = @"cameraIrisHollowClose";
            break;
        default:
            break;
    }
    CATransition *animation2 = [CATransition animation];
    animation2.duration = 1.0f;
    animation2.type =  type;
    animation2.subtype = kCATransitionFromRight;
    animation2.fillMode = kCAFillModeForwards;
    animation2.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [self.view.layer addAnimation:animation2 forKey:@"animation"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
