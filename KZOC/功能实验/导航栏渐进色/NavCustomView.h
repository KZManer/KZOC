//
//  NavCustomView.h
//  demo
//
//  Created by KZ on 2021/10/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NavCustomViewDelegate <NSObject>

- (void)pageEnumClicked:(NSInteger)clickIndex;

@end

@interface NavCustomView : UIView

@property (nonatomic, weak) id<NavCustomViewDelegate> delegate;

- (void)showModeImage;

- (void)hideModeImage;

- (void)pageMenuAlpha:(CGFloat)alpha;

//- (void)changePageMenuIndex:(NSInteger)index;

- (void)bridgeScrollView:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
