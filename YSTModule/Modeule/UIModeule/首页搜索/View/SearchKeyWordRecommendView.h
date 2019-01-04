//
//  SearchKeyWordRecommendView.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/12.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchKeyWordRecommendView : UIView
@property (nonatomic,copy)void(^searchCall)(NSString * keyWord);
-(void)refresUI;
-(void)addKeyWord:(NSString *)keyWord;
-(void)clearHistory;

-(void)getHotKey;
@end
