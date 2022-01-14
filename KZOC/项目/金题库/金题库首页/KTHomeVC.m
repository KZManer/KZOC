//
//  KTHomeVC.m
//  KZOC
//
//  Created by KZ on 2021/11/15.
//

#import "KTHomeVC.h"
#import "UIViewController+KNavigation.h"
#import "QHomeSlidshowCell.h"
#import "QHomeEightItemCell.h"
#import "QHomeWelfareCell.h"
#import "QHomeVipQuestionsCell.h"
#import "SPPageMenu.h"
#import "QuestionChallengeVC.h"
#import "ExamDatumVC.h"
#import "ActivityInfoVC.h"
#import "KHomeTableView.h"

static const CGFloat kHeightSlideshow    = 120;//顶部轮播图高度
static const CGFloat kHeightEightItem    = 100;//八按钮高度
static const CGFloat kHeightWelfare      = 90;//福利轮播图高度
static const CGFloat kHeightVipQuestions = 115;//vip题库高度
static const CGFloat kHeightPageMenu     = 40;

@interface KTHomeVC ()<UITableViewDataSource,UITableViewDelegate,SPPageMenuDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) KHomeTableView *tableView;
@property (nonatomic, strong) SPPageMenu *pageMenu;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<UIViewController *> *childVCs;
@property (nonatomic, assign) CGFloat cutHeight;//吸顶触发的高度
@property (nonatomic, strong) UIScrollView *childScrollView;
@property (nonatomic, assign) CGFloat heightWelfare;//新人福利高度
@property (nonatomic, assign) CGFloat heightVipQuestions;//VIP题库高度

@end

@implementation KTHomeVC

#pragma mark - override method
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self doViewUI];
    [self doConfigNoti];
    [self configContent];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self cg_navHide];
}

#pragma mark custom method
- (void)doViewUI {
    self.view.backgroundColor = [UIColor whiteColor];
    //导航栏
    UIView *navigationView = [[UIView alloc]init];
    navigationView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:navigationView];
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(Height_Status));
        make.left.equalTo(@0);
        make.width.equalTo(@(Width_Screen));
        make.height.equalTo(@(Height_Navigation));
    }];
    //导航栏 - 返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[KTools tools_colorRandom] forState:UIControlStateNormal];
    backBtn.backgroundColor = [KTools tools_colorRandom];
    [backBtn addTarget:self action:@selector(pressedBackButton) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0);
        make.height.width.equalTo(navigationView.mas_height);
    }];
    //导航栏 - 更换
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeBtn setTitle:@"更换" forState:UIControlStateNormal];
    [changeBtn setTitleColor:[KTools tools_colorRandom] forState:UIControlStateNormal];
    changeBtn.backgroundColor = [KTools tools_colorRandom];
    [changeBtn addTarget:self action:@selector(pressedChangeButton) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(navigationView);
        make.height.width.equalTo(navigationView.mas_height);
    }];
    
    //tableView
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationView.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
    
    
}
- (void)doConfigNoti {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(childTableViewDidScroll:) name:Noti_ChildTableViewDidScroll object:nil];
}
- (void)configContent {
    //配置sppagemenu
    [self.pageMenu removeAllItems];
    for (UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
    
    [self.pageMenu setItems:@[@"真题闯关",@"考点资料",@"活动资讯"] selectedItemIndex:0];
    int i = 0;
    for (UIViewController *vc in @[[QuestionChallengeVC new],[ExamDatumVC new],[ActivityInfoVC new]]) {
        vc.view.frame = CGRectMake(Width_Screen * i, 0, Width_Screen, Height_Active_Max);
        [self addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
        i++;
    }
    
    self.scrollView.contentSize = CGSizeMake(Width_Screen * 3, 0);
    self.scrollView.contentOffset = CGPointMake(Width_Screen * self.pageMenu.selectedItemIndex, 0);
    
    
    //福利view的高度
    BOOL showWelfare = arc4random_uniform(10) < 5;
    NSLog(@"%d",showWelfare);
    self.heightWelfare = showWelfare ? kHeightWelfare : 0;
    //VIP题库高度
    BOOL showVipQuestions = arc4random_uniform(10) < 5;
    NSLog(@"%d",showVipQuestions);
    self.heightVipQuestions = showVipQuestions ? kHeightVipQuestions : 0;
    
    
    self.cutHeight = kHeightSlideshow + kHeightEightItem + self.heightWelfare + self.heightVipQuestions;
    
    [self.tableView reloadData];
    
    NSLog(@"外层tableView：%p",self.tableView);
    NSLog(@"外层scrolView：%p",self.scrollView);
}

#pragma mark gesture event
- (void)pressedBackButton {
    [self.navigationController popViewControllerAnimated:true];
}
- (void)pressedChangeButton {
    [self configContent];
}

#pragma mark notification method
- (void)childTableViewDidScroll:(NSNotification *)noti {
    UIScrollView *childScrollView = (UIScrollView *)noti.object;
    if (self.childScrollView != childScrollView) {
        self.childScrollView = childScrollView;
    }
//    NSLog(@"%f",self.tableView.contentOffset.y);
//    NSLog(@"通知：%p",childScrollView);
    if (self.tableView.contentOffset.y < self.cutHeight) {
        childScrollView.contentOffset = CGPointZero;
        self.childScrollView.showsVerticalScrollIndicator = false;
//        [[NSNotificationCenter defaultCenter] postNotificationName:Noti_ResetTableViewLocationToZero object:nil];
    } else {
        self.tableView.contentOffset = CGPointMake(0, self.cutHeight);
        self.childScrollView.showsVerticalScrollIndicator = true;
    }
}

#pragma mark - SPPageMenuDelegate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    if (toIndex == fromIndex) return;
    [self.scrollView setContentOffset:CGPointMake(Width_Screen * toIndex, 0) animated:labs(toIndex - fromIndex) == 1];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"主代理：%p",scrollView);
//    NSLog(@"%f",self.tableView.contentOffset.y);
    if (self.tableView == scrollView) {
        if ((self.childScrollView && self.childScrollView.contentOffset.y > 0)) {
            self.tableView.contentOffset = CGPointMake(0, self.cutHeight);
        }
        CGFloat offSetY = scrollView.contentOffset.y;
        if (offSetY < self.cutHeight) {
            [[NSNotificationCenter defaultCenter] postNotificationName:Noti_ResetTableViewLocationToZero object:nil];
        }
    }
}

#pragma mark UITableViewDataSource & UITableViewDelegate
#pragma mark 0-顶部轮播 1-八按钮 2-福利轮播 3-VIP题库 4-底部真题闯关 活动资讯...
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 4) return kHeightPageMenu;
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) return kHeightSlideshow;
    if (indexPath.section == 1) return kHeightEightItem;
    if (indexPath.section == 2) return self.heightWelfare;
    if (indexPath.section == 3) return self.heightVipQuestions;
    if (indexPath.section == 4) return Height_Active_Max - kHeightPageMenu;
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 4) return self.pageMenu;
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //顶部轮播图
        QHomeSlidshowCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdQHomeSlideshow];
        if (!cell) {
            cell = [[QHomeSlidshowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdQHomeSlideshow];
        }
        cell.backgroundColor = [[KTools tools_colorRandom]colorWithAlphaComponent:.4];
        return cell;
        
    } else if (indexPath.section == 1) {
        //八按钮
        QHomeEightItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdQHomeEightItem];
        if (!cell) {
            cell = [[QHomeEightItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdQHomeEightItem];
        }
        cell.backgroundColor = [[KTools tools_colorRandom]colorWithAlphaComponent:.4];
        return cell;
        
    } else if (indexPath.section == 2) {
        //福利轮播图
        QHomeWelfareCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdQHomeWelfare];
        if (!cell) {
            cell = [[QHomeWelfareCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdQHomeWelfare];
        }
        cell.backgroundColor = [[KTools tools_colorRandom]colorWithAlphaComponent:.4];
        return cell;
        
    } else if (indexPath.section == 3) {
        //vip题库
        QHomeVipQuestionsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdQHomeVipQuestions];
        if (!cell) {
            cell = [[QHomeVipQuestionsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdQHomeVipQuestions];
        }
        cell.backgroundColor = [[KTools tools_colorRandom]colorWithAlphaComponent:.4];
        return cell;
        
    } else if (indexPath.section == 4) {
        //底部pageMenu
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifierHomeCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifierHomeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor.purpleColor colorWithAlphaComponent:.4];
        [cell.contentView addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        cell.backgroundColor = [[KTools tools_colorRandom]colorWithAlphaComponent:.4];
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - lazy loading
- (KHomeTableView *)tableView {
    if (!_tableView) {
        _tableView = [[KHomeTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UIColor.whiteColor;
        [_tableView registerClass:[QHomeSlidshowCell class] forCellReuseIdentifier:CellIdQHomeSlideshow];
        [_tableView registerClass:[QHomeEightItemCell class] forCellReuseIdentifier:CellIdQHomeEightItem];
        [_tableView registerClass:[QHomeWelfareCell class] forCellReuseIdentifier:CellIdQHomeWelfare];
        [_tableView registerClass:[QHomeVipQuestionsCell class] forCellReuseIdentifier:CellIdQHomeVipQuestions];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}
- (SPPageMenu *)pageMenu {
    if (!_pageMenu) {
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectZero trackerStyle:SPPageMenuTrackerStyleLine];
        _pageMenu.delegate = self;
        _pageMenu.itemTitleFont = [UIFont boldSystemFontOfSize:18];
        _pageMenu.unSelectedItemTitleFont = [UIFont boldSystemFontOfSize:18];
        _pageMenu.selectedItemTitleColor = Color_RGB_Same(51);
        _pageMenu.unSelectedItemTitleColor = Color_RGB_Same(51);
        _pageMenu.tracker.backgroundColor = Color_RGB(56, 125, 252);
        _pageMenu.trackerWidth = 30;
        [_pageMenu setTrackerHeight:3 cornerRadius:1.5];
        _pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
        _pageMenu.dividingLine.hidden = YES;
        _pageMenu.bridgeScrollView = self.scrollView;
    }
    return _pageMenu;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = UIColor.whiteColor;
    }
    return _scrollView;
}
- (NSMutableArray<UIViewController *> *)childVCs {
    if (!_childVCs) {
        _childVCs = [NSMutableArray array];
    }
    return _childVCs;
}
@end

