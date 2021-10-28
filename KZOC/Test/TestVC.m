//
//  TestVC.m
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import "TestVC.h"
#import "SPPageMenu.h"

@interface TestVC ()

@property (nonatomic, strong) SPPageMenu *pageMenu;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation TestVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    self.pageMenu = [SPPageMenu pageMenuWithFrame:CGRectZero trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    self.pageMenu.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"北京市",@"上海市",@"广州市"];
    [self.pageMenu setItems:titles selectedItemIndex:1];
    self.pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    self.pageMenu.trackerWidth = self.view.width / 3.0;
    self.pageMenu.tracker.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.pageMenu];
    [self.pageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.mas_equalTo(50);
    }];
    
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = true;
    CGFloat oneHeight = [KTools tools_heightOfActiveArea] - 50;
    self.scrollView.contentSize = CGSizeMake(self.view.width, oneHeight * 3);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pageMenu.mas_bottom);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@300);
    }];
    
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, oneHeight)];
    firstView.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:.3];
    [self.scrollView addSubview:firstView];
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, oneHeight, self.view.width, oneHeight)];
    secondView.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:.3];
    [self.scrollView addSubview:secondView];
    
    UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, oneHeight * 2, self.view.width, oneHeight)];
    thirdView.backgroundColor = [[UIColor yellowColor]colorWithAlphaComponent:.3];
    [self.scrollView addSubview:thirdView];
    
    self.pageMenu.bridgeScrollView = self.scrollView;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.pageMenu.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
}


@end
