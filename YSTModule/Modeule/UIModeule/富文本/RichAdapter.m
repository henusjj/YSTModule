//
//  RichAdapter.m
//  RichTextEditor
//
//  Created by 李慧静 on 2018/6/11.
//  Copyright © 2018年 李慧静. All rights reserved.
//

#import "RichAdapter.h"

@implementation RichAdapter

// 发布资讯的 models转 datas     和  datas 转models
+(NSMutableArray<RichEditModel *> *)getModelsWithPulishInfoDatas:(NSArray<NSDictionary *> *)datas{
    NSMutableArray * models = [NSMutableArray array];
    
    return models;
}
+(NSMutableArray<NSDictionary *> *)getPulishInfoDatasWithModels:(NSArray<RichEditModel *> *)models{
    NSMutableArray * datas = [NSMutableArray array];
    
    return datas;
}
// 发布产品计划的 models转 datas     和  datas 转models
+(NSMutableArray<RichEditModel *> *)getModelsWithProductPlainDatas:(NSArray<NSDictionary *> *)datas{
    NSMutableArray * models = [NSMutableArray array];
    //    NSMutableArray * datas = [NSMutableArray array];
    
    NSUInteger temCount = 1;
    for (int i = 0 ; i < datas.count ; i ++) {
        NSDictionary * data = datas[i];
        
        NSString * type = [NSString stringWithFormat:@"%@",data[@"type"]];
        NSString * content = [NSString stringWithFormat:@"%@",data[@"content"]];
        
        RichEditModel * model;
        if ([type isEqualToString:@"0"]) {
            model = [[RichEditModel alloc]initWithCellType:RichEditCellViewTypeText content:content];
        }else if([type isEqualToString:@"1"]){
            model = [[RichEditModel alloc]initWithCellType:RichEditCellViewTypeImg content:content];
        }else{

            NSString * viewImg = [NSString stringWithFormat:@"%@",data[@"view_img"]];
            model = [[RichEditModel alloc]initWithVideoCoverUrl:viewImg videoUrl:content];
        }

        if (model.cellType == RichEditCellViewTypeImg || model.cellType == RichEditCellViewTypeVideo) {

            if (temCount >= 1) {
                [models addObject:[[RichEditModel alloc]initWithCellType:RichEditCellViewTypeText content:@""]];
            }
            temCount ++ ;
        }else{
            temCount = 0;
        }

        [models addObject:model];
        if ((model.cellType == RichEditCellViewTypeImg || model.cellType == RichEditCellViewTypeVideo) &&  i == datas.count - 1) {
            [models addObject:[[RichEditModel alloc]initWithCellType:RichEditCellViewTypeText content:@""]];
        }
        
    }
    
    
    return models;
}

+(NSMutableArray<NSDictionary *> *)getProductPlainDatasWithModels:(NSArray<RichEditModel *> *)models{
    /** 模型转 数组 */
    
    NSMutableArray * datas = [NSMutableArray array];
    NSInteger index = 0;
    for (int i =0; i<models.count; i++) {
        RichEditModel * model = models[i];
        
        
        NSDictionary * dic ;
        if (model.cellType == RichEditCellViewTypeText) {
            dic = @{@"sort":[NSString stringWithFormat:@"%ld",(long)i],
                    @"type":@"0",
                    @"content":[NSString stringWithFormat:@"%@",model.content]
                    };
        }else if (model.cellType == RichEditCellViewTypeImg){

            dic = @{@"sort":[NSString stringWithFormat:@"%ld",(long)i],
                    @"type":@"1",
                    @"content":[NSString stringWithFormat:@"%@",model.content]
                    };

        }else if (model.cellType == RichEditCellViewTypeVideo){
            dic = @{@"sort":[NSString stringWithFormat:@"%ld",(long)i],
                    @"type":@"2",
                    @"content":[NSString stringWithFormat:@"%@",model.videoUrl],
                    @"viewImg":[NSString stringWithFormat:@"%@",model.videoCoverUrl]

                    };
        }
        //MARK:111111111111111
//        if (![[NSString stringWithFormat:@"%@",model.content] isEmptyString]) {
//            [datas addObject:dic];
//        }

        
    }
   
    return datas;
    
    
}
@end
