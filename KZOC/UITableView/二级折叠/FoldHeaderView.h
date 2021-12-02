//
//  FoldHeaderView.h
//  KZOC
//
//  Created by Zzz... on 2021/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoldHeaderView : UIView

@property (nonatomic, copy) void(^pressedAction)(FoldHeaderView *view);

- (void)echoContent:(NSString *)imageName title:(NSString *)title unfold:(BOOL)unfold;

@end

NS_ASSUME_NONNULL_END
