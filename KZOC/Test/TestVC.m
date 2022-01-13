//
//  TestVC.m
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import "TestVC.h"
#import "ProgressView.h"
#import "CJReportProgressView.h"
#import "CJSmartProgressView.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *demoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [demoButton setTitle:@"click me" forState:UIControlStateNormal];
    [demoButton setBackgroundColor:UIColor.orangeColor];
    [demoButton addTarget:self action:@selector(pressedButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:demoButton];
    [demoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@80);
    }];
    
    ProgressView *progressView = [ProgressView createProgressWithFrame:CGRectMake(10, 100, 100, 100) backColor:UIColor.lightGrayColor color:UIColor.redColor proportion:0.6];
    progressView.backgroundColor = Color_Hex(@"999999");
    progressView.data = @"123";
    progressView.dataName = @"456";
    [self.view addSubview:progressView];
    [progressView showContentData];
    [progressView showProgress];
    
    CJReportProgressView *progressView2 = [CJReportProgressView createProgressWithFrame:CGRectMake(120, 100, 100, 100) backColor:UIColor.lightGrayColor color:UIColor.redColor proportion:0.6];
    progressView2.backgroundColor = Color_Hex(@"999999");
    progressView2.data = @"123";
    progressView2.dataName = @"456";
    [self.view addSubview:progressView2];
    [progressView2 showContentData];
    [progressView2 showProgress];
    
    CJSmartProgressView *progressView3 = [CJSmartProgressView createProgressWithFrame:CGRectMake(230, 100, 100, 100) backColor:UIColor.lightGrayColor color:UIColor.redColor proportion:0.6];
    progressView3.backgroundColor = Color_Hex(@"999999");
    progressView3.data = @"123";
    progressView3.dataName = @"456";
    [self.view addSubview:progressView3];
    [progressView3 showContentData];
    [progressView3 showProgress];
    
}

- (void)pressedButton {
    
}


@end
