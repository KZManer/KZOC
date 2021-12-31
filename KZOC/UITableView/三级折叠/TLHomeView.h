//
//  TLHomeView.h
//  KZOC
//
//  Created by Zzz... on 2021/12/31.
//

#import <UIKit/UIKit.h>
#import "TLModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLHomeView : UIView

- (void)echoContent:(NSArray<TLModel *> *)tlInfos;

@end

NS_ASSUME_NONNULL_END
