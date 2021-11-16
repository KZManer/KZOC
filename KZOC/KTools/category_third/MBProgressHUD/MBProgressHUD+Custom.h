//
//  MBProgressHUD+Custom.h
//  TimeInternational
//
//  Created by KZ on 2021/8/1.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Custom)

/**加载动画，无文字*/
+ (void)cg_showLoadingOnly;
/**隐藏*/
+ (void)cg_dismiss;
/**延迟隐藏*/
+ (void)cg_dismissWithDelay:(NSTimeInterval)delay;
/**成功*/
+ (void)cg_success:(NSString *)hintText;
/**失败*/
+ (void)cg_error:(NSString *)hintText;
/**文本 only*/
+ (void)cg_textOnly:(NSString *)hintText;
/**文本 loading*/
+ (void)cg_textLoading:(NSString *)hintText;

@end

NS_ASSUME_NONNULL_END
