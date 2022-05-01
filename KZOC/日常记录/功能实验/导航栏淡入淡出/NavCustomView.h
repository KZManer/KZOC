//
//  NavCustomView.h
//  demo
//
//  Created by KZ on 2021/10/25.
//

#import <UIKit/UIKit.h>
#import "NavMenuModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NavCustomViewDelegate <NSObject>

- (void)backButtonPressed;

- (void)collectionViewCellDidSelect:(NSInteger)selectIndex;

@end

@interface NavCustomView : UIView

@property (nonatomic, weak) id<NavCustomViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame menuTitles:(NSArray *)menuTitles;

- (void)showModeImage;

- (void)hideModeImage;

/**菜单透明度*/
- (void)pageMenuAlpha:(CGFloat)alpha;

- (void)updateCollectionViewCellStatus:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
