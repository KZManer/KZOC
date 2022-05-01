//
//  QHomeWelfareCell.h
//  KingTalent
//
//  Created by Zzz... on 2022/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const CellIdQHomeWelfare;

@protocol QHomeWelfareCellDelegate <NSObject>

- (void)dg_homeWelfareDidSelect:(NSInteger)index;

@end

@interface QHomeWelfareCell : UITableViewCell

@property (nonatomic, weak) id<QHomeWelfareCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
