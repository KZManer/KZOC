//  三级cell
//  TLThirdCell.h
//  KZOC
//
//  Created by Zzz... on 2021/12/31.
//

#import <UIKit/UIKit.h>
#import "TLModel.h"
#import "TTNodeModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const CellIdTLThirdCell;

@interface TLThirdCell : UITableViewCell

- (void)echoContent:(TLModel *)tlInfo;
- (void)echoNodeContent:(TTThirdNode *)nodeInfo;

@end

NS_ASSUME_NONNULL_END
