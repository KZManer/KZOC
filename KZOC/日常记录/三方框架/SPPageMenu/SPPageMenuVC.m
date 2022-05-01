//
//  SPPageMenuVC.m
//  demo
//
//  Created by KZ on 2021/10/25.
//

#import "SPPageMenuVC.h"
#import "SPPageMenu.h"

@interface SPPageMenuVC ()

@property (nonatomic, strong) SPPageMenu *pageMenu;
@property (nonatomic, strong) UIScrollView *scrollView;
 
@end

@implementation SPPageMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    self.pageMenu = [SPPageMenu pageMenuWithFrame:CGRectZero trackerStyle:SPPageMenuTrackerStyleLine];
    self.pageMenu.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"北京市",@"上海市",@"广州市"];
    [self.pageMenu setItems:titles selectedItemIndex:1];
    self.pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    self.pageMenu.trackerWidth = 30;
    self.pageMenu.tracker.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.pageMenu];
    [self.pageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.mas_equalTo(50);
    }];
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = true;
    self.scrollView.contentSize = CGSizeMake(self.view.width * 3, 1000);
    self.scrollView.contentOffset = CGPointMake(self.view.width, 0);
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pageMenu.mas_bottom);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@300);
    }];
    
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 1000)];
    firstView.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:.3];
    [self.scrollView addSubview:firstView];
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(self.view.width, 0, self.view.width, 1000)];
    secondView.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:.3];
    [self.scrollView addSubview:secondView];
    
    UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(self.view.width * 2, 0, self.view.width, 1000)];
    thirdView.backgroundColor = [[UIColor yellowColor]colorWithAlphaComponent:.3];
    [self.scrollView addSubview:thirdView];
    
    self.pageMenu.bridgeScrollView = self.scrollView;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.pageMenu.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
}

@end
