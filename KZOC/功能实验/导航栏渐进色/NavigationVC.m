//
//  NavigationVC.m
//  demo
//
//  Created by KZ on 2021/10/25.
//

#import "NavigationVC.h"
#import "NavCustomView.h"
static CGFloat height = 500;
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
    
    
    self.scrollView.contentSize = CGSizeMake(0, height * 4);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, height)];
    firstView.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:.4];
    [self.scrollView addSubview:firstView];
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, height, self.view.width, height)];
    secondView.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:.4];
    [self.scrollView addSubview:secondView];
    
    UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, height * 2, self.view.width, height)];
    thirdView.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:.4];
    [self.scrollView addSubview:thirdView];
    
    UIView *fourthView = [[UIView alloc]initWithFrame:CGRectMake(0, height * 3, self.view.width, height)];
    fourthView.backgroundColor = [[UIColor yellowColor]colorWithAlphaComponent:.4];
    [self.scrollView addSubview:fourthView];
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.topView = [[NavCustomView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, topViewHeight)];
    self.topView.delegate = self;
    [self.view addSubview:self.topView];
    self.topView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.0];
    [self.topView hideModeImage];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alpha = scrollView.contentOffset.y / height;
    [self.topView pageMenuAlpha:alpha];
    self.topView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:alpha];
    if (alpha < 0.8) {
        [self.topView hideModeImage];
    } else {
        [self.topView showModeImage];
    }
    [self.topView bridgeScrollView:self.scrollView];
//    CGFloat scrollY = scrollView.contentOffset.y;
//    if (scrollY >= height * 3 - topViewHeight) {
//        [self.topView changePageMenuIndex:2];
//    } else if (scrollY >= height * 2 - topViewHeight) {
//        [self.topView changePageMenuIndex:1];
//    } else {
//        [self.topView changePageMenuIndex:0];
//    }
    
    
}

#pragma mark - NavCustomViewDelegate
- (void)pageEnumClicked:(NSInteger)clickIndex {
    CGFloat scrollToY = height * (clickIndex + 1) - topViewHeight;
    //scrollView的height
    CGFloat scrollMaxY = self.scrollView.contentSize.height - [KTools tools_heightOfScreen];
    CGFloat finalScrollToY = scrollToY > scrollMaxY ? scrollMaxY : scrollToY;
    [self.scrollView setContentOffset:CGPointMake(0, finalScrollToY) animated:YES];
}

@end
