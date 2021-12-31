//
//  ShortAnswerQuestionCell.h
//  KZOC
//
//  Created by Zzz... on 2021/12/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const CellIdShortAnswerQuestion;

@interface ShortAnswerQuestionCell : UICollectionViewCell

/**
 @brief:改变底部展示的内容
 @param showAnswer 是否展示答案解析
 */
- (void)changeBottomContentWithShowAnswer:(BOOL)showAnswer;

@end

NS_ASSUME_NONNULL_END
