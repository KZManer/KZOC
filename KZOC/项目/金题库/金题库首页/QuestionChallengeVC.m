//
//  QuestionChallengeVC.m
//  KZOC
//
//  Created by KZ on 2021/11/15.
//

#import "QuestionChallengeVC.h"

@interface QuestionChallengeVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QuestionChallengeVC

#pragma mark - override method
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_Hex(@"AEEEEE");
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0);
        make.height.equalTo(@(Height_Active_Max-40));
        make.width.equalTo(@(Width_Screen));
    }];
    NSLog(@"内层tableView：%p",self.tableView);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetLocationToZero) name:Noti_ResetTableViewLocationToZero object:nil];
}

#pragma mark notification method
- (void)resetLocationToZero {
    self.tableView.contentOffset = CGPointZero;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"子代理：%p",scrollView);
    [[NSNotificationCenter defaultCenter] postNotificationName:Noti_ChildTableViewDidScroll object:scrollView];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
//cell的个数
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [[KTools tools_colorRandom]colorWithAlphaComponent:.4];
    cell.textLabel.text = [NSString stringWithFormat:@"真题闯关 第%lu个Cell",indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [KTools tools_colorRandom];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *hintText = [NSString stringWithFormat:@"点击了真题闯关的第%lu个Cell",indexPath.row];
    [MBProgressHUD cg_textOnly:hintText];
}

#pragma mark - lazy loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
