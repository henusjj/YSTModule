//
//  SelectVideoModeView.m
//  健桥
//
//  Created by 冯亮亮 on 2018/1/2.
//  Copyright © 2018年 yst-fll. All rights reserved.
//  点击添加视频的加号弹出来的选择框

#import "SelectVideoModeView.h"
//#import "VideoModel.h"
//视频录制和从相册获取相册
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreMedia/CoreMedia.h>
@interface SelectVideoModeView()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, assign) BOOL shouldAsync;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,copy)NSString *shotOrLib;

@end
@implementation SelectVideoModeView
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}
#pragma mark===== 底部的view
-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
    }
    return _backView;
}
#pragma mark===== 拍摄
-(UIImageView *)shotImageView
{
    if (!_shotImageView) {
        _shotImageView = [[UIImageView alloc] init];
        _shotImageView.image = [UIImage imageNamed:@"shot"];
        _shotImageView.contentMode = UIViewContentModeScaleAspectFill;
        _shotImageView.clipsToBounds = YES;
    }
    return _shotImageView;
}
#pragma mark===== 拍摄
-(UILabel *)shotLabel
{
    if (!_shotLabel) {
        _shotLabel = [[UILabel alloc] init];
        _shotLabel.text = @"拍摄";
        _shotLabel.textColor = [UIColor colorWithRed:0.40f green:0.40f blue:0.40f alpha:1.00f];
        _shotLabel.font = [UIFont fontWithName:@"STXihei" size:11];
        _shotLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _shotLabel;
}
#pragma mark===== 拍摄
-(UIButton *)shotButton
{
    if (!_shotButton) {
        _shotButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _shotButton.backgroundColor = [UIColor clearColor];
        [_shotButton addTarget:self action:@selector(shotButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _shotButton;

}
#pragma mark===== 本地
-(UIImageView *)localImageView
{
    if (!_localImageView) {
        _localImageView = [[UIImageView alloc] init];
        _localImageView.image = [UIImage imageNamed:@"local"];
        _localImageView.contentMode = UIViewContentModeScaleAspectFill;
        _localImageView.clipsToBounds = YES;
    }
    return _localImageView;
}
#pragma mark===== 本地
-(UILabel *)localLabel
{
    if (!_localLabel) {
        _localLabel = [[UILabel alloc] init];
        _localLabel.text = @"本地";
        _localLabel.textColor = [UIColor colorWithRed:0.40f green:0.40f blue:0.40f alpha:1.00f];
        _localLabel.font = [UIFont fontWithName:@"STXihei" size:11];
        _localLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _localLabel;
}
#pragma mark===== 本地按钮
-(UIButton *)localButton
{
    if (!_localButton) {
        _localButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _localButton.backgroundColor = [UIColor clearColor];
        [_localButton addTarget:self action:@selector(localButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _localButton;
}
#pragma mark===== 本地按钮
-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _cancelButton.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
        [_cancelButton setTitle:@"取 消" forState:(UIControlStateNormal)];
        [_cancelButton setTitleColor:[UIColor colorWithRed:0.11f green:0.11f blue:0.11f alpha:1.00f] forState:(UIControlStateNormal)];
        [_cancelButton.titleLabel setFont:[UIFont fontWithName:@"STXihei" size:15]];
        [_cancelButton addTarget:self action:@selector(cancelButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _cancelButton;
}
#pragma mark===== frame
-(void)creatUI
{
    self.backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 240);
    [self addSubview:self.backView];

    self.shotImageView.frame = CGRectMake(SCREEN_WIDTH/2 - 100 , 50 , 66, 66 );
    [self.backView addSubview:self.shotImageView];
    
    
    self.shotLabel.frame = CGRectMake(CGRectGetMinX(self.shotImageView.frame), CGRectGetMaxY(self.shotImageView.frame), self.shotImageView.frame.size.width, 40 );
    [self.backView addSubview:self.shotLabel];

    
    self.shotButton.frame = CGRectMake(CGRectGetMinX(self.shotImageView.frame), CGRectGetMinY(self.shotImageView.frame), self.shotImageView.frame.size.width, self.shotImageView.frame.size.height + self.shotLabel.frame.size.height);
    [self.backView addSubview:self.shotButton];

 //本地
    self.localImageView.frame = CGRectMake(SCREEN_WIDTH/2 + 34, 50, 66, 66);
    [self.backView addSubview:self.localImageView];

    self.localLabel.frame =  CGRectMake(CGRectGetMinX(self.localImageView.frame), CGRectGetMaxY(self.localImageView.frame), self.localImageView.frame.size.width, 40);
    [self.backView addSubview:self.localLabel];


    self.localButton.frame = CGRectMake(CGRectGetMinX(self.localImageView.frame), CGRectGetMinY(self.localImageView.frame), self.localImageView.frame.size.width, self.localImageView.frame.size.height + self.localLabel.frame.size.height);
    [self.backView addSubview:self.localButton];

    self.cancelButton.frame = CGRectMake(0, 190, SCREEN_WIDTH, 50);
    [self.backView addSubview:self.cancelButton];


}

//取消按钮代理事件
-(void)cancelButton:(UIButton *)sender
{
    if (self.delegete && [self.delegete respondsToSelector:(@selector(videoCancelButton))]) {
        [self.delegete videoCancelButton];
    }
};
#pragma mark===== 拍摄的点击方法
-(void)shotButton:(UIButton *)sender
{
    [self.delegete videoCancelButton];

    // 7.0
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted
        || authStatus == AVAuthorizationStatusDenied) {
        NSLog(@"摄像头已被禁用，您可在设置应用程序中进行开启");
        return;
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.videoQuality = UIImagePickerControllerQualityType640x480; //录像质量
        picker.videoMaximumDuration = 1 * 60.0f; // 限制视频录制最多不超过1分钟
        picker.mediaTypes = @[(NSString *)kUTTypeMovie];
        [[self getCurrentVC] presentViewController:picker animated:YES completion:NULL];
        self.shouldAsync = YES;
        self.shotOrLib = @"拍摄";
    } else {
        NSLog(@"手机不支持摄像");
    }
}
#pragma mark===== 本地的点击方法
-(void)localButton:(UIButton *)sender
{
    [self.delegete videoCancelButton];

    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted
        || authStatus == AVAuthorizationStatusDenied) {
        NSLog(@"摄像头已被禁用，您可在设置应用程序中进行开启");
        return;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.videoMaximumDuration = 1 * 60.0f; // 限制视频录制最多不超过1分钟
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.mediaTypes = @[(NSString *)kUTTypeMovie];
        [[self getCurrentVC] presentViewController:picker animated:YES completion:NULL];
        self.shouldAsync = NO;
        self.shotOrLib = @"相册";

    } else {
        NSLog(@"手机不支持摄像");
    }

}

#pragma  mark - UIImagePickerControllerDelegate
// 获取视频完成后要执行的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self.dataArray removeAllObjects];
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
            Float64 duration = CMTimeGetSeconds(videoAsset.duration);
            CGFloat videoTime = duration;
            
            if (videoTime < 5) {
//                [[UIApplication sharedApplication].keyWindow makeToast:@"视频不能少于5s" duration:1.5 position:CSToastPositionCenter];
                return ;
            }
            // Begin to compress and export the video to the output path(开始压缩并将视频导出到输出路径)
            NSDateFormatter* formater = [[NSDateFormatter alloc] init];
            [formater setDateFormat:@"yyyyMMddHHmmss"];
            NSString *name = [NSString stringWithFormat:@"%@.mp4",[formater stringFromDate:[NSDate date]]];
            [self compressVideoWithVideoURL:videoURL savedName:name completion:^(NSString *savedPath) {
                if (savedPath) {
                    if ([self.shotOrLib isEqualToString:@"拍摄"]) {
                        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                        [library writeVideoAtPathToSavedPhotosAlbum:videoURL
                                                    completionBlock:^(NSURL *assetURL, NSError *error) {
                                                        if (error) {
                                                            NSLog(@"Save video fail:%@",error);
                                                        } else {
                                                            NSLog(@"Save video succeed.");
                                                        }
                                                    }];

                    }
                    NSLog(@"Compressed successfully. path: %@", savedPath);
                    //删除沙盒中的视频.
                    [self cleanCachesVideo:savedPath];
                    
                    
                    NSMutableDictionary *videoDic = [NSMutableDictionary dictionaryWithCapacity:0];
                    
                    [videoDic setObject:savedPath forKey:@"videoUrl"];
                    [videoDic setObject:[self frameImageFromVideoURL:videoURL] forKey:@"firstImg"];
//                    VideoModel *Model = [VideoModel new];
//                    Model.videoUrl = videoURL;
//                    Model.videoTime = videoTime;
//                    Model.frameDiagram = [self frameImageFromVideoURL:videoURL];
//                    Model.videoMp4Url = savedPath;
//                    Model.isSelectVideo = YES;
//                    [self.dataArray addObject:Model];
                        [self.dataArray addObject:videoDic];

                    [self.delegete shotActionReturnArr:self.dataArray];
                } else {
                    NSLog(@"Compressed failed");
                }
            }];
        });
        
    });
    
}
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo {
    
    NSLog(@"%@",videoPath);
    
    NSLog(@"%@",error);
    
}


//把录制的视频保存到相册
- (void)compressVideoWithVideoURL:(NSURL *)videoURL
                        savedName:(NSString *)savedName
                       completion:(void (^)(NSString *savedPath))completion {
    // Accessing video by URL(通过URL访问视频)
    AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    // Find compatible presets by video asset.(通过视频资产找到兼容的预置)
    NSArray *presets = [AVAssetExportSession exportPresetsCompatibleWithAsset:videoAsset];
    // Begin to compress video(开始压缩视频)
    // Now we just compress to low resolution if it supports(现在我们只是压缩到低分辨率，如果它支持)
    // If you need to upload to the server, but server does't support to upload by streaming,//如果你需要上传到服务器，但是服务器不支持通过流上传
    // You can compress the resolution to lower. Or you can support more higher resolution.//您可以将分辨率压缩到更低。或者你可以支持更高的分辨率。
    if ([presets containsObject:AVAssetExportPreset640x480]) {
        AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:videoAsset  presetName:AVAssetExportPreset640x480];
        
        NSString *doc = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //        NSString *folder = [doc stringByAppendingPathComponent:@"HYBVideos"];//(再往Documents目录下创建一个folder文件夹)
        BOOL isDir = NO;
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:doc isDirectory:&isDir];
        if (!isExist || (isExist && !isDir)) {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:doc
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
            if (error == nil) {
                NSLog(@"目录创建成功");
            } else {
                NSLog(@"目录创建失败");
            }
        }
        NSString *outPutPath = [doc stringByAppendingPathComponent:savedName];
        session.outputURL = [NSURL fileURLWithPath:outPutPath];
        // Optimize for network use.(优化网络使用。)
        session.shouldOptimizeForNetworkUse = true;
        //转换视频到mp4格式
        NSArray *supportedTypeArray = session.supportedFileTypes;
        if ([supportedTypeArray containsObject:AVFileTypeMPEG4]) {
            session.outputFileType = AVFileTypeMPEG4;
        } else if (supportedTypeArray.count == 0) {
            NSLog(@"No supported file types");
            return;
        } else {
            session.outputFileType = [supportedTypeArray objectAtIndex:0];
        }
        // Begin to export video to the output path asynchronously.(开始将视频导出到输出路径异步。)
        [session exportAsynchronouslyWithCompletionHandler:^{
            if ([session status] == AVAssetExportSessionStatusCompleted) {
                NSLog(@"AVAssetExportSessionStatusCompleted---转换成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion([session.outputURL path]);
                        NSLog(@"---------------------------------------------------%@",[session.outputURL path]);
                    }
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(nil);
                    }
                });
            }
        }];
    }
}
//清空缓存中数据
-(void)cleanCachesVideo:(NSString *)videoPath{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:videoPath]) {
        [fileManager createDirectoryAtPath:videoPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:videoPath error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        [fileManager removeItemAtPath:[videoPath stringByAppendingPathComponent:filename] error:NULL];
    }
}


//获取视频的第一帧图片
// Get the video's center frame as video poster image
- (UIImage *)frameImageFromVideoURL:(NSURL *)videoURL {
    // result
    UIImage *image = nil;
    
    // AVAssetImageGenerator
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    // calculate the midpoint time of video
    Float64 duration = CMTimeGetSeconds([asset duration]);
    // 取某个帧的时间，参数一表示哪个时间（秒），参数二表示每秒多少帧
    // 通常来说，600是一个常用的公共参数，苹果有说明:
    // 24 frames per second (fps) for film, 30 fps for NTSC (used for TV in North America and
    // Japan), and 25 fps for PAL (used for TV in Europe).
    // Using a timescale of 600, you can exactly represent any number of frames in these systems
    //    CMTime midpoint = CMTimeMakeWithSeconds(duration/0, 600);
    CMTime midpoint = CMTimeMakeWithSeconds(0.0, 600);
    
    // get the image from
    NSError *error = nil;
    CMTime actualTime;
    // Returns a CFRetained CGImageRef for an asset at or near the specified time.
    // So we should mannully release it
    CGImageRef centerFrameImage = [imageGenerator copyCGImageAtTime:midpoint
                                                         actualTime:&actualTime
                                                              error:&error];
    if (centerFrameImage != NULL) {
        image = [[UIImage alloc] initWithCGImage:centerFrameImage];
        // Release the CFRetained image
        CGImageRelease(centerFrameImage);
    }
    return image;
}

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
    NSLog(@"-- %@ --",result);
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    //    if ([result isKindOfClass:[CYLTabBarController class]]) {
    //        result = [(CYLTabBarController *)result selectedViewController];
    //    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    NSLog(@"-- %@ --",result);
    return result;
}
@end
