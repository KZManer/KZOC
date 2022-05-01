//
//  QHomeEightItemCell.h
//  KingTalent
//
//  Created by Zzz... on 2022/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const CellIdQHomeEightItem;

@protocol QHomeEightItemCellDelegate <NSObject>

- (void)dg_homeEightItemDidSelect:(NSInteger)index;

@end

@interface QHomeEightItemCell : UITableViewCell

@property (nonatomic, weak) id<QHomeEightItemCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
