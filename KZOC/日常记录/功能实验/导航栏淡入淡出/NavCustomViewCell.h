//
//  NavCustomViewCell.h
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import <UIKit/UIKit.h>
#import "NavMenuModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const CellIdentifierNavCustomeView;

@interface NavCustomViewCell : UICollectionViewCell

- (void)echoContent:(NavMenuModel *)model;

@end

NS_ASSUME_NONNULL_END
