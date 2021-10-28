//
//  NavigationVC.m
//  demo
//
//  Created by KZ on 2021/10/25.
//

#import "NavigationVC.h"
#import "NavCustomView.h"
static CGFloat PAGEMENUVIEWHEIGHT = 1000;
static CGFloat topViewHeight = 120;
@interface NavigationVC ()<UIScrollViewDelegate,NavCustomViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NavCustomView *topView;

@end

@implementation NavigationVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = true;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = false;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake(0, PAGEMENUVIEWHEIGHT * 3);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, PAGEMENUVIEWHEIGHT)];
    firstView.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:.4];
    [self.scrollView addSubview:firstView];
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, PAGEMENUVIEWHEIGHT, self.view.width, PAGEMENUVIEWHEIGHT)];
    secondView.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:.4];
    [self.scrollView addSubview:secondView];
    
    UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, PAGEMENUVIEWHEIGHT * 2, self.view.width, PAGEMENUVIEWHEIGHT)];
    thirdView.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:.4];
    [self.scrollView addSubview:thirdView];
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    self.topView = [[NavCustomView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, topViewHeight)];
    self.topView = [[NavCustomView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, topViewHeight) menuTitles:[NavMenuModel menuModels]];
    self.topView.delegate = self;
    [self.view addSubview:self.topView];
    self.topView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.0];
    [self.topView hideModeImage];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alpha = scrollView.contentOffset.y / PAGEMENUVIEWHEIGHT;
    [self.topView pageMenuAlpha:alpha];
    self.topView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:alpha];
    if (alpha < 0.8) {
        [self.topView hideModeImage];
    } else {
        [self.topView showModeImage];
    }
    CGFloat scrollY = scrollView.contentOffset.y;
    if (scrollY >= PAGEMENUVIEWHEIGHT * 2 - topViewHeight) {
        [self.topView updateCollectionViewCellStatus:2];return;
    } else if (scrollY >= PAGEMENUVIEWHEIGHT - topViewHeight) {
        [self.topView updateCollectionViewCellStatus:1];return;
    } else {
        [self.topView updateCollectionViewCellStatus:0];return;
    }
}

#pragma mark - NavCustomViewDelegate

- (void)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)collectionViewCellDidSelect:(NSInteger)selectIndex {
    if (selectIndex == 0) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:true];
        return;
    }
    CGFloat scrollToY = PAGEMENUVIEWHEIGHT * selectIndex - topViewHeight;
    //scrollView的height
    CGFloat scrollMaxY = self.scrollView.contentSize.height - [KTools tools_heightOfScreen];
    CGFloat finalScrollToY = scrollToY > scrollMaxY ? scrollMaxY : scrollToY;
    [self.scrollView setContentOffset:CGPointMake(0, finalScrollToY) animated:YES];
}

@end
