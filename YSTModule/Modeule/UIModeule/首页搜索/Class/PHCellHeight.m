
#import "PHCellHeight.h"
#import <objc/runtime.h>


static void *indexPathKey = &indexPathKey;
static void *PH_HeightKey = &PH_HeightKey;

@implementation UITableViewCell (cellHeight)
//getter
- (NSIndexPath *)indexPath {
    return  objc_getAssociatedObject(self, &indexPathKey);
}
//setter
- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self,  &indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//getter
- (CGFloat)ph_Height {
    return  [objc_getAssociatedObject(self, &PH_HeightKey) floatValue];
}
//setter
- (void)setPh_Height:(CGFloat)ph_Height {
    
    UITableView * tableView = [self tableView];
    objc_setAssociatedObject(self,  &PH_HeightKey, @(ph_Height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [tableView setCellHeight:ph_Height indexPath:self.indexPath];
}
-(UITableView *)tableView{
    UITableView * tableView =  ((UITableView *)(self.superview));
    if (![tableView isKindOfClass:[UITableView class]]) {
        tableView = (UITableView *)(tableView.superview);
    }
    return tableView;
    
}
@end











static void *heightDicKey = &heightDicKey;
@interface UITableView()
@property (nonatomic,strong)NSMutableDictionary * heightDic;
@end
@implementation UITableView (cellHeight)
//getter
- (NSMutableDictionary *)heightDic {
    return  objc_getAssociatedObject(self, &heightDicKey);
}
//setter
- (void)setHeightDic:(NSMutableDictionary *)heightDic {
    objc_setAssociatedObject(self,  &heightDicKey, heightDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(void)setCellHeight:(CGFloat)height indexPath:(NSIndexPath *)indexPath{
    if (!self.heightDic) {
        self.heightDic = [NSMutableDictionary dictionary];
    }
    NSString * key = [NSString stringWithFormat:@"%ld,%ld",(long)indexPath.section,(long)indexPath.row];
    [self.heightDic setValue:@(height) forKey:key];
}
-(CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath{
    NSString * key = [NSString stringWithFormat:@"%ld,%ld",(long)indexPath.section,(long)indexPath.row];
    CGFloat height = [[NSString stringWithFormat:@"%@",[self.heightDic valueForKey:key]] floatValue];
    return height;
}

@end






