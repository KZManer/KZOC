//
//  PrivacyProtocolView.m
//  KZOC
//
//  Created by KZ on 2021/11/8.
//

#import "PrivacyProtocolView.h"
#import "KTextView.h"

@interface PrivacyProtocolView ()

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *linkTexts;
@property (nonatomic, strong) UIFont *contentFont;

@end

@implementation PrivacyProtocolView

#pragma mark - override method

- (instancetype)initWithFrame:(CGRect)frame content:(NSString *)content linkTexts:(NSArray *)linkTexts contentFont:(nonnull UIFont *)contentFont{
    self = [super initWithFrame:frame];
    if (self) {
        self.content = content;
        self.linkTexts = [NSArray arrayWithArray:linkTexts];
        self.contentFont = contentFont;
        [self doViewUI];
    }
    return self;
}

#pragma mark - private method

- (void)doViewUI {
    [self view_setCornerRadius:10 borderColor:nil borderWidth:0];
    self.backgroundColor = UIColor.whiteColor;
    /**标题*/
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"隐私保护说明";
    titleLabel.font = [UIFont font_fontPingFangSCBold:22];
    titleLabel.textColor = Color_Hex(@"#333333");
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    /*不同意按钮*/
    UIButton *rejectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rejectBtn setTitle:@"不同意" forState:UIControlStateNormal];
    [rejectBtn setTitleColor:Color_Hex(@"#387DFC") forState:UIControlStateNormal];
    [self addSubview:rejectBtn];
    [rejectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(self.width/3);
        make.right.equalTo(self.mas_centerX).offset(-10);
    }];
    [rejectBtn view_setCornerRadius:22 borderColor:Color_Hex(@"#387DFC") borderWidth:1];

    /**同意按钮*/
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [agreeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    agreeBtn.backgroundColor = Color_Hex(@"#387DFC");
    [self addSubview:agreeBtn];
    [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rejectBtn.mas_top);
        make.width.height.equalTo(rejectBtn);
        make.left.equalTo(self.mas_centerX).offset(10);
    }];
    [agreeBtn view_setCornerRadius:22 borderColor:nil borderWidth:1];
    
    /**内容*/
    KTextView *textView = [[KTextView alloc]init];
    [textView kTextViewProtocolWithText:self.content linkColor:Color_Hex(@"#387DFC") linkTexts:self.linkTexts linkHandler:^(int linkIndex) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(dg_privacyPressedLinkIndex:)]) {
            [self.delegate dg_privacyPressedLinkIndex:linkIndex];
        }
    }];
    textView.font = self.contentFont;
    [self addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.equalTo(titleLabel.mas_bottom);
        make.bottom.equalTo(rejectBtn.mas_top).offset(-10);
    }];
}

#pragma mark - gesture event
/**点击了不同意按钮*/
- (void)pressedRejectButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dg_privacyAgreeOrNotButtonPressed:)]) {
        [self.delegate dg_privacyAgreeOrNotButtonPressed:false];
    }
}
/**点击了同意按钮*/
- (void)pressedAgressButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dg_privacyAgreeOrNotButtonPressed:)]) {
        [self.delegate dg_privacyAgreeOrNotButtonPressed:true];
    }
}

@end
