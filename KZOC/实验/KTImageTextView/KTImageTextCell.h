//
//  KTImageTextCell.h
//  KZOC
//
//  Created by Zzz... on 2021/12/18.
//

#import <UIKit/UIKit.h>
#import "KTImageTextModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const cellIdKTImageText;

@interface KTImageTextCell : UICollectionViewCell

/**
 @brief 数据回显
 @param model 数据模型
 @param spaceImageText image and text vertical space
 */
- (void)echoContent:(KTImageTextModel *)model spaceImageText:(CGFloat)spaceImaegText;

@end

NS_ASSUME_NONNULL_END
