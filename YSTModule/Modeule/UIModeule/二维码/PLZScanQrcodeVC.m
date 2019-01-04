//
//  PLZScanQrcodeVC.m
//  YSTNewGreatWallMedium
//
//  Created by penglaizhi on 2017/12/14.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "PLZScanQrcodeVC.h"
#import "PLZQRCodeViewController.h"
//#import "PLZMineViewController.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽

@interface PLZScanQrcodeVC ()<SGQRCodeScanManagerDelegate, SGQRCodeAlbumManagerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) SGQRCodeScanManager *manager;
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@property (nonatomic, strong) UIButton *flashlightBtn;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;
@property (nonatomic, strong) UIView *bottomView;
@property (strong,nonatomic) UIButton *buttonMine;
@end

@implementation PLZScanQrcodeVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
    [self.manager startRunning];
    [_manager resetSampleBufferDelegate];
    [self.view bringSubviewToFront:self.buttonMine];
    [self.view bringSubviewToFront:self.promptLabel];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
//    [self removeFlashlightBtn];
    [self.manager stopRunning];
    [_manager cancelSampleBufferDelegate];
}

- (void)dealloc {
    NSLog(@"SGQRCodeScanningVC - dealloc");
    [self removeScanningView];
}
#pragma mark - 加载完成viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scanningView];
    [self setupNavigationBar];
    [self setupQRCodeScanning];
    [self.view addSubview:self.promptLabel];
    [self.view addSubview:self.buttonMine];
    /// 为了 UI 效果
    [self.view addSubview:self.bottomView];
    [self plzForPopAction];
//    [self.view addSubview:self.flashlightBtn];
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"扫一扫";
    [self PlzBaseMakeUpViewForButtonRight];
    
    [self.buttonRight setTitle:@"" forState:(UIControlStateNormal)];
    [self.buttonRight setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.buttonRight addTarget:self action:@selector(rightBarButtonItenAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
    
}

- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[SGQRCodeScanningView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.9 * self.view.frame.size.height)];
        //        _scanningView.scanningImageName = @"SGQRCode.bundle/QRCodeScanningLineGrid";
        //        _scanningView.scanningAnimationStyle = ScanningAnimationStyleGrid;
        //        _scanningView.cornerColor = [UIColor orangeColor];
    }
    return _scanningView;
}
- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

- (void)rightBarButtonItenAction {
    SGQRCodeAlbumManager *manager = [SGQRCodeAlbumManager sharedManager];
    [manager readQRCodeFromAlbumWithCurrentController:self];
    manager.delegate = self;
    
    if (manager.isPHAuthorization == YES) {
        [self.scanningView removeTimer];
    }
}

- (void)setupQRCodeScanning {
    self.manager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [_manager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    //    [manager cancelSampleBufferDelegate];
    _manager.delegate = self;
}

#pragma mark - - - SGQRCodeAlbumManagerDelegate相册代理
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(SGQRCodeAlbumManager *)albumManager {
    [self.view addSubview:self.scanningView];
}
- (void)QRCodeAlbumManager:(SGQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    
    NSLog(@"扫描结果：%@",result);
    if (result.length<1) {
        //        [self.view makeToast:@"未能扫描到该结果，请确认是新长城二维码" duration:2 position:CSToastPositionCenter];
        //    }
        //    if ([result containsString:@"mobile/personMsg/getHomePage"]) {
        //        UIViewController *vc = [PLZ_Tool getCurrentVC];
        //        LFY_UserLoginModel * userLoginModel = [LFY_UserLoginModel userLoginModel];
        //
        NSLog(@"women 包含 bitch");
        //        PLZMineViewController *mineVC = [[PLZMineViewController alloc] init];
        //
        //        NSString *strUrl = result;
        //        NSRange rang1 = [strUrl rangeOfString:@"memberId="];
        //        NSRange rang2 = [strUrl rangeOfString:@"&"];
        //
        //        NSUInteger loca1 = rang1.location+rang1.length;
        //        NSUInteger length1 = rang2.location-loca1;
        //
        //        NSString *memberId = [strUrl substringWithRange:NSMakeRange(loca1, length1)];
        //        if ([userLoginModel.memberId isEqualToString:memberId]) {
        //            mineVC.isOther = NO;
        //        }else{
        //            mineVC.isOther = YES;
        //        }
        //
        //        mineVC.memberId = memberId;
        //        [vc.navigationController pushViewController:mineVC animated:YES];
        
    } else {
        
        NSLog(@"women 不存在 bitch");
        //        [[UIApplication sharedApplication].keyWindow makeToast:result duration:3 position:CSToastPositionCenter];
    }
    
    //    if ([result hasPrefix:@"http"]) {
    //        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
    //        jumpVC.jump_URL = result;
    //        [self.navigationController pushViewController:jumpVC animated:YES];
    //
    //    } else {
    //        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
    //        jumpVC.jump_bar_code = result;
    //        [self.navigationController pushViewController:jumpVC animated:YES];
    //    }
}
-(void)delayMethod
{
    //    if (self.checkM.code==0) {
    //        [self.manager startRunning];
    
    //    }else{
    //        [self.manager stopRunning];
    //
    //    }
    
    BOOL result =  [[self getCurrentVC] isKindOfClass:[PLZScanQrcodeVC class]];
    if (result) {
        [self.manager startRunning];
        
    }else{
        [self.manager stopRunning];
        
    }
    
}
#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager palySoundName:@"SGQRCode.bundle/sound.caf"];
        [scanManager stopRunning];
        [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
        
        
        //        [scanManager videoPreviewLayerRemoveFromSuperlayer];
        //        LFY_UserLoginModel * userLoginModel = [LFY_UserLoginModel userLoginModel];
        //
        //        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        //        PLZMineViewController *mineVC = [[PLZMineViewController alloc] init];
        //        //        NSString *strU = @"https://itunes.apple.com/us/app/%E5%A4%A9%E6%98%93/id1275454279?l=zh&ls=1&mt=8";
        //        //        if ([strU isEqualToString:[obj stringValue]]) {
        //        //
        //        //        }
        //        NSString *strUrl = [obj stringValue];
        //        NSRange rang1 = [strUrl rangeOfString:@"memberId="];
        //        NSRange rang2 = [strUrl rangeOfString:@"&"];
        //        //        NSRange rang3 = [strUrl rangeOfString:@"homePage="];
        //
        //        NSUInteger loca1 = rang1.location+rang1.length;
        //        NSUInteger length1 = rang2.location-loca1;
        //
        //        //        NSUInteger loca2 = rang3.location+rang3.length;
        //        //        NSUInteger length2 = strUrl.length-loca2;
        //
        //        NSString *memberId = [strUrl substringWithRange:NSMakeRange(loca1, length1)];
        //        //        NSString *HomePage = [strUrl substringWithRange:NSMakeRange(loca2, length2)];
        //        if ([userLoginModel.memberId isEqualToString:memberId]) {
        //            mineVC.isOther = NO;
        //        }else{
        //            mineVC.isOther = YES;
        //        }
        //        mineVC.memberId = memberId;
        //        [self.navigationController pushViewController:mineVC animated:YES];
        //        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
        //        jumpVC.jump_URL = [obj stringValue];
        //        [self.navigationController pushViewController:jumpVC animated:YES];
    } else {
        
        NSLog(@"暂未识别出扫描的二维码");
        //        [self.view makeToast:@"未能识别该二维码" duration:1 position:CSToastPositionCenter];
    }
}
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager brightnessValue:(CGFloat)brightnessValue {
//    if (brightnessValue < - 1) {
//        [self.view addSubview:self.flashlightBtn];
//    } else {
//        if (self.isSelectedFlashlightBtn == NO) {
//            [self removeFlashlightBtn];
//        }
//    }
}
-(UIButton *)buttonMine
{
    
    if (_buttonMine==nil) {
        _buttonMine = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _buttonMine.frame = CGRectMake(kScreenWidth/2-51, CGRectGetMaxY(self.promptLabel.frame)+20, 102, 36);
        _buttonMine.layer.masksToBounds = YES;
        _buttonMine.layer.cornerRadius = 18;
        _buttonMine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        //        _buttonMine.titleLabel.font = [UIFont fontWithName:PingFangRegular size:14];
        [_buttonMine setTitle:@"我的二维码" forState:(UIControlStateNormal)];
        [_buttonMine setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_buttonMine addTarget:self action:@selector(buttonMineAction) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _buttonMine;
}
- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        CGFloat promptLabelX = 0;
        CGFloat promptLabelY = 0.67 * self.view.frame.size.height;
        CGFloat promptLabelW = self.view.frame.size.width;
        CGFloat promptLabelH = 25;
        _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        //        _promptLabel.font = [UIFont fontWithName:PingFangLight size:11];
        _promptLabel.textColor = [UIColor whiteColor];
        _promptLabel.text = @"将二维码放入框内，可自动扫描，加关注";
    }
    return _promptLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scanningView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.scanningView.frame))];
        _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _bottomView;
}

#pragma mark - - - 闪光灯按钮
- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
        // 添加闪光灯按钮
        _flashlightBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        CGFloat flashlightBtnW = 150;
        CGFloat flashlightBtnH = 150;
        CGFloat flashlightBtnX = 0.5 * (self.view.frame.size.width - flashlightBtnW);
        CGFloat flashlightBtnY = 0.85 * self.view.frame.size.height;
        [_flashlightBtn setTitle:@"闪光灯" forState:(UIControlStateNormal)];
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
//        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"lightOn@2x"] forState:(UIControlStateNormal)];
//        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"lightOff@2x"] forState:(UIControlStateSelected)];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtn_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlightBtn;
}

- (void)flashlightBtn_action:(UIButton *)button {
    if (button.selected == NO) {
        [SGQRCodeHelperTool SG_openFlashlight];
        self.isSelectedFlashlightBtn = YES;
        button.selected = YES;
    } else {
        [self removeFlashlightBtn];
    }
}

- (void)removeFlashlightBtn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SGQRCodeHelperTool SG_CloseFlashlight];
        self.isSelectedFlashlightBtn = NO;
        self.flashlightBtn.selected = NO;
//        [self.flashlightBtn removeFromSuperview];
    });
}
#pragma mark - 查看我的二维码
-(void)buttonMineAction
{
    PLZQRCodeViewController *QRCodeVC = [[PLZQRCodeViewController alloc] init];
    DataMine *dataM = [[DataMine alloc] init];
    dataM.memberName = @"张三";
    dataM.company = @"易商通";
    dataM.job = @"攻城狮";
    QRCodeVC.datMine = dataM;
    [self.navigationController pushViewController:QRCodeVC animated:YES];
    
}


//-(void)tapEndEditAction
//{
////    [self.view endEditing:YES];
//}
-(void)PlzBaseMakeUpViewForButtonRight
{
    UIButton *buttonRight= [UIButton buttonWithType:(UIButtonTypeCustom)];
    buttonRight.frame = CGRectMake(0, 0, 60, 40);
    [buttonRight setTitle:@"发布" forState:(UIControlStateNormal)];
    //    [buttonRight setTitleColor:[UIColor ColorWithString:@"#FB3C3C"] forState:(UIControlStateNormal)];
    //    buttonRight.titleLabel.font = [UIFont fontWithName:PingFangRegular size:15];
    self.buttonRight = buttonRight;
    [buttonRight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];
    
}
//返回
-(void)plzForPopAction
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 24, 44);
    //    [button setImage:[UIImage imageNamed:@"back_img"] forState:(UIControlStateNormal)];
    [button setTitle:@"返回" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonActionInBase) forControlEvents:(UIControlEventTouchUpInside)];
    self.buttonLeft = button;
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    //    button.backgroundColor = [UIColor yellowColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
#pragma mark - 模态返回
-(void)buttonActionInBase
{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - 获取当前控制器-优化在扫码页跳转时的性能
- (UIViewController *)getCurrentVC
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

@end
