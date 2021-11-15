//
//  SVProgressHUD+Custom.h
//  KZOC
//
//  Created by KZ on 2021/11/9.
//

#import "SVProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVProgressHUD (Custom)

/**展示加载中，无文字*/
+ (void)cg_showOnly;
/**展示加载中+文字*/
+ (void)cg_showText:(NSString *)text;

+ (void)cg_showSuccess:(NSString *)text;

+ (void)cg_showError:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
