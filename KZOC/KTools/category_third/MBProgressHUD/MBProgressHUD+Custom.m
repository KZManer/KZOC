//
//  MBProgressHUD+Custom.m
//  TimeInternational
//
//  Created by KZ on 2021/8/1.
//

#import "MBProgressHUD+Custom.h"

typedef enum : NSUInteger {
    MBHUDTypeSuccess,
    MBHUDTypeError,
    MBHUDTypeText,
    MBHUDTypeEmpty,
    MBHUDTypeUnknown,
} MBHUDType;

@implementation MBProgressHUD (Custom)

// MARK: base implementation
+ (void)showText:(NSString *)text type:(MBHUDType)type {
    UIView *showView = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:showView animated:YES];
    hud.label.text = text;
    
    // setting icon
    NSString *iconName = nil;
    switch (type) {
        case MBHUDTypeSuccess:
            iconName = @"success.png";break;
        case MBHUDTypeError:
            iconName = @"error.png";break;
        case MBHUDTypeEmpty:
            iconName = @"";break;
        default:break;
    }
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", iconName]]];
    hud.mode = MBProgressHUDModeCustomView;
//    hud.bezelView.blurEffectStyle = UIBlurEffectStyleDark;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.3f];
}

// MARK: show and hide
/**加载动画，无文字*/
+ (void)cg_showLoadingOnly {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:true];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.removeFromSuperViewOnHide = true;
    hud.contentColor = UIColor.whiteColor;
    hud.bezelView.blurEffectStyle = UIBlurEffectStyleDark;
}

/**隐藏*/
+ (void)cg_hide {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:true];
}
/**延迟隐藏*/
+ (void)cg_hideWithDelay:(NSTimeInterval)delay {
    [self cg_hideWithDelay:delay completion:nil];
}
/**延迟隐藏+回调*/
+ (void)cg_hideWithDelay:(NSTimeInterval)delay completion:(nullable void(^)(void))completion {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self cg_hide];
        if (completion) {
            completion();
        }
    });
}

// MARK: success
/**成功*/
+ (void)cg_success:(NSString *)hintText {
    [self cg_hide];
    [self showText:hintText type:MBHUDTypeSuccess];
}

// MARK: error
/**失败*/
+ (void)cg_error:(NSString *)hintText {
    [self cg_hide];
    [self showText:hintText type:MBHUDTypeError];
}

// MARK: text
/** text only */
+ (void)cg_textOnly:(NSString *)hintText {
    [self cg_hide];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.label.text = hintText;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.3f];
}
/** text loading */
+ (void)cg_textLoading:(NSString *)hintText {
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.label.text = hintText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
}

@end
