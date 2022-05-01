//
//  VCLifeCycle.m
//  demo
//
//  Created by KZ on 2021/10/25.
//

#import "VCLifeCycle.h"
#import "VCLifeCyclePop.h"
#import "VCLifeCyclePresent.h"

@interface VCLifeCycle ()

@property (nonatomic, strong) UIButton *popButton;
@property (nonatomic, strong) UIButton *presentButton;

@end

@implementation VCLifeCycle
- (void)dealloc {
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%s",__func__);
    
//    extern int HOMEHEADERVIEWCELLHEIGHT;
//    NSLog(@"%d",HOMEHEADERVIEWCELLHEIGHT);
    
    self.popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.popButton setTitle:@"pop mode" forState:UIControlStateNormal];
    [self.popButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.popButton addTarget:self action:@selector(popMode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.popButton];
    
    self.presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.presentButton setTitle:@"present mode" forState:UIControlStateNormal];
    [self.presentButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.presentButton addTarget:self action:@selector(presentMode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.presentButton];
    
    
}
- (void)popMode {
    VCLifeCyclePop *popVC = [[VCLifeCyclePop alloc]init];
    [self.navigationController pushViewController:popVC animated:YES];
}
- (void)presentMode {
    VCLifeCyclePresent *presentVC = [[VCLifeCyclePresent alloc]init];
    [self.navigationController presentViewController:presentVC animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"%s",__func__);
    [self.popButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).dividedBy(2);
        make.height.equalTo(@44);
        make.centerX.mas_equalTo(0);
        make.centerY.equalTo(self.view).multipliedBy(0.8);
    }];
    
    [self.presentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerX.equalTo(self.popButton);
        make.top.equalTo(self.popButton.mas_bottom).with.offset(50);
    }];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"%s",__func__);
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%s",__func__);
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%s",__func__);
}

@end
