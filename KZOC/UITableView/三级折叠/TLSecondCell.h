//  二级cell
//  TLSecondCell.h
//  KZOC
//
//  Created by Zzz... on 2021/12/31.
//

#import <UIKit/UIKit.h>
#import "TLModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const CellIdTLSecondCell;

@interface TLSecondCell : UITableViewCell

- (void)echoContent:(TLModel *)tlInfo;

@end

NS_ASSUME_NONNULL_END
