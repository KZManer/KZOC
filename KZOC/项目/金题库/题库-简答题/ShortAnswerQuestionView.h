//
//  ShortAnswerQuestionView.h
//  KZOC
//
//  Created by Zzz... on 2021/12/4.
//

#import <UIKit/UIKit.h>
#import "CEToolsView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShortAnswerQuestionView : UIView

- (void)echoContent:(NSArray<CEToolsCellModel *> *)models;

@end

NS_ASSUME_NONNULL_END
