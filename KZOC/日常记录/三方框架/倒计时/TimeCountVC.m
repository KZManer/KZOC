//
//  TimeCountVC.m
//  KZOC
//
//  Created by KZ on 2021/11/2.
//

#import "TimeCountVC.h"
#import "UIButton+CountDown.h"

@interface TimeCountVC ()

@end

@implementation TimeCountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor lightGrayColor];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(44);
    }];
}
- (void)buttonPressed:(UIButton *)button {
    [button button_countDownTotalSeconds:4 normalTitle:@"获取验证码" changeTitlePre:@"重新发送(" changeTitleSuf:@"s)" normalBgColor:UIColor.clearColor changeBgColor:UIColor.clearColor normalTitleColor:[UIColor blueColor] changeTitleColor:[UIColor blueColor]];
}

@end
