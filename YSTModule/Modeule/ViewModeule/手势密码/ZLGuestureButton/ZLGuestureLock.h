//
//  ZLGuestureLock.h
//  ZLGuestureButtonDemo
//
//  Created by yst on 2018/7/5.
//  Copyright © 2018年 yst. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ZLFirstTimeSetupPassword @"Me_i36_DBGuestureLock_DBFirstSetupPswd"
@class ZLGuestureLock;

// Button state
typedef NS_ENUM(NSInteger, ZLButtonState) {
    ZLButtonStateNormal = 0,
    ZLButtonStateSelected,
    ZLButtonStateIncorrect,
};

// Delegate
@protocol ZLGuestureLockDelegate <NSObject>

@required
-(void)guestureLock:(ZLGuestureLock *)lock didSetPassword:(NSString*)password;
-(void)guestureLock:(ZLGuestureLock *)lock didGetCorrectPswd:(NSString*)password;
-(void)guestureLock:(ZLGuestureLock *)lock didGetIncorrectPswd:(NSString*)password;

@optional
-(BOOL)showButtonCircleCenterPointOnState:(ZLButtonState)buttonState;
-(BOOL)fillButtonCircleCenterPointOnState:(ZLButtonState)buttonState;
-(CGFloat)widthOfButtonCircleStrokeOnState:(ZLButtonState)buttonState;
-(CGFloat)radiusOfButtonCircleCenterPointOnState:(ZLButtonState)buttonState;
-(CGFloat)lineWidthOfGuestureOnState:(ZLButtonState)buttonState;
-(UIColor *)colorOfButtonCircleStrokeOnState:(ZLButtonState)buttonState;
-(UIColor *)colorForFillingButtonCircleOnState:(ZLButtonState)buttonState;
-(UIColor *)colorOfButtonCircleCenterPointOnState:(ZLButtonState)buttonState;
-(UIColor *)lineColorOfGuestureOnState:(ZLButtonState)buttonState;

@end

@interface ZLGuestureLock : UIView

@property (nonatomic, readonly, assign)BOOL fillCenterPoint;
@property (nonatomic, readonly, assign)BOOL showCenterPoint;
@property (nonatomic, readonly, assign)CGFloat lineWidth;
@property (nonatomic, readonly, assign)CGFloat circleRadius;
@property (nonatomic, readonly, assign)CGFloat strokeWidth;
@property (nonatomic, readonly, assign)CGFloat centerPointRadius;
@property (nonatomic, readonly, strong)UIColor *lineColor;
@property (nonatomic, readonly, strong)UIColor *fillColor;
@property (nonatomic, readonly, strong)UIColor *strokeColor;
@property (nonatomic, readonly, strong)UIColor *centerPointColor;

@property (nonatomic, readonly, assign)BOOL isPasswordSetup;
@property (nonatomic, copy)NSString *firstTimeSetupPassword;
@property (nonatomic, assign)id<ZLGuestureLockDelegate> delegate;
@property (nonatomic, copy) void(^onPasswordSet)(ZLGuestureLock *lock, NSString *password);
@property (nonatomic, copy) void(^onGetCorrectPswd)(ZLGuestureLock *lock, NSString *password);
@property (nonatomic, copy) void(^onGetIncorrectPswd)(ZLGuestureLock *lock, NSString *password);

// Password
+(BOOL)passwordSetupStatus;
+(void)clearGuestureLockPassword;
+(NSString *)getGuestureLockPassword;

//Working with protocal
+(instancetype)lockOnView:(UIView*)view delegate:(id<ZLGuestureLockDelegate>)delegate;
+(instancetype)lockOnView:(UIView*)view offsetFromBottom:(CGFloat)offset delegate:(id<ZLGuestureLockDelegate>)delegate;

//Working with block
+(instancetype)lockOnView:(UIView*)view onPasswordSet:(void (^)(ZLGuestureLock *lock, NSString *password))onPasswordSet onGetCorrectPswd:(void (^)(ZLGuestureLock *lock, NSString *password))GetCorrectPswd onGetIncorrectPswd:(void (^)(ZLGuestureLock *lock, NSString *password))GetIncorrectPswd;
+(instancetype)lockOnView:(UIView*)view offsetFromBottom:(CGFloat)offset onPasswordSet:(void (^)(ZLGuestureLock *lock, NSString *password))onPasswordSet onGetCorrectPswd:(void (^)(ZLGuestureLock *lock, NSString *password))GetCorrectPswd onGetIncorrectPswd:(void (^)(ZLGuestureLock *lock, NSString *password))GetIncorrectPswd;

//Setup lock theme
-(void)setupLockThemeWithLineColor:(UIColor*)lineColor lineWidth:(CGFloat)lineWidth  strokeColor:(UIColor*)strokeColor strokeWidth:(CGFloat)strokeWidth circleRadius:(CGFloat)circleRadius fillColor:(UIColor*)fillColor showCenterPoint:(BOOL)showCenterPoint centerPointColor:(UIColor*)centerPointColor centerPointRadius:(CGFloat)centerPointRadius fillCenterPoint:(BOOL)fillCenterPoint onState:(ZLButtonState)buttonState;
@end
