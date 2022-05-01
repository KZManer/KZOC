//  一级cell
//  TLFirstCell.h
//  KZOC
//
//  Created by Zzz... on 2021/12/31.
//

#import <UIKit/UIKit.h>
#import "TLModel.h"
#import "TTNodeModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const CellIdTLFirstCell;

@interface TLFirstCell : UITableViewCell

- (void)echoContent:(TLModel *)tlInfo;
- (void)echoNodeContent:(TTFirstNode *)nodeInfo;

@end

NS_ASSUME_NONNULL_END
