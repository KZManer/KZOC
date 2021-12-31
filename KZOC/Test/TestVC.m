//
//  TestVC.m
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import "TestVC.h"
#import "GainGoldVC.h"

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
}

- (void)pressedButton {
    GainGoldVC *gainVC = [[GainGoldVC alloc]init];
    gainVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:gainVC animated:true];
}


@end
