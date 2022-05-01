//
//  DatePickerVC.m
//  KZOC
//
//  Created by KZ on 2021/10/27.
//

#import "DatePickerVC.h"
#import "CXDatePickerView.h"

@interface DatePickerVC ()

@end

@implementation DatePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *demoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [demoButton setFrame:CGRectMake(0, 0, 100, 30)];
    demoButton.center = self.view.center;
    [demoButton setTitle:@"时间选择器" forState:UIControlStateNormal];
    [demoButton setBackgroundColor:[UIColor lightGrayColor]];
    [demoButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:demoButton];
}

- (void)buttonClicked {
    CXDatePickerView *pickerView = [[CXDatePickerView alloc]initWithDateStyle:CXDateStyleShowYearMonthDay CompleteBlock:^(NSDate *date) {
        NSLog(@"%@",date);
        NSLog(@"%@",[KTools tools_timeDateConvertToString:date dateFormatter:@"YYYY-MM-dd"]);
    }];
    pickerView.minLimitDate = [NSDate date];
    [pickerView show];
}
@end
