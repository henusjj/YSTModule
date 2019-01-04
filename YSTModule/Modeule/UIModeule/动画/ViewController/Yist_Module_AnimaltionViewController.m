//
//  Yist_Module_AnimaltionViewController.m
//  YSTModule
//
//  Created by WHISPERS on 2018/6/14.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "Yist_Module_AnimaltionViewController.h"

#import "CATransitionVC.h"
#import "BasicAnimationVC.h"
#import "KeyFrameAnimation.h"
#import "AnimationGroupVC.h"

#import "UIViewAnimationVC.h"

#import "CAEmitterVC.h"

@interface Yist_Module_AnimaltionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)       UITableView *animaltionTypeList;

@end

@implementation Yist_Module_AnimaltionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"动画";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *buttonVack = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [buttonVack setTitle:@"back" forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonVack];
    [buttonVack addTarget:self action:@selector(buttonBackN) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.animaltionTypeList];
    [self.animaltionTypeList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)buttonBackN{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(UITableView *)animaltionTypeList{
    if (!_animaltionTypeList) {
        _animaltionTypeList = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _animaltionTypeList.delegate = self;
        _animaltionTypeList.dataSource = self;
        _animaltionTypeList.tableFooterView = [UIView new];
    }
    return _animaltionTypeList;
}

#pragma mark TableView delegate&dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:{
            
            return 4;
        }
            break;
        case 1:{
            
            return 1;
        }
            break;
        case 2:{
            
            return 1;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH, 30)];
    typeLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    switch (section) {
        case 0:
        {
            typeLabel.text = @"CAAnimation";
        }
            break;
        case 1:{
            typeLabel.text = @"UIView动画";
        }
            break;
        case 2:{
            typeLabel.text = @"Emitter(粒子)动画";
        }
            break;
        default:
            break;
    }
    
    return typeLabel;
    
}

//行的高度
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}

//绘制Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *identifier=@"Yist_IM_AnimationIdentifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
                {
                    cell.textLabel.text = @"CATransition";
                }
                break;
            case 1:{
                cell.textLabel.text = @"CABasicAnimation";
            }
                break;
            case 2:{
                cell.textLabel.text = @"KeyFrameAnimation";
            }
                break;
            case 3:{
                cell.textLabel.text = @"CAAnimationGroup";
            }
                break;
            default:
                break;
        }
        
    }else if (indexPath.section == 1){
        
       cell.textLabel.text = @"UIView动画";
        
    }else if (indexPath.section == 2){
            cell.textLabel.text = @"粒子动画";
    }

    
    return cell;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {
                CATransitionVC *CATransition = [[CATransitionVC alloc]init];
                [self.navigationController pushViewController:CATransition animated:YES];
                
            }
                break;
            case 1:{
                BasicAnimationVC *BasicAnimation = [[BasicAnimationVC alloc]init];
                [self.navigationController pushViewController:BasicAnimation animated:YES];
            }
                break;
            case 2:{
                KeyFrameAnimation *KeyFrameAnimationVc = [[KeyFrameAnimation alloc]init];
                [self.navigationController pushViewController:KeyFrameAnimationVc animated:YES];
            }
                break;
            case 3:{
                AnimationGroupVC *AnimationGroup = [[AnimationGroupVC alloc]init];
                [self.navigationController pushViewController:AnimationGroup animated:YES];
            }
                break;
            default:
                break;
        }
        
    }else if (indexPath.section == 1){
        
        UIViewAnimationVC *UIViewAnimation = [[UIViewAnimationVC alloc]init];
        [self.navigationController pushViewController:UIViewAnimation animated:YES];
    }else if (indexPath.section == 2){
    
        CAEmitterVC *CAEmitter = [[CAEmitterVC alloc] init];
        [self.navigationController pushViewController:CAEmitter animated:YES];
        
    }
    
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
