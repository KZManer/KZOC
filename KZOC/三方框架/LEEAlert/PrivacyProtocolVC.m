//
//  PrivacyProtocolVC.m
//  KZOC
//
//  Created by KZ on 2021/11/8.
//

#import "PrivacyProtocolVC.h"
#import "PrivacyProtocolView.h"
#import "LEEAlert.h"

@interface PrivacyProtocolVC ()<PricacyProtocolViewDelegate>

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation PrivacyProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doViewUI];
}
- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.safeAreaInsets.top);
        make.left.mas_equalTo(self.view.safeAreaInsets.left);
        make.right.mas_equalTo(self.view.safeAreaInsets.right);
        make.bottom.mas_equalTo(-self.view.safeAreaInsets.bottom);
    }];
}
- (void)doViewUI {
    
    UIImageView *imageView = [[UIImageView alloc]init];
    self.bgImageView = imageView;
    imageView.image = [UIImage imageNamed:@"启动图"];
    [self.view addSubview: imageView];
    
    
    NSString *privacyText = @"\u3000欢迎使用金题库APP！为给您提供优质的服务、控制业务风险、保障信息和资金安全，本应用使用过程中，需要联网，需要在必要范围内收集、使用您的个人信息。请您在使用前仔细阅读《用户协议》和《隐私协议》条款，同意后开启我们的服务。\n \u3000本应用在使用期间，我们需要申请获取您的系统权限，我们将在首次调用时逐项询问您是否允许使用该权限，也可以在您的设备系统“设置”里管理相关权限。";
    UIFont *contentFont = [UIFont font_fontPingFangSC:20];
    CGFloat privacyView = [KTools tools_widthOfScreen] - 60;
    CGFloat contentHeight = [KTools tools_getTextHeight:privacyText width:privacyView font:contentFont];
    PrivacyProtocolView *view = [[PrivacyProtocolView alloc]initWithFrame:CGRectMake(0, 0, privacyView, 180 + contentHeight) content:privacyText linkTexts:@[@"《用户协议》",@"《隐私协议》"] contentFont:contentFont];

    [LEEAlert alert].config
    .LeeCustomView(view)
    .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderColor([UIColor clearColor])
    .LeeClickBackgroundClose(false)
    .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type, CGSize size) {
        if (type == LEEScreenOrientationTypeVertical) {
            return CGRectGetWidth([[UIScreen mainScreen] bounds]);
        } else {
            return 0.0f;
        }
    })
    .LeeConfigMaxHeight(^CGFloat(LEEScreenOrientationType type, CGSize size) {
        if (type == LEEScreenOrientationTypeVertical) {
            return CGRectGetHeight([[UIScreen mainScreen] bounds]);
        } else {
            return 0.0f;
        }
    })
    .LeeShow();
}

#pragma mark - PricacyProtocolViewDelegate
- (void)dg_privacyPressedLinkIndex:(int)linkIndex {
    NSLog(@"%d",linkIndex);
}
- (void)dg_privacyAgreeOrNotButtonPressed:(BOOL)agree {
    
}
@end
