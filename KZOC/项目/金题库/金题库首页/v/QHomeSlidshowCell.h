//
//  QHomeSlidshowCell.h
//  KingTalent
//
//  Created by Zzz... on 2022/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const CellIdQHomeSlideshow;

@protocol QHomeSlideshowCellDelegate <NSObject>

- (void)dg_homeSlideshowDidSelect:(NSInteger)index;

@end

@interface QHomeSlidshowCell : UITableViewCell

@property (nonatomic, weak) id<QHomeSlideshowCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
