//
//  SVProgressHUD+Custom.h
//  KZOC
//
//  Created by KZ on 2021/11/9.
//

#import "SVProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVProgressHUD (Custom)

/**加载动画，无文字*/
+ (void)cg_showLoadingOnly;
/**展示加载中+文字*/
+ (void)cg_textLoading:(NSString *)hintText;

+ (void)cg_success:(NSString *)hintText;

+ (void)cg_error:(NSString *)hintText;

@end

NS_ASSUME_NONNULL_END
