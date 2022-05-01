//
//  AddressCustomView.m
//  KZOC
//
//  Created by Zzz... on 2021/11/24.
//

#import "AddressCustomView.h"

@interface AddressCustomView ()

@end

@implementation AddressCustomView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder showArrow:(BOOL)showArrow isMutiLine:(BOOL)isMutiLine {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //左label
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = title;
        titleLabel.textColor = Color_Hex(@"#333333");
        titleLabel.font = [UIFont font_fontPingFangSCMedium:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(80);
        }];
        //右箭头
        UIImageView *rightArrow = [[UIImageView alloc]init];
        if (showArrow) {
            [self addSubview:rightArrow];
            UIImage *rightArrowImage = [UIImage imageNamed:@"c_arrow_right1"];
            rightArrow.image = rightArrowImage;
            [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(18);
                make.width.mas_equalTo(18.f * rightArrowImage.size.width / rightArrowImage.size.height);
                make.centerY.mas_equalTo(0);
            }];
        }
        if (isMutiLine) {
            //左title textView
            KTextView *titleView = [[KTextView alloc]init];
            titleView.text = title;
            titleView.textAlignment = NSTextAlignmentLeft;
            titleView.textColor = Color_Hex(@"#333333");
            titleView.font = [UIFont font_fontPingFangSCMedium:14];
            titleView.userInteractionEnabled = false;
            [self addSubview:titleView];
            [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.bottom.mas_equalTo(0);
                make.width.mas_equalTo(80);
            }];
            
            //右textView
            self.textView = [[KTextView alloc]init];
            self.textView.textColor = Color_Hex(@"#333333");
            self.textView.font = [UIFont font_fontPingFangSCMedium:14];
            self.textView.placeholder = placeholder;
            self.textView.placeholderColor = Color_Hex(@"#999999");
            self.textView.placeholderFont = [UIFont font_fontPingFangSCMedium:14];
            [self addSubview:self.textView];
            [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.right.equalTo(self).offset(-5);
                make.left.equalTo(titleLabel.mas_right).offset(0);
            }];
        } else {
            //右textField
            self.textField = [[UITextField alloc]init];
            self.textField.textColor = Color_Hex(@"#333333");
            self.textField.font = [UIFont font_fontPingFangSCMedium:14];
            NSAttributedString *placeholderAttributed = [[NSAttributedString alloc]initWithString:placeholder attributes:@{
                NSForegroundColorAttributeName:Color_Hex(@"#999999"),
                NSFontAttributeName:[UIFont font_fontPingFangSCMedium:14],
            }];
            self.textField.attributedPlaceholder = placeholderAttributed;
            [self addSubview:self.textField];
            [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                if (showArrow) {
                    make.right.equalTo(rightArrow.mas_left).offset(-5);
                } else {
                    make.right.equalTo(self).offset(-5);
                }
                make.left.equalTo(titleLabel.mas_right).offset(5);
            }];
        }
        
    }
    return self;
}

@end
