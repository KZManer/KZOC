//
//  ScrollView.m
//  KZOC
//
//  Created by KZ on 2021/11/15.
//

#import "ScrollView.h"
#import "SPPageMenu.h"

@interface ScrollView ()



@end

@implementation ScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}
- (void)doViewUI {
    
    //模拟导航栏
    UIView *navigationView = [[UIView alloc]init];
    navigationView.backgroundColor = Color_Hex(@"FFD39B");
    [self addSubview:navigationView];
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo([KTools tools_heightOfStatusAndNavigation]);
    }];
    UILabel *navigationLabel = [[UILabel alloc]init];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.text = @"导航栏";
    [navigationView addSubview:navigationLabel];
    [navigationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    UIScrollView *scrollFullView = [[UIScrollView alloc]init];
    [self addSubview:scrollFullView];
    [scrollFullView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(navigationView.mas_bottom);
    }];
    
    UIView *baseFullView = [[UIView alloc]init];
    [scrollFullView addSubview:baseFullView];
    [baseFullView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollFullView);
        make.width.equalTo(scrollFullView);
    }];
    
    
    //轮播图
    UIView *slideshowView = [[UIView alloc]init];
    slideshowView.backgroundColor = Color_Hex(@"#7AC5CD");
    [baseFullView addSubview:slideshowView];
    [slideshowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseFullView);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(160);
    }];
    UILabel *slideshowLabel = [[UILabel alloc]init];
    slideshowLabel.textAlignment = NSTextAlignmentCenter;
    slideshowLabel.text = @"轮播图";
    [slideshowView addSubview:slideshowLabel];
    [slideshowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    //八个按钮
    UIView *eightBtnView = [[UIView alloc]init];
    eightBtnView.backgroundColor = Color_Hex(@"#EED5D2");
    [baseFullView addSubview:eightBtnView];
    [eightBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(slideshowView.mas_bottom);
        make.height.mas_equalTo(200);
    }];
    UILabel *eightBtnLabel = [[UILabel alloc]init];
    eightBtnLabel.textAlignment = NSTextAlignmentCenter;
    eightBtnLabel.text = @"八按钮";
    [eightBtnView addSubview:eightBtnLabel];
    [eightBtnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    //福利图
    UIView *welfareView = [[UIView alloc]init];
    welfareView.backgroundColor = Color_Hex(@"#9AC0CD");
    [baseFullView addSubview:welfareView];
    [welfareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(eightBtnView.mas_bottom);
        make.height.mas_equalTo(80);
    }];
    //vip题库标题
    UIView *vipTitleView = [[UIView alloc]init];
    vipTitleView.backgroundColor = Color_Hex(@"CDCDB4");
    [baseFullView addSubview:vipTitleView];
    [vipTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(welfareView.mas_bottom);
        make.height.mas_equalTo(60);
    }];
    //vip题库内容
    UIView *vipView = [[UIView alloc]init];
    vipView.backgroundColor = Color_Hex(@"F08080");
    [baseFullView addSubview:vipView];
    [vipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(vipTitleView.mas_bottom);
        make.height.mas_equalTo(75);
    }];
    UILabel *vipLabel = [[UILabel alloc]init];
    vipLabel.text = @"vip题库内容";
    vipLabel.textAlignment = NSTextAlignmentCenter;
    [vipView addSubview:vipLabel];
    [vipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(vipView);
    }];
    
    SPPageMenu *pageMenuView = [SPPageMenu pageMenuWithFrame:CGRectZero trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    NSArray *titles = @[@"真题闯关",@"章节网课",@"考点广场"];
    [pageMenuView setItems:titles selectedItemIndex:0];
    pageMenuView.itemTitleFont = [UIFont font_fontPingFangSCBold:18];
    pageMenuView.unSelectedItemTitleFont = [UIFont font_fontPingFangSCBold:18];
    pageMenuView.selectedItemTitleColor = Color_RGB(56, 125, 252);
    pageMenuView.unSelectedItemTitleColor = Color_RGB_Same(51);
    pageMenuView.tracker.backgroundColor = Color_RGB(56, 125, 252);
    pageMenuView.trackerWidth = 72;
    [pageMenuView setTrackerHeight:3 cornerRadius:1.5];
    pageMenuView.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    pageMenuView.dividingLine.hidden = true;
    [baseFullView addSubview:pageMenuView];
    [pageMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(baseFullView);
        make.top.equalTo(vipView.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc]init];
    bottomScrollView.backgroundColor = UIColor.lightGrayColor;
    [baseFullView addSubview:bottomScrollView];
    [bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(baseFullView);
        make.top.equalTo(pageMenuView.mas_bottom);
        make.height.mas_equalTo([KTools tools_heightOfActiveAreaMin] - 50);
    }];
    
    //更新baseFullView的高度
    [baseFullView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(vipView.mas_bottom).with.offset(1000);
    }];
}
@end
