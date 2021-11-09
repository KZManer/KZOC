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
                PrivacyProtocolView *view = [[PrivacyProtocolView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
                
                [LEEAlert alert].config
                .LeeCustomView(view)
                .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
                .LeeHeaderColor([UIColor clearColor])
                .LeeClickBackgroundClose(YES)
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
            default:break;
        }
    });
}

- (void)buttonClicked {
    [LEEAlert closeWithCompletionBlock:^{
        NSLog(@"点击");
    }];
}


@end
