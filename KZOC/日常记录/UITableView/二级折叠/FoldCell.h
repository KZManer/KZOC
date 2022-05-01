//
//  FoldCell.h
//  KZOC
//
//  Created by Zzz... on 2021/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const CellIdFold;

@interface FoldCell : UITableViewCell

- (void)echoContent:(NSString *)content lastRow:(BOOL)lastRow;

@end

NS_ASSUME_NONNULL_END
