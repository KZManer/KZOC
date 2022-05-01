//
//  TTListView.h
//  KZOC
//
//  Created by KZ on 2022/1/2.
//

#import <UIKit/UIKit.h>
#import "TTNodeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTListView : UIView
- (void)echoContent:(NSArray<TTFirstNode *> *)nodeInfos;
@end

NS_ASSUME_NONNULL_END
