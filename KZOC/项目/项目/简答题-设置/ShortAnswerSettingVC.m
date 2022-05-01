//
//  ShortAnswerSettingVC.m
//  KZOC
//
//  Created by Zzz... on 2021/12/8.
//

#import "ShortAnswerSettingVC.h"
#import "ShortAnswerSettingView.h"
#import "LEEAlert.h"

@interface ShortAnswerSettingVC ()
@property (nonatomic, strong) ShortAnswerSettingView *settingView;
@end

@implementation ShortAnswerSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doNavUI];
    [self doViewUI];
}
- (void)doNavUI {
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"c_more"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressedSettingItem)];
    self.navigationItem.rightBarButtonItem = settingItem;
}
- (void)doViewUI {
    self.view.backgroundColor = UIColor.whiteColor;
}

#pragma mark - gesture event

- (void)pressedSettingItem {
    
    CGFloat brightness = [UIScreen mainScreen].brightness;
    [self.settingView echoScreenLightSliderValue:brightness];
    
    [LEEAlert alert].config
    .LeeCustomView(self.settingView)
    .LeeHeaderInsets(UIEdgeInsetsZero)
    .LeeItemInsets(UIEdgeInsetsZero)
    .LeeCornerRadius(0)
    .LeeClickBackgroundClose(true)
    .LeeBackgroundStyleTranslucent(.4f)
    .LeeOpenAnimationDuration(.3f)
    .LeeCloseAnimationDuration(.3f)
    .LeeOpenAnimationStyle(LEEAnimationStyleOrientationTop)
    .LeeCloseAnimationStyle(LEEAnimationStyleOrientationBottom)
    .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type, CGSize size) {
        if (type == LEEScreenOrientationTypeVertical) {
            return Width_Screen;
        }
        return 0.f;
    })
    
        .LeeShow()
    ;
}

#pragma mark - lazy loading
- (ShortAnswerSettingView *)settingView {
    if (!_settingView) {
        _settingView = [[ShortAnswerSettingView alloc]initWithFrame:CGRectMake(0, 0, Width_Screen, 160)];
    }
    return _settingView;
}

@end
