//  章节练习做题页面底部功能view
//  CEToolsView.h
//  KZOC
//
//  Created by Zzz... on 2021/12/6.
//

#import <UIKit/UIKit.h>
#import "CEToolsCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CEToolsView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)echoContent:(NSArray<CEToolsCellModel *> *)models;

@end

NS_ASSUME_NONNULL_END
