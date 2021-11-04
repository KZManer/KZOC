//
//  CaptchaAlertView.m
//  KZOC
//
//  Created by KZ on 2021/11/1.
//

#import "CaptchaAlertView.h"

@implementation CaptchaAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}
- (void)doViewUI {
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)]];
    
    UIView *baseView = [[UIView alloc]init];
    [baseView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nothing)]];
    baseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-60);
        make.width.equalTo(self).multipliedBy(0.8);
        make.height.mas_equalTo(300);
    }];
    [baseView view_setCornerRadius:8 borderColor:nil borderWidth:0];
    //标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"为什么收不到验证码";
    titleLabel.textColor = Color_Hex(@"#333333");
    titleLabel.font = [UIFont font_fontPingFangSCBold:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.right.mas_equalTo(0);
    }];
    
    //内容
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont font_fontPingFangSC:14];
    contentLabel.textColor = Color_Hex(@"#666666");
    contentLabel.text = [NSString stringWithFormat:@"1.网络延时，服务器发出的短信验证码的速度的影响\n\n2.手机欠费或停机\n\n3.短信被当做骚扰短信拦截，查看手机里面的被拦截短信\n\n4.当天手机发送的信息超过最高短信条数的限制\n"];
    [baseView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    //按钮
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeButton setTitle:@"我知道了" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    closeButton.backgroundColor = Color_Hex(@"#387DFC");
    [closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).multipliedBy(0.3);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(0);
        make.top.equalTo(baseView.mas_bottom).offset(20);
    }];
    [closeButton view_setCornerRadius:22 borderColor:nil borderWidth:0];
    
}

- (void)hide {
    if (self.closeBlock) {
        self.closeBlock();
    }
}

- (void)nothing {
    
}

@end
