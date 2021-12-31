//
//  GestureVC.m
//  KZOC
//
//  Created by Zzz... on 2021/12/3.
//

#import "GestureVC.h"
#import "GFirstVC.h"
#import "GSecondVC.h"

@interface GestureVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation GestureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width_Screen, 300)];
    headerView.backgroundColor = [[UIColor orangeColor]colorWithAlphaComponent:.4];
    self.tableView.tableHeaderView = headerView;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    GFirstVC *firstVC = [[GFirstVC alloc]init];
    GSecondVC *secondVC = [[GSecondVC alloc]init];
    [self addChildViewController:firstVC];
    [self addChildViewController:secondVC];
    firstVC.view.frame = CGRectMake(0, 0, Width_Screen, Height_Active_Max);
    secondVC.view.frame = CGRectMake(Width_Screen, 0, Width_Screen, Height_Active_Max);
    [self.scrollView addSubview:firstVC.view];
    [self.scrollView addSubview:secondVC.view];
    [self.scrollView setContentSize:CGSizeMake(Width_Screen * 2, 0)];
    
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Height_Active_Max;
}
//cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell.contentView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    cell.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:.4];
    return cell;
}

#pragma mark - lazy loading

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scrollView.pagingEnabled = true;
    }
    return _scrollView;
}

@end
