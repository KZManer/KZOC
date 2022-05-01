//  章节练习做题页面底部功能view
//  CEToolsView.h
//  KZOC
//
//  Created by Zzz... on 2021/12/6.
//

#import <UIKit/UIKit.h>
#import "CEToolsCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CEToolsViewDelegate <NSObject>

/**
 @brief 顶部的功能按钮被点击
 @param index 点击的下标
 */
- (void)dg_toolsViewCellPressed:(int)index;

@end

@interface CEToolsView : UIView

@property (nonatomic, weak) id<CEToolsViewDelegate> delegate;

- (void)echoContent:(NSArray<CEToolsCellModel *> *)models;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
