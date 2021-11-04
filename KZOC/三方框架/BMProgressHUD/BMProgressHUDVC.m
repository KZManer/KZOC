//
//  BMProgressHUDVC.m
//  KZOC
//
//  Created by KZ on 2021/10/27.
//

#import "BMProgressHUDVC.h"
#import "MBProgressHUD+Custom.h"
#import "SVProgressHUD.h"

@interface BMProgressHUDVC ()

@end

@implementation BMProgressHUDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [KSelectView view]
    .kFrame(self.view.frame)
    .kDatasource(@[@"showText",@"showError",@"showMessage",@"showSuccess",@"showTheMessage"])
    .kShow(self.view)
    .kSelectCell(^(NSString * _Nonnull cellName, NSInteger cellIndex) {
        NSString *selString = [NSString stringWithFormat:@"%@:",cellName];
        SEL sel = NSSelectorFromString(selString);
        if ([MBProgressHUD respondsToSelector:sel]) {
            [MBProgressHUD performSelector:sel withObject:cellName];
        } else {
            [MBProgressHUD showError: [NSString stringWithFormat:@"没有找到<%@>方法",cellName]];
        }
        //showMessage方法需要手动关闭提示框
        if ([cellName isEqualToString:@"showMessage"]) {
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
    });
}

@end
