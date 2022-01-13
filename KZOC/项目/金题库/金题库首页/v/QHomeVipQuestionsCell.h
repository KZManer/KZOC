//
//  QHomeVipQuestionsCell.h
//  KingTalent
//
//  Created by Zzz... on 2022/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const CellIdQHomeVipQuestions;

@protocol QHomeVipQuestionsCellDelegate <NSObject>

- (void)dg_homeVipQuestionsDidSelect:(NSInteger)index;

@end

@interface QHomeVipQuestionsCell : UITableViewCell

@property (nonatomic, weak) id<QHomeVipQuestionsCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
