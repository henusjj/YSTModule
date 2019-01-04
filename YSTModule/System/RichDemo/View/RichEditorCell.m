//
//  RichEditorCell.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "RichEditorCell.h"
#import "RichEditView.h"
#import "RichEditModel.h"
#import "RichAdapter.h"

#import "TZImagePickerController.h"
#import "SelectVideoModeView.h"

@interface RichEditorCell ()<TZImagePickerControllerDelegate,SelectVideoModeViewDelegete,UIAlertViewDelegate>
/** 添加图片 */
@property (nonatomic,weak) UIButton *addPicBtn;
/** 添加视频 */
@property (nonatomic,weak) UIButton *addVideotn;
/** 编辑器名称 */
@property (nonatomic,weak) UILabel *editorLabel;

/** 是否在编辑状态 */
@property (nonatomic,assign) BOOL isEditor;
/** 编辑文本的高度 */
@property (nonatomic,assign)CGFloat webHight;

/** 添加的图片 */
@property (nonatomic,strong) NSMutableArray *imageArr;
/** 添加视频 */
@property (nonatomic,strong) NSMutableArray *videoArr;

/** 选择视频类型的弹框 */
@property(nonatomic, strong)SelectVideoModeView *selectVideoModeView;
@property (nonatomic,strong)UIView *bgView;//选择视频的蒙层

@property (nonatomic,assign)int videoCount;
@end


@implementation RichEditorCell

-(NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
#pragma mark 择视频类型的弹框
-(SelectVideoModeView *)selectVideoModeView
{
    if (!_selectVideoModeView) {
        _selectVideoModeView = [[SelectVideoModeView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 240 , SCREEN_WIDTH, 240 )];
        _selectVideoModeView.backgroundColor = [UIColor whiteColor];
        _selectVideoModeView.delegete = self;
    }
    return _selectVideoModeView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initialUI];
        
    }
    return self;
}

-(void)initialUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    _isEditor = NO;
    _isEditor = NO;
    UILabel *editorLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, 80, 15)];
    editorLabel.textColor = [UIColor blackColor];
    editorLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:editorLabel];
    _editorLabel = editorLabel;
    
    
    //原生编辑器
    RichEditView * rishView = [[RichEditView alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(editorLabel.frame), SCREEN_WIDTH-30, 100)];
    rishView.placeHolder= @"例：西服套装男士三件套四季";
    rishView.placeHolderColor = [UIColor blackColor];
    rishView.textColor = [UIColor blackColor];
    rishView.textFont = [UIFont systemFontOfSize:14];
    __block typeof(self) weakSelf = self;
    [self.contentView addSubview:rishView];
    _rishView = rishView;
    
    _rishView.heightChange = ^(CGFloat height) {
        _webHight =height;
        [weakSelf changeRichEditorTextFrame];
    };
    _rishView.datas = [NSMutableArray arrayWithArray:@[[[RichEditModel alloc]initWithCellType:RichEditCellViewTypeText content:@""]]];
    
    UIButton *addPicBtn =[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-190)/2.0, CGRectGetMaxY(rishView.frame)+10, 80, 80)];
    [addPicBtn setImage:[UIImage imageNamed:@"PJ_addpic"] forState:UIControlStateNormal];
    [addPicBtn addTarget:self action:@selector(richEditorBtn:) forControlEvents:UIControlEventTouchUpInside];
    addPicBtn.tag = 220;
    [self.contentView addSubview:addPicBtn];
    _addPicBtn = addPicBtn;
    
    UIButton *addVideoBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_addPicBtn.frame)+30, CGRectGetMinY(_addPicBtn.frame), _addPicBtn.width, _addPicBtn.height)];
    [addVideoBtn setImage:[UIImage imageNamed:@"PJ_addvideo"] forState:UIControlStateNormal];
    [addVideoBtn addTarget:self action:@selector(richEditorBtn:) forControlEvents:UIControlEventTouchUpInside];
    addVideoBtn.tag =221;
    [self.contentView addSubview:addVideoBtn];
    _addVideotn = addVideoBtn;

}

#pragma mark - 私有方法更新frame布局
-(void)changeRichEditorTextFrame{
    
    //图片按钮
    _addPicBtn.frame = CGRectMake((SCREEN_WIDTH-190)/2.0,CGRectGetMaxY(_rishView.frame)+10, 80, 80);
    //视频按钮
    _addVideotn.frame = CGRectMake(CGRectGetMaxX(_addPicBtn.frame)+30, CGRectGetMinY(_addPicBtn.frame), _addPicBtn.width, _addPicBtn.height);
    //self高度
    if (_webHight>100) {
        //大于初始高度100 通过代理更新cell高度
        if (self.richCellDelegate &&[self.richCellDelegate respondsToSelector:@selector(richEditorCell:cellHeight:)]) {
            [self.richCellDelegate richEditorCell:self cellHeight:CGRectGetMaxY(_addPicBtn.frame)+10];
        }
    }
}
-(void)richEditorBtn:(UIButton *)button{

    switch (button.tag-220) {
        case 0:{
            //添加图片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
            imagePickerVc.showSelectBtn = YES;
            imagePickerVc.allowPickingOriginalPhoto = YES;
            imagePickerVc.allowCrop = YES;//允许裁剪
            imagePickerVc.cropRect = CGRectMake(0, (SCREEN_HEIGHT - SCREEN_WIDTH)/2.0, SCREEN_WIDTH , SCREEN_HEIGHT);
            
            WeakSelf(self)
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                
                if (photos.count>0) {
                    if (self.imageArr.count+photos.count<=self.ImgMax) {
                        
                        for (int i=0; i<photos.count; i++) {
                            //暂时用本地路径
                            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                            NSString *documentsDirectory = [paths objectAtIndex:0];
                            NSDate *now = [NSDate date];
                            NSString *imageName = [NSString stringWithFormat:@"iOS%@.jpg", [weakSelf stringFromDate:now]];
                            NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
                            NSData *imageData = UIImageJPEGRepresentation(photos[i], 1);
                            [imageData writeToFile:imagePath atomically:YES];

                            [_rishView addImgUrl:imagePath];
//MARK：此地需要使用上传服务器，对应自己服务器做处理
                            
//                            [weakSelf updateImage:photos[i]];
                        }
                    }else{
//                        [APPDELEDETE.window makeToast:@"最多可选10张图片" duration:0.5 position:CSToastPositionCenter];
                        UIAlertView *al =[ [UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"最多可选%ld张图片", self.ImgMax] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                        [al show];
                    }
                   
                }
                
            }];
            [[self getCurrentVC] presentViewController:imagePickerVc animated:YES completion:nil];
        }
            
            break;
        case 1:{
            
            if ([self.rishView getVideoCount]>=1) {
//                [[self getCurrentVC].view makeToast:@"商品详情只能添加一个视频" duration:0.5 position:CSToastPositionTop];
                
                UIAlertView *al =[ [UIAlertView alloc]initWithTitle:nil message:@"商品详情只能添加一个视频" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [al show];
                return;
            }
            
            
            // 添加视频
            
            UIWindow *window = [[UIApplication sharedApplication].delegate window];
            _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
            _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            [window addSubview:_bgView];
            [_bgView addSubview:self.selectVideoModeView];
            [UIView animateWithDuration:.25 animations:^{
                _bgView.transform = CGAffineTransformTranslate(_bgView.transform,0,-SCREEN_HEIGHT);
            }];
            
            UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewTapGesture:)];
            [_bgView addGestureRecognizer:gestureRecognizer];
            
        }
            break;
            
            
        default:
            break;
    }
}
//MARK:对应自己服务器做修改
#pragma mark 图片上传
-(void)updateImage:(UIImage *)photoImage{
    
//    UIImage *tempImage = photoImage;
    //图片压缩
//    NSData *imageData =[photoImage compressImageToMaxFileSize:500];
    //上传
//    WeakSelf(self);
//    [[NetworkTool shareInstance] uploadFileWithUrl:PJ_API_PostImage fileDataStream:imageData nameKey:@"imageFile" fileName:nil parameter:nil success:^(id response) {
//        if ([response[@"code"] integerValue] ==1&&response[@"content"]) {
//            //拼接图片地址，携带尺寸
//            NSString * imgUrl = [NSString stringWithFormat:@"%@?width=%f&height=%f",response[@"content"],tempImage.size.width,tempImage.size.height];
//            //保存图片地址
//            [weakSelf.imageArr addObject:imgUrl];
//            // 编辑器回显图片
//            [_rishView addImgUrl:imgUrl];
//            //弹框提示
//            [[PJ_CommonTool getCurrentVC].view makeToast:@"图片上传成功" duration:0.5 position:CSToastPositionTop];
//        }else{
//
//            [[PJ_CommonTool getCurrentVC].view makeToast:@"图片上传失败" duration:0.5 position:CSToastPositionTop];
//        }
//    } faliure:^(NSError *error) {
//        [[PJ_CommonTool getCurrentVC].view makeToast:@"图片上传失败" duration:0.5 position:CSToastPositionTop];
//    }];
    
}

#pragma mark - SelectVideoModeViewDelegete(选取视频之后走的代理方法)
-(void)shotActionReturnArr:(NSMutableArray *)array
{
    
    [self cancelAction];
    
    NSMutableDictionary *dic = [array firstObject];

    //封面写入
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDate *now = [NSDate date];
    NSString *imageName = [NSString stringWithFormat:@"iOS%@.jpg", [self stringFromDate:now]];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSData *imageData = UIImageJPEGRepresentation(dic[@"firstImg"], 1);
    [imageData writeToFile:imagePath atomically:YES];
    
    
    [_rishView addVideoUrl:dic[@"videoUrl"] coverUrl:imagePath];

    //从视频选择器获取数据Model
//    VideoModel *videoModel = [array firstObject];
//    NSString *videoUrl = videoModel.videoMp4Url;
//    NSData *videoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:videoUrl]];
//
//    UIImage *coverImage = videoModel.frameDiagram;
//    NSData *imageData = [coverImage compressImageToMaxFileSize:500];
//    //资源上传
//    [self updateFileImage:imageData videoData:videoData pathStr:videoUrl];
    
    
}

//MARK:对应服务器做处理
#pragma mark 视频文件的上传，第一帧封面图和视频资源
-(void)updateFileImage:(NSData *)imageData videoData:(NSData *)videoData pathStr:(NSString *)path{
    
    //封面地址上传
//    [[NetworkTool shareInstance] uploadFileWithUrl:PJ_API_PostImage fileDataStream:imageData nameKey:@"imageFile" fileName:nil parameter:nil success:^(id response) {
//
//        if ([response[@"code"] integerValue] ==1) {
//            //封面地址
//            NSString *imageUrl = response[@"content"];
//
//            [[NetworkTool shareInstance] uploadFileWithUrl:PJ_API_PostVideo VideoFilePath:path nameKey:@"urlFile" parameter:nil success:^(id response) {
//                //                NSLog(@"%@",response);
//                NSString *content = response[@"content"];
//                NSInteger code = [response[@"code"] integerValue];
//                NSString *msg = response[@"msg"];
//                [[PJ_CommonTool getCurrentVC].view makeToast:msg duration:1.0 position:CSToastPositionCenter];
//                if (code == 1) {
//                    // 原生 编辑器
//                    [_rishView addVideoUrl:content coverUrl:imageUrl];
//                }
//            } faliure:^(NSError *error) {
//                NSLog(@"%@",@"失败哦");
//                [[PJ_CommonTool getCurrentVC].view makeToast:@"视频上传失败，请重试" duration:0.5 position:CSToastPositionTop];
//
//            }];
//
//        }
//    } faliure:^(NSError *error) {
//
//    }];
    
}

#pragma mark - 视频选择弹出框代理-取消
-(void)videoCancelButton{
    [self cancelAction];
    [self endEditing:YES];

}
//点击背景View
-(void)bgViewTapGesture:(UIGestureRecognizer*)gesture{
    [self cancelAction];
    [self endEditing:YES];

}
//取消弹框
-(void)cancelAction
{
    [UIView animateWithDuration:0.25 animations:^{
        _bgView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [_bgView removeFromSuperview];
        _bgView = nil;
    }];
    
    [self endEditing:YES];
}
#pragma mark setter 商品详情回显
-(void)setDesecArr:(NSArray *)desecArr{
    _desecArr = desecArr;
    
    _rishView.datas = [RichAdapter getModelsWithProductPlainDatas:_desecArr];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
}

@end
