//
//  RichAdapter.h
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RichEditModel.h"
/*
 网络请求下来的数据 和 可显示的模型数据  之间的相互转换
 */


@interface RichAdapter : NSObject
// 发布资讯的 models转 datas     和  datas 转models
+(NSMutableArray<RichEditModel *> *)getModelsWithPulishInfoDatas:(NSArray<NSDictionary *> *)datas;
+(NSMutableArray<NSDictionary *> *)getPulishInfoDatasWithModels:(NSArray<RichEditModel *> *)models;

// 发布产品计划的 models转 datas     和  datas 转models
+(NSMutableArray<RichEditModel *> *)getModelsWithProductPlainDatas:(NSArray<NSDictionary *> *)datas;
+(NSMutableArray<NSDictionary *> *)getProductPlainDatasWithModels:(NSArray<RichEditModel *> *)models;
@end
