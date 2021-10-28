//
//  NavCustomView.m
//  demo
//
//  Created by KZ on 2021/10/25.
//

#import "NavCustomView.h"
#import "SPPageMenu.h"

@interface NavCustomView ()<SPPageMenuDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) SPPageMenu *pageMenu;
@property (nonatomic, assign) BOOL clickedPageMenu;

@end

@implementation NavCustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}
- (void)doViewUI {
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton addTarget:self action:@selector(backButtonPressedAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.height.mas_equalTo(30);
        make.centerY.mas_equalTo(0);
    }];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.shareButton];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@-10);
        make.width.height.centerY.mas_equalTo(self.backButton);
    }];
    
    self.pageMenu = [SPPageMenu pageMenuWithFrame:CGRectZero trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    self.pageMenu.delegate = self;
    [self.pageMenu setItems:@[@"宝贝",@"评论",@"详情"] selectedItemIndex:0];
    self.pageMenu.alpha = 0;
    self.pageMenu.backgroundColor = [UIColor clearColor];
    UIColor *color = [UIColor colorWithRed:56/255.0 green:125/255.0 blue:252/255.0 alpha:1/1.0];
    self.pageMenu.selectedItemTitleColor = color;
    self.pageMenu.tracker.backgroundColor = color;
    self.pageMenu.trackerWidth = 40;
    [self.pageMenu setTrackerHeight:2 cornerRadius:0.2];
    self.pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    [self addSubview:self.pageMenu];
    [self.pageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
}

- (void)showModeImage {
    [self.backButton setImage:[UIImage imageNamed:@"back_show"] forState:UIControlStateNormal];
    [self.shareButton setImage:[UIImage imageNamed:@"share_show"] forState:UIControlStateNormal];
}

- (void)hideModeImage {
    [self.backButton setImage:[UIImage imageNamed:@"back_hide"] forState:UIControlStateNormal];
    [self.shareButton setImage:[UIImage imageNamed:@"share_hide"] forState:UIControlStateNormal];
}

- (void)pageMenuAlpha:(CGFloat)alpha {
    self.pageMenu.alpha = alpha;
}

- (void)backButtonPressedAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backButtonPressed)]) {
        [self.delegate backButtonPressed];
    }
}

#pragma mark - SPPageMenuDelegate

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
//    if (!self.clickedPageMenu) {
//        self.clickedPageMenu = true;
//        return;
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageEnumClicked:)]) {
        [self.delegate pageEnumClicked:toIndex];
    }
}

@end
