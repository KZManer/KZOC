//
//  LeeAlertVC.m
//  demo
//
//  Created by KZ on 2021/10/23.
//

#import "LeeAlertVC.h"
#import "LEEAlert.h"
#import "CaptchaAlertView.h"
#import "PrivacyProtocolView.h"

@interface LeeAlertVC ()

@end

@implementation LeeAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, width, height)];
    button.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:.3];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [KSelectView view]
        .kFrame(self.view.frame)
        .kBackgroundColor([[UIColor redColor]colorWithAlphaComponent:.4])
        .kDatasource(nil)
        .kShow(self.view)
        .kSelectCell(^(NSString * _Nonnull cellName, NSInteger cellIndex) {
            switch (cellIndex) {
                case 0: {
                    [LEEAlert alert].config
                        .LeeCustomView(button)
                        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
                        .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
                        .LeeClickBackgroundClose(YES)
                        .LeeCornerRadius(0)
                        .LeeOpenAnimationDuration(0.5)
                        .LeeCloseAnimationDuration(0.5)
                        .LeeBackgroundStyleBlur(UIBlurEffectStyleExtraLight)
                        .LeeOpenAnimationStyle(LEEAnimationStyleOrientationTop)
                        .LeeCloseAnimationStyle(LEEAnimationStyleOrientationTop)
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
                            }else{
                                return 0.0f;
                            }
                        })
                        .LeeShow();
                }break;
                case 1: {
                    CaptchaAlertView *alertView = [[CaptchaAlertView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
                    alertView.closeBlock = ^{
                        [LEEAlert closeWithCompletionBlock:nil];
                    };
                    [LEEAlert alert].config
                        .LeeCustomView(alertView)
                        .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
                        .LeeHeaderColor([UIColor clearColor])
                        .LeeClickBackgroundClose(YES)
#ifdef __IPHONE_13_0
                        .LeeUserInterfaceStyle(UIUserInterfaceStyleLight)
#endif
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
                            }else{
                                return 0.0f;
                            }
                        })
                        .LeeShow();
                }break;
                case 2:{
                    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
                    view.backgroundColor = [UIColor orangeColor];
                    [LEEAlert alert].config
                        .LeeCustomView(view)
                        .LeeItemInsets(UIEdgeInsetsZero)
                        .LeeHeaderInsets(UIEdgeInsetsZero)
                        .LeeShow();
                    
                }break;
                case 3: {
                    [LEEAlert alert].config
                        .LeeTitle(@"当前的考试目标是")
                        .LeeContent(@"临床执业医师")
                        .LeeAction(@"确定更换", ^{
                            
                        })
                        .LeeAction(@"我再想想", ^{
                            
                        })
                        .LeeShow();
                }break;
                case 4: {
                    [LEEAlert alert].config
                        .LeeAddTitle(^(UILabel * _Nonnull label) {
                            label.text = @"当前的考试目标是";
                            label.font = [UIFont font_fontPingFangSCBold:16];
                            label.textColor = [UIColor blackColor];
                        })
                        .LeeAddContent(^(UILabel * _Nonnull label) {
                            NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"临床执业医师"];
                            [string setAttributes:@{
                                NSForegroundColorAttributeName:Color_Hex(@"387DFC"),
                                NSFontAttributeName:[UIFont font_fontPingFangSC:14],
                            } range:NSMakeRange(0, 6)];
                            label.attributedText = string;
                        })
                        .LeeAddAction(^(LEEAction * _Nonnull action) {
                          //确定更换
                            action.title = @"确定更换";
                            action.titleColor = [UIColor whiteColor];
                            action.backgroundColor = Color_Hex(@"387DFC");
                            action.height = 30;
                            action.cornerRadius = 15;
                            action.insets = UIEdgeInsetsMake(10, 20, 19, 20);
                        })
                        .LeeAddAction(^(LEEAction * _Nonnull action) {
                            //我再想想
                            action.title = @"我再想想";
                            action.titleColor = Color_Hex(@"387DFC");
                            action.backgroundColor = [UIColor whiteColor];
                        })
                        .LeeShow();
                }break;
                case 5: {
                    [LEEAlert alert].config
                        .LeeAddCustomView(^(LEECustomView * _Nonnull custom) {
                            custom.view = [self examTargetPopupView];
                            custom.isAutoWidth = true;
                        })
                        .LeeItemInsets(UIEdgeInsetsZero)
                    .LeeHeaderInsets(UIEdgeInsetsZero)
                    .LeeMaxHeight(210)
                    .LeeClickBackgroundClose(true)
                        .LeeShow();
                }break;
                default:break;
            }
        });
}

- (void)buttonClicked {
    [LEEAlert closeWithCompletionBlock:^{
        NSLog(@"点击");
    }];
}

//考试目标弹窗
- (UIView *)examTargetPopupView {
    
    UIColor *themeColor = Color_Hex(@"387DFC");
    
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 210, 200)];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"您当前的考试目标是";
    titleLabel.font = [UIFont font_fontPingFangSCMedium:16];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"临床执业医师";
    contentLabel.textColor = themeColor;
    contentLabel.font = [UIFont font_fontPingFangSCMedium:14];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    certainBtn.backgroundColor = themeColor;
    [certainBtn setTitle:@"确定更换" forState:UIControlStateNormal];
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = [UIFont font_fontPingFangSC:14];
    [baseView addSubview:certainBtn];
    [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(20);
        make.centerX.equalTo(baseView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(180);
    }];
    [certainBtn view_setCornerRadius:15 borderColor:nil borderWidth:0];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn setTitle:@"我再想想" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:themeColor forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont font_fontPingFangSC:14];
    [baseView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(certainBtn.mas_bottom).offset(15);
        make.centerX.equalTo(baseView);
        make.height.mas_equalTo(30);
        make.width.equalTo(certainBtn);
    }];
    [cancelBtn view_setCornerRadius:15 borderColor:themeColor borderWidth:.8f];
    
    return baseView;
}
@end
