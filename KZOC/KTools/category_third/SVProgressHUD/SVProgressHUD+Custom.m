//
//  SVProgressHUD+Custom.m
//  KZOC
//
//  Created by KZ on 2021/11/9.
//

#import "SVProgressHUD+Custom.h"

@implementation SVProgressHUD (Custom)

+ (void)cg_showLoadingOnly {
    [self show];
    [self setDefaultStyle:SVProgressHUDStyleDark];
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
}
+ (void)cg_textLoading:(NSString *)hintText {
    [self showWithStatus:hintText];
    [self setDefaultStyle:SVProgressHUDStyleDark];
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
}
+ (void)cg_success:(NSString *)hintText {
    [self showSuccessWithStatus:hintText];
    [self dismissWithDelay:1.3f];
}
+ (void)cg_error:(NSString *)hintText {
    [self showErrorWithStatus:hintText];
    [self dismissWithDelay:1.3f];
}

@end
