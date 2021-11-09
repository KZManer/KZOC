//
//  ShearVC.m
//  KZOC
//
//  Created by KZ on 2021/11/8.
//

#import "ShearVC.h"

@interface ShearVC ()

@end

@implementation ShearVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *demoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [demoButton setTitle:@"click" forState:UIControlStateNormal];
    [demoButton setBackgroundColor:UIColor.lightGrayColor];
    [demoButton addTarget:self action:@selector(pressedButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:demoButton];
    [demoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
}
- (void)pressedButton {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSLog(@"%@",pasteboard.string);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
