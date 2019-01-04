//
//  ActionSheetViewController.m
//  YSTModule
//
//  Created by penglaizhi on 2018/6/28.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "ActionSheetViewController.h"
#import "ActionSheetAView.h"
#import "TZImagePickerController.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define SCALE_WIDTH  kScreenWidth/375.f //适配比例


@interface ActionSheetViewController ()
/*选择头像alert*/
@property (nonatomic,strong) UIView *viewSheet;

/*展示选中的图片*/
@property (nonatomic,strong) UIImageView *imageV;

@property (nonatomic,strong) UIImagePickerController *imagePickerVc;
/*返回按钮*/
@property (nonatomic,strong) UIButton *buttonBack;
@end


@implementation ActionSheetViewController
-(UIView *)viewSheet
{
    if (_viewSheet==nil) {
        _viewSheet = [ActionSheetAView creatActionSheetViewWithTitle:@"提示" otherTitles:@[@"从手机相册选择",@"相机"] cancleTitle:@"关闭" delegate:nil];
    }
    return _viewSheet;
}
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        if (iOS7Later) {
            _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        }
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *testButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 40)];
    testButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [testButton setBackgroundColor:[UIColor greenColor]];
    [testButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    testButton.spaceIL = 5;
    [testButton setTitle:[NSString stringWithFormat:@"选择图片"] forState:UIControlStateNormal];
//    [testButton setImage:[UIImage imageNamed:@"购物车_选中"] forState:UIControlStateNormal];
    [self.view addSubview:testButton];
    [testButton addTarget:self action:@selector(buttonActionInActionVC) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 200, 150, 150)];
    self.imageV.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.imageV];
    
//    self.buttonBack = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    [self.buttonBack setTitle:@"back" forState:(UIControlStateNormal)];
//    [self.buttonBack setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.buttonBack];
//    [self.buttonBack addTarget:self action:@selector(buttonBackActionINActionSheetVC) forControlEvents:(UIControlEventTouchUpInside)];
    
    // Do any additional setup after loading the view.
}
-(void)buttonBackActionINActionSheetVC
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - 底部提示框回调代理
-(void)buttonTitleActionInViewSheetAction:(UIButton *)sender
{
    //    NSLog(@"点击的是第tag=%ld的button",sender.tag);
    [self.viewSheet removeFromSuperview];
    
    switch (sender.tag) {
        case 359:
        {
            
        }
            break;
        case 360:
        {
            NSLog(@"打开相册");
            [self pushTZImagePickerController:@"1"];
        }
            break;
        case 361:
        {
            NSLog(@"打开相机");
            [self pushToCamera];
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark - 修改头像
-(void)editIconAction
{
//    self.dicPramLZ = [self.teamContent mj_keyValues];
//    [[NetworkTool shareInstance] postWithUrl:PJ_API_editMyManagerTeamMessage paramWithDic:self.dicPramLZ success:^(id responseObject) {
//        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        upLoadFileM *loadM = [upLoadFileM mj_objectWithKeyValues:dic];
//        [JKAlert alertText:loadM.msg];
//        [IMNetModel changeUserIconWithPicUrl:loadM.content success:^(id  _Nonnull responObject) {
//            NSLog(@"头像同步到im成功");
//        } failure:^(id  _Nonnull responObject) {
//            NSLog(@"头像同步到im失败");
//
//        }];
//    } failure:^(NSError *error) {
//
//    }];
//
}
#pragma mark - 选择图片
- (void)pushTZImagePickerController:(NSString *)index{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = YES;
    //    imagePickerVc.
    //    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
#pragma mark - 到这里为止
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    WeakSelf(self)
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        //        [weakSelf dismiss];
        if (photos.count > 0) {
            UIImage * image = [photos firstObject];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"index"] = index;
            dic[@"image"] = image;
            self.imageV.image = image;

//            [self upLoadImageInVC:image];
//            UIButton *button = (UIButton *)[self.viewEditView viewWithTag:998];
//            [button setImage:image forState:(UIControlStateNormal)];
        }
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(void)pushToCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
    
}
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        //        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.imageV.image = image;
//        UIButton *button = (UIButton *)[self.viewEditView viewWithTag:998];
//        [self upLoadImageInVC:image];
//        [button setImage:image forState:(UIControlStateNormal)];
        
        //        self.imageIcon = image;
        // save photo and get asset / 保存图片，获取到asset
        
    }
}

-(void)buttonActionInActionVC
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.viewSheet];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endMeng)];
    [self.viewSheet addGestureRecognizer:tap];

}
-(void)endMeng
{
    
}
//-(void)upLoadImageInVC:(
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
