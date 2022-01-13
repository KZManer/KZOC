//
//  CLiveCourseVC.m
//  KingTalent
//
//  Created by Zzz... on 2022/1/4.
//

#import "CLiveCourseVC.h"
#import "SPPageMenu.h"
#import "UIButton+KImageText.h"
#import "CLiveCourseListView.h"
#import "LEEAlert.h"

@interface CLiveCourseVC ()<SPPageMenuDelegate>

//顶部item集合
@property (nonatomic, strong) NSMutableArray<UIButton *> *topItemBtns;
//活跃的item
@property (nonatomic, assign) CLCTopItemType activeItemType;

@property (nonatomic, strong) SPPageMenu *pageMenu;
@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation CLiveCourseVC

#pragma mark - override method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self doConfig];
    
    [self doNavUI];
    [self doViewUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self cg_navShowWithTranslucent:false showLine:true bgColor:UIColor.whiteColor];
}

#pragma mark - custom method
- (void)doConfig {
    self.activeItemType = CLCTopItemType_Unknown;
}
- (void)doNavUI {
    self.title = @"直播课";
    [self cg_navBackItemWithTintColor:nil selector:nil];
}
- (void)doViewUI {
    self.view.backgroundColor = UIColor.whiteColor;
    /**高端直播课&精品直播课&精选微课*/
    UIView *topItemView = [[UIView alloc]init];
    [self.view addSubview:topItemView];
    [topItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0);
        make.width.equalTo(self.view);
        make.height.equalTo(@90);
    }];
    //高端直播课...三按钮
    NSArray *topItemTitles = @[@"高端直播课",@"精品直播课",@"精选微课"];
    NSArray *topItemNorImages = @[@"co_lc_gaoduan_nor",@"co_lc_jingpin_nor",@"co_lc_jingxuan_nor"];
    NSArray *topItemSelImages = @[@"co_lc_gaoduan_sel",@"co_lc_jingpin_sel",@"co_lc_jingxuan_sel"];
    CGFloat topItemBtnWidth = Width_Screen/3.f;
    for (int i = 0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:topItemTitles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:topItemNorImages[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:topItemSelImages[i]] forState:UIControlStateSelected];
        [button setTitleColor:Color_Hex(@"#333333") forState:UIControlStateNormal];
        [button setTitleColor:Color_Hex(@"#387DFC") forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont font_fontPingFangSCBold:12];
        [button addTarget:self action:@selector(pressedTopItemButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.topItemBtns addObject:button];
        
        [topItemView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(topItemBtnWidth * i));
            make.width.equalTo(@(topItemBtnWidth));
            make.centerY.equalTo(@0);
            make.height.equalTo(topItemView);
        }];
        [button button_topImageBottomText:10];
    }
    
    /**SPPageMenu+筛选按钮*/
    UIView *pageMenuView = [[UIView alloc]init];
    pageMenuView.backgroundColor = Color_Hex(@"#F5F5F5");
//    pageMenuView.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:.4];
    [self.view addSubview:pageMenuView];
    [pageMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topItemView.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.equalTo(@40);
        
    }];
    
    /**筛选按钮*/
    UIButton *screeningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [screeningBtn setImage:[UIImage imageNamed:@"co_lc_screening"] forState:UIControlStateNormal];
    [screeningBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screeningBtn setTitleColor:Color_Hex(@"#666666") forState:UIControlStateNormal];
    screeningBtn.titleLabel.font = [UIFont font_fontPingFangSCMedium:14];
    [screeningBtn addTarget:self action:@selector(pressedScreeningButton) forControlEvents:UIControlEventTouchUpInside];
    [pageMenuView addSubview:screeningBtn];
    [screeningBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(@0);
        make.width.equalTo(@80);
    }];
    [screeningBtn button_leftTextRightImage:10];
    
    /**SPPageMenu*/
    [pageMenuView addSubview:self.pageMenu];
    self.pageMenu.bridgeScrollView = self.scrollView;
    [self.pageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0);
        make.right.equalTo(screeningBtn.mas_left);
    }];
    /**scrollView*/
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pageMenuView.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
    
    //默认点击第一个按钮（高端直播课）
    [self pressedTopItemButton:self.topItemBtns.firstObject];
}

- (void)configListView {
    //顶部按钮没有被点击的话，返回
    if (self.activeItemType == CLCTopItemType_Unknown) return;
    
    NSArray *pageMenuTitles = @[@"全部",@"最新",@"最热",@"最优惠"];
    CGFloat listViewHeight = Height_Active_Max - 130;
    /**根据点击不同按钮(顶部三item按钮)，做对应的数据处理*/
    //列表类型数组
    NSArray *listTypes = @[
        @(CLCListType_All),
        @(CLCListType_New),
        @(CLCListType_Hot),
        @(CLCListType_Discount),
    ];
    
    switch (self.activeItemType) {
        case CLCTopItemType_GaoDuan: {
            //点击了高端直播课
        } break;
        case CLCTopItemType_JingPin: {
            //点击了精品直播课
        } break;
        case CLCTopItemType_JingXuan: {
            //点击了精选微课
        } break;
        default: break;
    }
    
    [self.pageMenu removeAllItems];
    for (UIView *childView in self.scrollView.subviews) {
        [childView removeFromSuperview];
    }
    
    [self.pageMenu setItems:pageMenuTitles selectedItemIndex:0];
    for (int i = 0; i<4; i++) {
        NSNumber *listTypeNum = listTypes[i];
        CLiveCourseListView *listView = [[CLiveCourseListView alloc]initWithFrame:CGRectMake(Width_Screen * i, 0, Width_Screen, listViewHeight) topItemType:self.activeItemType listType:listTypeNum.integerValue];
        [self.scrollView addSubview:listView];
    }
    
    self.scrollView.contentSize = CGSizeMake(Width_Screen * listTypes.count, 0);
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

#pragma mark gesture event
- (void)pressedTopItemButton:(UIButton *)sender {
    NSInteger btnIndex = [self.topItemBtns indexOfObject:sender];
    self.activeItemType = btnIndex;
    //点击相同的按钮，不做操作
    if (self.activeItemType == CLCTopItemType_Unknown) return;
    
    for (UIButton *button in self.topItemBtns) {
        button.selected = false;
    }
    sender.selected = true;
    
    [self configListView];
}
//筛选按钮被点击
- (void)pressedScreeningButton {
    
    [LEEAlert actionsheet].config
        .LeeAddAction(^(LEEAction * _Nonnull action) {
            action.title = @"全部";
            action.titleColor = UIColor.lightGrayColor;
        })
        .LeeAddAction(^(LEEAction * _Nonnull action) {
            action.title = @"基础";
        })
        .LeeAddAction(^(LEEAction * _Nonnull action) {
            action.title = @"提高";
        })
        .LeeAddAction(^(LEEAction * _Nonnull action) {
            action.title = @"最优惠";
        })
        .LeeCancelAction(@"取消", ^{
            
        })
        .LeeShow();
}

#pragma mark - SPPageMenuDelegate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    if (fromIndex == toIndex) return;
    
    BOOL animated = labs(toIndex - fromIndex) < 2;
    
    [self.scrollView setContentOffset:CGPointMake(Width_Screen * toIndex, 0) animated:animated];
}

#pragma mark - lazy loading
- (NSMutableArray *)topItemBtns {
    if (!_topItemBtns) {
        _topItemBtns = [NSMutableArray array];
    }
    return _topItemBtns;
}
- (SPPageMenu *)pageMenu {
    if (!_pageMenu) {
        _pageMenu = [[SPPageMenu alloc]initWithFrame:CGRectZero trackerStyle:SPPageMenuTrackerStyleLine];
        _pageMenu.dividingLine.hidden = true;
        _pageMenu.delegate = self;
        _pageMenu.backgroundColor = UIColor.clearColor;
        _pageMenu.itemTitleFont = [UIFont font_fontPingFangSCMedium:14];
        _pageMenu.selectedItemTitleColor = Color_Hex(@"#333333");
        _pageMenu.unSelectedItemTitleColor = Color_Hex(@"#666666");
        _pageMenu.tracker.backgroundColor = Color_Hex(@"#387DFC");
        [_pageMenu setTrackerHeight:2 cornerRadius:1];
    }
    return _pageMenu;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = true;
    }
    return _scrollView;
}

@end
