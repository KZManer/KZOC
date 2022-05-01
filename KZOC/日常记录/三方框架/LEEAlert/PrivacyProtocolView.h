//  隐私协议说明
//  PrivacyProtocolView.h
//  KZOC
//
//  Created by KZ on 2021/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PricacyProtocolViewDelegate <NSObject>
/**协议被点击*/
- (void)dg_privacyPressedLinkIndex:(int)linkIndex;
/**不同意或者同意按钮被点击*/
- (void)dg_privacyAgreeOrNotButtonPressed:(BOOL)agree;
@end

@interface PrivacyProtocolView : UIView

- (instancetype)initWithFrame:(CGRect)frame content:(NSString *)content linkTexts:(NSArray *)linkTexts contentFont:(UIFont *)contentFont;

@property (nonatomic, copy) id<PricacyProtocolViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
