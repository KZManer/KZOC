//
//  TestView.m
//  KZOC
//
//  Created by KZ on 2021/11/15.
//

#import "TestView.h"

@interface TestView ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField = [[UITextField alloc]init];
        self.textField.borderStyle = UITextBorderStyleLine;
        self.textField.placeholder = @"input something";
        [self.textField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(44);
        }];
    }
    return self;
}
- (void)textDidChanged:(UITextField *)textField {
    if (textField.text.length == 4) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(testViewGoTo)]) {
            [self.delegate testViewGoTo];
        }
    } else if (textField.text.length > 4){
        self.textField.text = [textField.text substringToIndex:4];
    }
}
@end
