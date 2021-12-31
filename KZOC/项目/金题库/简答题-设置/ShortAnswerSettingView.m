//
//  ShortAnswerSettingView.m
//  KZOC
//
//  Created by Zzz... on 2021/12/8.
//

#import "ShortAnswerSettingView.h"
#import "UIButton+KImageText.h"

@interface ShortAnswerSettingView ()
/** 屏幕亮度 button */
@property (nonatomic, strong) UIButton *screenLightBtn;
/** 屏幕亮度 slider */
@property (nonatomic, strong) UISlider *slider;
/** 字体大小 button */
@property (nonatomic, strong) UIButton *fontSizeBtn;
/** 字体大小 小 按钮 */
@property (nonatomic, strong) UIButton *fontSmallBtn;
/** 字体大小 正常 按钮 */
@property (nonatomic, strong) UIButton *fontNormalBtn;
/** 字体大小 大 按钮 */
@property (nonatomic, strong) UIButton *fontBigBtn;
/** 夜间模式 button */
@property (nonatomic, strong) UIButton *darkModeBtn;
/** 夜间模式 switch */
@property (nonatomic, strong) UISwitch *darkModeSwitch;

@end

@implementation ShortAnswerSettingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
        [self doConfig];
    }
    return self;
}

- (void)doViewUI {
    self.backgroundColor = UIColor.whiteColor;
    CGFloat viewHeight = self.height / 3.f;
    
    /**屏幕亮度*/
    UIView *screenLightView = [[UIView alloc]init];
    [self addSubview:screenLightView];
    [screenLightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@(viewHeight));
    }];
    //屏幕亮度button
    [screenLightView addSubview:self.screenLightBtn];
    [self.screenLightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(@0);
    }];
    [self.screenLightBtn button_leftImageRightText:10.f];
    //屏幕亮度slider
    [screenLightView addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(screenLightView.mas_centerX);
        make.centerY.equalTo(@0);
        make.right.equalTo(@(-15));
    }];
    
    /**字体大小*/
    UIView *fontSizeView = [[UIView alloc]init];
    [self addSubview:fontSizeView];
    [fontSizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(screenLightView.mas_bottom);
        make.left.right.height.equalTo(screenLightView);
    }];
    
    //字体大小button
    [fontSizeView addSubview:self.fontSizeBtn];
    [self.fontSizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.screenLightBtn);
        make.centerY.equalTo(@0);
    }];
    [self.fontSizeBtn button_leftImageRightText:10.f];
    //三按钮（字体大、小、正常按钮）之间的间距
    CGFloat fontSizeBtnHorSpace = 10;
    CGFloat fontSizeBtnW = (self.width / 2 - 15 - 2 * fontSizeBtnHorSpace) / 3.f;
    CGFloat fontSizeBtnH = 30;
    //字体大小 - 小按钮
    [fontSizeView addSubview:self.fontSmallBtn];
    [self.fontSmallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fontSizeView.mas_centerX);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(fontSizeBtnW));
        make.height.equalTo(@(fontSizeBtnH));
    }];
    [self.fontSmallBtn view_setCornerRadius:4.f borderColor:Color_Hex(@"#387DFC") borderWidth:.8f];
    //字体大小 - 正常按钮
    [fontSizeView addSubview:self.fontNormalBtn];
    [self.fontNormalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fontSmallBtn.mas_right).offset(fontSizeBtnHorSpace);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(fontSizeBtnW));
        make.height.equalTo(@(fontSizeBtnH));
    }];
    [self.fontNormalBtn view_setCornerRadius:4.f borderColor:Color_Hex(@"#387DFC") borderWidth:.8f];
    //字体大小 - 大按钮
    [fontSizeView addSubview:self.fontBigBtn];
    [self.fontBigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fontNormalBtn.mas_right).offset(fontSizeBtnHorSpace);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(fontSizeBtnW));
        make.height.equalTo(@(fontSizeBtnH));
    }];
    [self.fontBigBtn view_setCornerRadius:4.f borderColor:Color_Hex(@"#387DFC") borderWidth:.8f];
    
    /**夜间模式*/
    UIView *darkModeView = [[UIView alloc]init];
    [self addSubview:darkModeView];
    [darkModeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fontSizeView.mas_bottom);
        make.left.right.height.equalTo(fontSizeView);
    }];
    //夜间模式button
    [darkModeView addSubview:self.darkModeBtn];
    [self.darkModeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.screenLightBtn);
        make.centerY.equalTo(@0);
    }];
    [self.darkModeBtn button_leftImageRightText:10.f];
    //夜间模式switch
    self.darkModeSwitch = [[UISwitch alloc]init];
    self.darkModeSwitch.onTintColor = Color_Hex(@"#387DFC");
    [self.darkModeSwitch addTarget:self action:@selector(switchDarkModeAction) forControlEvents:UIControlEventValueChanged];
    [darkModeView addSubview:self.darkModeSwitch];
    [self.darkModeSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(darkModeView.mas_centerX);
        make.centerY.equalTo(@0);
//        make.height.equalTo(@30);
//        make.width.equalTo(@60);
    }];
}
- (void)doConfig {
    
    [self.darkModeBtn setTitleColor:Color_Hex(@"#333333") forState:UIControlStateNormal];
    [self.darkModeBtn setImage:[UIImage imageNamed:@"q_ce_darkMode"] forState:UIControlStateNormal];
    
    self.darkModeSwitch.on = false;
}

#pragma mark - gesture event
//设置屏幕亮度
- (void)sliderScreenLight:(UISlider *)sender {
    [[UIScreen mainScreen] setBrightness:sender.value];
}
//切换日间｜夜间模式
- (void)switchDarkModeAction {
    
    self.screenLightBtn.selected = self.darkModeSwitch.on;
    self.fontSizeBtn.selected = self.darkModeSwitch.on;
    self.darkModeBtn.selected = self.darkModeSwitch.on;
    
    if (self.darkModeSwitch.on) {
        //夜间模式
        self.backgroundColor = Color_Hex(@"#0F2140");
        [self.screenLightBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.fontSizeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.darkModeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        //日间模式
        self.backgroundColor = UIColor.whiteColor;
        [self.screenLightBtn setTitleColor:Color_Hex(@"#333333") forState:UIControlStateNormal];
        [self.fontSizeBtn setTitleColor:Color_Hex(@"#333333") forState:UIControlStateNormal];
        [self.darkModeBtn setTitleColor:Color_Hex(@"#333333") forState:UIControlStateNormal];
    }
}

#pragma mark - public method
- (void)echoScreenLightSliderValue:(CGFloat)value {
    self.slider.value = value;
}

#pragma mark - lazy loading
//屏幕亮度 button
- (UIButton *)screenLightBtn {
    if (!_screenLightBtn) {
        _screenLightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _screenLightBtn.userInteractionEnabled = false;
        [_screenLightBtn setTitle:@"屏幕亮度" forState:UIControlStateNormal];
        [_screenLightBtn setTitleColor:Color_Hex(@"#333333") forState:UIControlStateNormal];
        _screenLightBtn.titleLabel.font = [UIFont font_fontPingFangSC:14.f];
        [_screenLightBtn setImage:[UIImage imageNamed:@"q_ce_screenLight"] forState:UIControlStateNormal];
        [_screenLightBtn setImage:[UIImage imageNamed:@"q_ce_dark_screenLight"] forState:UIControlStateSelected];
    }
    return _screenLightBtn;
}
- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc]init];
        _slider.minimumValue = 0.f;
        _slider.maximumValue = 1.f;
        _slider.continuous = true;
        [_slider addTarget:self action:@selector(sliderScreenLight:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}
//字体大小 button
- (UIButton *)fontSizeBtn {
    if (!_fontSizeBtn) {
        _fontSizeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fontSizeBtn.userInteractionEnabled = false;
        [_fontSizeBtn setTitle:@"字体大小" forState:UIControlStateNormal];
        [_fontSizeBtn setTitleColor:Color_Hex(@"#333333") forState:UIControlStateNormal];
        _fontSizeBtn.titleLabel.font = [UIFont font_fontPingFangSC:14.f];
        [_fontSizeBtn setImage:[UIImage imageNamed:@"q_ce_fontSize"] forState:UIControlStateNormal];
        [_fontSizeBtn setImage:[UIImage imageNamed:@"q_ce_dark_fontSize"] forState:UIControlStateSelected];
    }
    return _fontSizeBtn;
}
//字体大小 小 按钮
- (UIButton *)fontSmallBtn {
    if (!_fontSmallBtn) {
        _fontSmallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fontSmallBtn setTitle:@"小" forState:UIControlStateNormal];
        _fontSmallBtn.titleLabel.font = [UIFont font_fontPingFangSC:13];
        [_fontSmallBtn setTitleColor:Color_Hex(@"#387DFC") forState:UIControlStateNormal];
        [_fontSmallBtn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [_fontSmallBtn setBackgroundImage:[KTools tools_convertImageWithColor:Color_Hex(@"#387DFC")] forState:UIControlStateSelected];
    }
    return _fontSmallBtn;
}
//字体大小 正常 按钮
- (UIButton *)fontNormalBtn {
    if (!_fontNormalBtn) {
        _fontNormalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fontNormalBtn setTitle:@"正常" forState:UIControlStateNormal];
        _fontNormalBtn.titleLabel.font = [UIFont font_fontPingFangSC:13];
        [_fontNormalBtn setTitleColor:Color_Hex(@"#387DFC") forState:UIControlStateNormal];
        [_fontNormalBtn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [_fontNormalBtn setBackgroundImage:[KTools tools_convertImageWithColor:Color_Hex(@"#387DFC")] forState:UIControlStateSelected];
    }
    return _fontNormalBtn;
}
//字体大小 大 按钮
- (UIButton *)fontBigBtn {
    if (!_fontBigBtn) {
        _fontBigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fontBigBtn setTitle:@"大" forState:UIControlStateNormal];
        _fontBigBtn.titleLabel.font = [UIFont font_fontPingFangSC:13];
        [_fontBigBtn setTitleColor:Color_Hex(@"#387DFC") forState:UIControlStateNormal];
        [_fontBigBtn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [_fontBigBtn setBackgroundImage:[KTools tools_convertImageWithColor:Color_Hex(@"#387DFC")] forState:UIControlStateSelected];
    }
    return _fontBigBtn;
}
//夜间模式 button
- (UIButton *)darkModeBtn {
    if (!_darkModeBtn) {
        _darkModeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _darkModeBtn.userInteractionEnabled = false;
        [_darkModeBtn setTitle:@"夜间模式" forState:UIControlStateNormal];
        [_darkModeBtn setTitleColor:Color_Hex(@"#333333") forState:UIControlStateNormal];
        _darkModeBtn.titleLabel.font = [UIFont font_fontPingFangSC:14.f];
        [_darkModeBtn setImage:[UIImage imageNamed:@"q_ce_darkMode"] forState:UIControlStateNormal];
        [_darkModeBtn setImage:[UIImage imageNamed:@"q_ce_dark_darkMode"] forState:UIControlStateSelected];
    }
    return _darkModeBtn;
}

@end
