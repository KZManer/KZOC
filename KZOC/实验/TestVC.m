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
#import "KPickerView.h"

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
//        make.center.equalTo(self.view);
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@-80);
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
    
    UIImage *validImage = [UIImage imageNamed:@"q_es_print_valid"];
    CGFloat horSpace = 15;
    CGFloat imageViewH = validImage.size.height / validImage.size.width * (Width_Screen - horSpace * 2);
    NSLog(@"%f",imageViewH);
    UIImageView *imageView1 = [[UIImageView alloc]init];
    imageView1.image = validImage;
    [self.view addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(demoButton.mas_bottom).offset(20);
        make.left.equalTo(@(horSpace));
        make.right.equalTo(@(-horSpace));
        make.height.equalTo(@(imageViewH));
    }];
    UIView *rightView = [[UIView alloc]init];
    rightView.backgroundColor = UIColor.lightGrayColor;
    [imageView1 addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.width.equalTo(imageView1).multipliedBy(0.33);
    }];
    
    
    UIImage *invalidImage = [UIImage imageNamed:@"q_es_print_invalid"];
    CGFloat imageViewH1 = invalidImage.size.height / invalidImage.size.width * (Width_Screen - horSpace * 2);
    UIImageView *imageView2 = [[UIImageView alloc]init];
    imageView2.image = invalidImage;
    [self.view addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView1.mas_bottom).offset(20);
        make.left.equalTo(@(horSpace));
        make.right.equalTo(@(-horSpace));
        make.height.equalTo(@(imageViewH1));
    }];
    UIView *showView = [[UIView alloc]init];
    showView.backgroundColor = [UIColor.redColor colorWithAlphaComponent:.4];
    [imageView2 addSubview:showView];
    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0);
        make.width.equalTo(imageView2).multipliedBy(0.55);
    }];
    
}

- (void)pressedButton {
    [KPickerView showInView:self.tabBarController.view titleArr:@[@"1",@"2"] showIndex:0 finishHandler:^(NSInteger selectIndex) {
        NSLog(@"%ld",selectIndex);
    }];
}


@end
