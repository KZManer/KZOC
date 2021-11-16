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
    .kDatasource(@[@"cg_textOnly",@"cg_textLoading",@"cg_success",@"cg_error",@"cg_showLoadingOnly",@"SV_showOnly"])
    .kShow(self.view)
    .kSelectCell(^(NSString * _Nonnull cellName, NSInteger cellIndex) {
        
        if ([cellName isEqualToString:@"cg_showLoadingOnly"]) {
            [MBProgressHUD cg_showLoadingOnly];
            [MBProgressHUD cg_dismissWithDelay:2];
            return;
        }
        if ([cellName isEqualToString:@"cg_textLoading"]) {
            [MBProgressHUD cg_textLoading:cellName];
            [MBProgressHUD cg_dismissWithDelay:2];
            return;
        }
        if ([cellName isEqualToString:@"SV_showOnly"]) {
            [SVProgressHUD cg_showOnly];
            [SVProgressHUD dismissWithDelay:2];
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
