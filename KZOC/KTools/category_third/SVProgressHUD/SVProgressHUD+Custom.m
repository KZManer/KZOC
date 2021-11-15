//
//  SVProgressHUD+Custom.m
//  KZOC
//
//  Created by KZ on 2021/11/9.
//

#import "SVProgressHUD+Custom.h"

@implementation SVProgressHUD (Custom)

+ (void)cg_showOnly {
    [self show];
    [self setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self setDefaultStyle:SVProgressHUDStyleDark];
}
+ (void)cg_showText:(NSString *)text {
    [self showWithStatus:text];
    [self setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self setDefaultStyle:SVProgressHUDStyleDark];
}
+ (void)cg_showSuccess:(NSString *)text {
    [self showSuccessWithStatus:text];
    [self dismissWithDelay:1.2f];
}
+ (void)cg_showError:(NSString *)text {
    [self showErrorWithStatus:text];
    [self dismissWithDelay:1.2f];
}

@end
