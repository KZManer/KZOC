//
//  CEToolsCell.h
//  KZOC
//
//  Created by Zzz... on 2021/12/6.
//

#import <UIKit/UIKit.h>
#import "CEToolsCellModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const CellIdChapterExerciseTools;

@interface CEToolsCell : UICollectionViewCell

//回显数据
- (void)echoContent:(CEToolsCellModel *)model;

@end

NS_ASSUME_NONNULL_END
