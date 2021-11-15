//
//  ShearView.m
//  KZOC
//
//  Created by KZ on 2021/11/15.
//

#import "ShearView.h"
#import "KTextField.h"

@interface ShearView ()

@property (nonatomic, strong) KTextField *textField;

@end

@implementation ShearView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField = [[KTextField alloc]init];
        self.textField.backgroundColor = Color_Hex(@"#E6E6E6");
        self.textField.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *placeholderAttr = [[NSMutableAttributedString alloc]initWithString:@"请输入10位激活码" attributes:@{
            NSForegroundColorAttributeName:[UIColor lightGrayColor],
            NSFontAttributeName:[UIFont font_fontPingFangSCMedium:20],
        }];
        [self.textField addTarget:self action:@selector(textFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        self.textField.attributedPlaceholder = placeholderAttr;
        self.textField.font = [UIFont font_fontPingFangSCMedium:20];
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(180);
            make.left.mas_equalTo(25);
            make.right.mas_equalTo(-25);
            make.height.mas_equalTo(45);
        }];
    }
    return self;
}

//监听textFiled输入变化
- (void)textFieldTextChanged:(UITextField *)sender {
    if (sender == self.textField) {
        NSString *text = self.textField.text;
        if (text.length < 10) {
//            self.hintLabel.text = @"";//清空提示label
//            self.activationBtn.enabled = false;
        } else if (text.length == 10) {
//            self.activationBtn.enabled = true;
//            if (self.delegate && [self.delegate respondsToSelector:@selector(dg_cdKeyFillCdKeyFillOver:)]) {
//                [self.delegate dg_cdKeyFillCdKeyFillOver:text];
//            }
            NSLog(@"go to");
        } else {
            
            self.textField.text = [text substringToIndex:10];
            
            UITextPosition *position = [self.textField endOfDocument];
            NSLog(@"%@",position);
            [self.textField textRangeFromPosition:position toPosition:position];
            
            NSLog(@"go to 2");
            
        }
    }
}
@end
