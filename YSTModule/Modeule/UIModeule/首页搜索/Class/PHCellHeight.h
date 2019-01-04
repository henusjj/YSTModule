
#import <UIKit/UIKit.h>


/**
 使用 该工具 时
 1,需使用 -(CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath 作为 tableView cell 返回的高度
 2,然后 每个cell 设置对应的indexPath
 3,最后 在确保  每个cell的 indexPath 都有准确的赋值的情况下  对 cell 的 ph_Height 进行赋值
 (cell 的 ph_Height 的赋值 必须放到 tableView cell  高度的代理方法之前)
 */
@interface UITableViewCell (cellHeight)
@property (nonatomic,strong)NSIndexPath * indexPath;
@property (nonatomic,assign)CGFloat ph_Height;
@end





@interface UITableView (cellHeight)
-(void)setCellHeight:(CGFloat)height indexPath:(NSIndexPath *)indexPath;
-(CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath;
@end



