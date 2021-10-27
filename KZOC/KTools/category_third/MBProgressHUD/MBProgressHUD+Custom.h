//
//  MBProgressHUD+Custom.h
//  TimeInternational
//
//  Created by KZ on 2021/8/1.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Custom)

+ (MBProgressHUD *)showSuccess:(NSString *)success toView:(UIView *_Nullable)view;
+ (MBProgressHUD *)showError:(NSString *)error toView:(UIView *_Nullable)view;
+ (MBProgressHUD *)showText:(NSString *)text toView:(UIView *_Nullable)view;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *_Nullable)view;
+ (MBProgressHUD *)showSuccess:(NSString *)success;
+ (MBProgressHUD *)showError:(NSString *)error;
+ (MBProgressHUD *)showText:(NSString *)text;
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showTheMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *_Nullable)view;
+ (void)hideHUD;

+ (void)showCustomAnimationHudToView:(UIView *_Nullable)view;
+ (void)showLoadingAnimationToView:(UIView *_Nullable)view;

@end

NS_ASSUME_NONNULL_END
