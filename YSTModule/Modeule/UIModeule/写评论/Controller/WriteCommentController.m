//
//  WriteCommentController.m
//  YSTModule
//
//  Created by 冯亮亮 on 2018/7/10.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "WriteCommentController.h"
#import "WriteCommentView.h"

@interface WriteCommentController ()
@property(nonatomic,strong)WriteCommentView *writeCommentView;
@end

@implementation WriteCommentController
-(WriteCommentView *)writeCommentView
{
    if (!_writeCommentView) {
        _writeCommentView = [[WriteCommentView alloc] init];
    }
    return _writeCommentView;
}
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor redColor];
    [super viewDidLoad];
    
    self.writeCommentView.frame = CGRectMake(0, kScreenHeight - 64 - 50, kScreenWidth, 50);
    [self.view addSubview:self.writeCommentView];
    // Do any additional setup after loading the view.
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
