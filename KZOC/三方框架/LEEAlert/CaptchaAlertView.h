//
//  CaptchaAlertView.h
//  KZOC
//
//  Created by KZ on 2021/11/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CaptchaAlertView : UIView

/**
 *  关闭Block
 */
@property (nonatomic , copy ) void (^closeBlock)(void);

@end

NS_ASSUME_NONNULL_END
