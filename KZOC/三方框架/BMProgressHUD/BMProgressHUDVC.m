//
//  BMProgressHUDVC.m
//  KZOC
//
//  Created by KZ on 2021/10/27.
//

#import "BMProgressHUDVC.h"
#import "MBProgressHUD+Custom.h"
#import "SVProgressHUD+Custom.h"

@interface BMProgressHUDVC ()

@end

@implementation BMProgressHUDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [KSelectView view]
    .kFrame(self.view.frame)
    .kDatasource(@[@"cg_textOnly",@"cg_textLoading",@"cg_success",@"cg_error",@"cg_showLoadingOnly",@"cg_hide",@"cg_hideHanlder",@"cg_hideAfterDelay",@"SV_showLoadingOnly",@"SV_textLoading",@"SV_success",@"SV_error"])
    .kShow(self.view)
    .kSelectCell(^(NSString * _Nonnull cellName, NSInteger cellIndex) {
        
        if ([cellName isEqualToString:@"cg_showLoadingOnly"]) {
            [MBProgressHUD cg_showLoadingOnly];
            [MBProgressHUD cg_hideWithDelay:2];
            return;
        }
        if ([cellName isEqualToString:@"cg_textLoading"]) {
            [MBProgressHUD cg_textLoading:cellName];
            [MBProgressHUD cg_hideWithDelay:2];
            return;
        }
        if ([cellName isEqualToString:@"SV_showLoadingOnly"]) {
            [SVProgressHUD cg_showLoadingOnly];
            [SVProgressHUD dismissWithDelay:2];
            return;
        }
        if ([cellName isEqualToString:@"SV_textLoading"]) {
            [SVProgressHUD cg_textLoading:cellName];
            [SVProgressHUD dismissWithDelay:2];
            return;
        }
        if ([cellName isEqualToString:@"SV_success"]) {
            [SVProgressHUD cg_success:cellName];return;
        }
        if ([cellName isEqualToString:@"SV_error"]) {
            [SVProgressHUD cg_error:cellName];return;
        }
        if ([cellName isEqualToString:@"cg_hide"]) {
            [MBProgressHUD cg_showLoadingOnly];
            [MBProgressHUD cg_hideWithDelay:2];
            return;
        }
        if ([cellName isEqualToString:@"cg_hideHanlder"]) {
            [MBProgressHUD cg_showLoadingOnly];
            [MBProgressHUD cg_hideWithDelay:2 completion:^{
                NSLog(@"隐藏了");
            }];
            return;
        }
        if ([cellName isEqualToString:@"cg_hideAfterDelay"]) {
            [MBProgressHUD cg_hideAfterDelay:2 completion:nil];
            return;
        }
       
        NSString *selString = [NSString stringWithFormat:@"%@:",cellName];
        SEL sel = NSSelectorFromString(selString);
        if ([MBProgressHUD respondsToSelector:sel]) {
            [MBProgressHUD performSelector:sel withObject:cellName];
        } else {
            [MBProgressHUD cg_error:[NSString stringWithFormat:@"没有找到<%@>方法",cellName]];
        }
    });
}

@end
