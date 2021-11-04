//
//  TestVC.m
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC


- (void)viewDidLoad {
    [super viewDidLoad];
    UITextField *tf1 = [[UITextField alloc]init];
    tf1.kTextFieldType = KTextFieldTypePhone;
    tf1.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:tf1];
    [tf1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    UITextField *tf2 = [[UITextField alloc]init];
    tf2.kTextFieldType = KTextFieldTypePassword;
    tf2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:tf2];
    [tf2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tf1.mas_bottom).offset(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    UITextField *tf3 = [[UITextField alloc]init];
    tf3.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:tf3];
    [tf3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tf2.mas_bottom).offset(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    UITextField *tf4 = [[UITextField alloc]init];
    tf4.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:tf4];
    [tf4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tf3.mas_bottom).offset(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
}

@end
