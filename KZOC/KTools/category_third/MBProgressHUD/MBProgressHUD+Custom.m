//
//  MBProgressHUD+Custom.m
//  TimeInternational
//
//  Created by KZ on 2021/8/1.
//

#import "MBProgressHUD+Custom.h"

@implementation MBProgressHUD (Custom)

#pragma mark 显示信息
+ (MBProgressHUD *)show:(NSString *)text icon:(NSString *)icon view:(UIView *_Nullable)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0];
    
    return hud;
    
}

#pragma mark 显示信息
+ (MBProgressHUD *)showError:(NSString *)error toView:(UIView *_Nullable)view{
   return [self show:error icon:@"error.png" view:view];
}

+ (MBProgressHUD *)showSuccess:(NSString *)success toView:(UIView *_Nullable)view {
   return [self show:success icon:@"success.png" view:view];
}

+ (MBProgressHUD *)showText:(NSString *)text toView:(UIView *)view {
    return [self show:text icon:nil view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *_Nullable)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    return hud;
}

+ (MBProgressHUD *)showSuccess:(NSString *)success {
    [self hideHUD];
   return [self showSuccess:success toView:nil];
}

+ (MBProgressHUD *)showError:(NSString *)error {
    [self hideHUD];
    return [self showError:error toView:nil];
}

+ (MBProgressHUD *)showText:(NSString *)text {
    [self hideHUD];
    return [self showText:text toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

+ (MBProgressHUD *)showTheMessage:(NSString *)message {
    [self hideHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.label.text = message;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.4];
    
    return hud;
}


+ (void)hideHUDForView:(UIView *_Nullable)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

+ (void)showCustomAnimationHudToView:(UIView *_Nullable)view {
   
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置图片
    UIImage *image = [UIImage imageNamed:@"BuyTempCover"];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
}
+ (void)showLoadingAnimationToView:(UIView *_Nullable)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置模式
    hud.mode = MBProgressHUDModeIndeterminate;
}

@end
