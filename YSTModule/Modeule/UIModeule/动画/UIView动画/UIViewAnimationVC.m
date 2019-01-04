//
//  UIViewAnimationVC.m
//  AnimationDemo
//
//  Created by WHISPERS on 2018/6/13.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "UIViewAnimationVC.h"

@interface UIViewAnimationVC (){
    UIImageView * imageView;
}

@end

@implementation UIViewAnimationVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIView动画";
    imageView = [[UIImageView alloc]init];
    [self.view addSubview:imageView];
    
    UIButton *btn1 = [Tools createBtnTitle:@"block动画" Selector:@selector(AnimationWithBlocks) target:self];
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = [Tools createBtnTitle:@"commit动画" Selector:@selector(AnimationCommit) target:self];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [Tools createBtnTitle:@"KeyframeAnimations" Selector:@selector(KeyframeAnimations) target:self];
    [self.view addSubview:btn3];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@gap);
        make.right.equalTo(@-gap);
        make.top.equalTo(self.view.mas_top).offset(80);
        make.height.mas_equalTo(btnHeight);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.mas_bottom).offset(20);
        make.left.equalTo(@gap);
        make.right.equalTo(@-gap);
        make.height.mas_equalTo(btnHeight);
    }];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn2.mas_bottom).offset(20);
        make.left.equalTo(@gap);
        make.right.equalTo(@-gap);
        make.height.mas_equalTo(btnHeight);
    }];

}

-(void)AnimationWithBlocks{
    /*
     //简单动画
     imageView.frame = CGRectMake(0, (ScreenHeight-image.size.height)/2,image.size.width,image.size.height)
     
     [UIView animateWithDuration:1.0 animations:^{
     
     imageView.frame = CGRectMake(ScreenWidth/2-25, ScreenHeight/2-50, 50, 50);
     
     }];
     */
    
    //连续动画
    UIImage * image = [UIImage imageNamed:@"icon1"];
    
    [imageView setImage:image];
    
    imageView.frame = CGRectMake(0, (SCREEN_HEIGHT-image.size.height)/2,image.size.width,image.size.height);
    
    [UIView animateWithDuration:1.0f animations:^{
        //动画终点
        imageView.frame = CGRectMake(ScreenWidth-image.size.width, (SCREEN_HEIGHT-image.size.height)/2, image.size.width, image.size.height);
        
    } completion:^(BOOL finished) {
        
        UIImage * image = [UIImage imageNamed:@"icon2"];
        
        [imageView setImage:image];
        
        //view最终状态（UIView会从动画结束状态转换到此处设定的状态，在转换过程中没有动画效果）
        imageView.frame = CGRectMake(ScreenWidth-image.size.width, (SCREEN_HEIGHT-image.size.height)/2, image.size.width, image.size.height);
    }];

}

-(void)AnimationCommit{
    UIImage * image = [UIImage imageNamed:@"icon1"];
    
    [imageView setImage:image];
    
    //动画开始前视图状态
    imageView.frame = CGRectMake((SCREEN_WIDTH-image.size.width)/2, (SCREEN_HEIGHT-image.size.height)/2,image.size.width,image.size.height);
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1.0f];
    
    image = [UIImage imageNamed:@"icon2"];
    
    [imageView setImage:image];
    
    //视图最终状态
    imageView.frame = CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT-50, 50, 50);
    
    [UIView commitAnimations];
}

-(void)KeyframeAnimations{
    UIImage * image = [UIImage imageNamed:@"icon2"];
    
    [imageView setImage:image];
    
    imageView.frame = CGRectMake(0, (ScreenHeight+image.size.height)/2,image.size.width,image.size.height);
    
    CGRect rect1 = CGRectMake((ScreenWidth-image.size.width)/2, (ScreenHeight+image.size.height)/2,image.size.width,image.size.height);

    CGRect rect2 = CGRectMake((ScreenWidth-image.size.width)/2, (ScreenHeight+image.size.height)/2+100,image.size.width,image.size.height);
    
    CGRect rect3 = CGRectMake(ScreenWidth-image.size.width, (ScreenHeight+image.size.height)/2+100,image.size.width,image.size.height);

    CGRect rect4 = CGRectMake(ScreenWidth-image.size.width, (ScreenHeight+image.size.height)/2,image.size.width,image.size.height);

    
    [UIView animateKeyframesWithDuration:4.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
         [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
             
             imageView.frame = rect1;
             self.view.backgroundColor = [UIColor yellowColor];

         }];
        
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
            
            
            imageView.frame = rect2;
            self.view.backgroundColor = [UIColor purpleColor];

        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            
            imageView.frame = rect3;
            self.view.backgroundColor = [UIColor blueColor];
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            
            imageView.frame = rect4;
            self.view.backgroundColor = [UIColor whiteColor];

        }];

    } completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
