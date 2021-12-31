//
//  GainGoldView.m
//  KZOC
//
//  Created by Zzz... on 2021/12/27.
//

#import "GainGoldView.h"
#import "UIButton+KImageText.h"
#import "SPPageMenu.h"
#import "GainGoldTbView.h"

static const CGFloat kHeightGoldBGImage = 155.f;//顶部图片背景的高度
static const CGFloat kHeightGoldBGImageWithPageMenu = 30.f;//顶部图片和pageMenu垂直方向的间隔
static const CGFloat kHeightPageMenu = 50.f;//pageMenu的高度

@interface GainGoldView ()<SPPageMenuDelegate>

@property (nonatomic, strong) UILabel *goldNumLabel;
@property (nonatomic, strong) SPPageMenu *pageMenu;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation GainGoldView

#pragma mark - override method
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}

#pragma mark private method
- (void)doViewUI {
    /**顶部我的金币custom view*/
    UIImageView *goldImageView = [[UIImageView alloc]init];
    goldImageView.image = [UIImage imageNamed:@"my_gold_bg"];
    goldImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:goldImageView];
    [goldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.equalTo(@(kHeightGoldBGImage - 15));
    }];
    //我的金币 字面量
    UILabel *goldTitleLabel = [[UILabel alloc]init];
    goldTitleLabel.text = @"我的金币";
    goldTitleLabel.textColor = UIColor.whiteColor;
    goldTitleLabel.font = [UIFont font_fontPingFangSC:15.f];
    [goldImageView addSubview:goldTitleLabel];
    [goldTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@30);
    }];
    //购买金币按钮
    UIButton *goldBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goldBuyBtn setTitle:@"购买金币" forState:UIControlStateNormal];
    [goldBuyBtn setImage:[UIImage imageNamed:@"my_gold_icon"] forState:UIControlStateNormal];
    goldBuyBtn.titleLabel.font = [UIFont font_fontPingFangSCBold:12.f];
    [goldBuyBtn addTarget:self action:@selector(pressedGoldBuyButton) forControlEvents:UIControlEventTouchUpInside];
    [goldImageView addSubview:goldBuyBtn];
    [goldBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@-15);
        make.width.equalTo(@90);
        make.height.equalTo(@28);
    }];
    [goldBuyBtn button_leftImageRightText:5.f];
    [goldBuyBtn view_setCornerRadius:14.f borderColor:UIColor.whiteColor borderWidth:1.f];
    //金币数量
    [goldImageView addSubview:self.goldNumLabel];
    [self.goldNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(goldTitleLabel.mas_bottom).offset(15);
        make.right.equalTo(goldBuyBtn.mas_left).offset(-5);
    }];
    
    /**SPPageMenu*/
    [self addSubview:self.pageMenu];
    [self.pageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goldImageView.mas_bottom).offset(kHeightGoldBGImageWithPageMenu);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.equalTo(@(kHeightPageMenu));
    }];
    [self.pageMenu setItems:@[@"日常任务",@"新手任务",@"进阶任务"] selectedItemIndex:0];
    self.pageMenu.bridgeScrollView = self.scrollView;
    [self.pageMenu view_setCornerRadius:10.f addRectCorners:UIRectCornerTopLeft|UIRectCornerTopRight];
    
    /**scrollView*/
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pageMenu.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
    
    for (int i = 0; i<3; i++) {
        GainGoldTbView *tbView = [[GainGoldTbView alloc]initWithFrame:CGRectMake(Width_Screen * i, 0, Width_Screen, Height_Active_Max - kHeightGoldBGImage - kHeightGoldBGImageWithPageMenu - kHeightPageMenu)];
        tbView.backgroundColor = [KTools tools_colorRandom];
        [self.scrollView addSubview:tbView];
    }
    self.scrollView.contentSize = CGSizeMake(Width_Screen * 3, 0);
    
    
    
    self.goldNumLabel.text = @"123454";
    
}

#pragma mark gesture event
//点击购买金币按钮
- (void)pressedGoldBuyButton {
    NSLog(@"%s",__func__);
}

#pragma mark - SPPageMenuDelegate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
}

#pragma mark - lazy loading
- (UILabel *)goldNumLabel {
    if (!_goldNumLabel) {
        _goldNumLabel = [[UILabel alloc]init];
        _goldNumLabel.textColor = Color_Hex(@"#FFE554");
        _goldNumLabel.font = [UIFont systemFontOfSize:65.f weight:UIFontWeightHeavy];
        _goldNumLabel.adjustsFontSizeToFitWidth = true;
        _goldNumLabel.minimumScaleFactor = 0.4;
    }
    return _goldNumLabel;
}
- (SPPageMenu *)pageMenu {
    if (!_pageMenu) {
        _pageMenu = [[SPPageMenu alloc]initWithFrame:CGRectZero trackerStyle:SPPageMenuTrackerStyleLine];
        _pageMenu.backgroundColor = UIColor.whiteColor;
        _pageMenu.trackerWidth = 30.f;
        _pageMenu.delegate = self;
        _pageMenu.selectedItemTitleFont = [UIFont font_fontPingFangSCBold:16.f];
        _pageMenu.unSelectedItemTitleFont = [UIFont font_fontPingFangSCBold:16.f];
        _pageMenu.selectedItemTitleColor = Color_Hex(@"#387DFC");
        _pageMenu.unSelectedItemTitleColor = Color_Hex(@"#333333");
        _pageMenu.tracker.backgroundColor = Color_Hex(@"#387DFC");
        _pageMenu.dividingLine.hidden = true;
        _pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    }
    return _pageMenu;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = Color_Hex(@"#F5F5F5");
        _scrollView.pagingEnabled = true;
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.showsVerticalScrollIndicator = false;
    }
    return _scrollView;
}

@end
