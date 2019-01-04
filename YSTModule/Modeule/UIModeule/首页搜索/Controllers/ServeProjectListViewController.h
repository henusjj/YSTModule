//
//  ServeProjectListViewController.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeSearchPageViewController.h"
@interface ServeProjectListViewController : UIViewController
@property (nonatomic,weak)HomeSearchPageViewController * pageVC;
@property (nonatomic,strong)NSString * keyWord;
@end
