//
//  ViewController.m
//  KZOC
//
//  Created by KZ on 2021/10/26.
//

#import "ViewController.h"
#import "SectionModel.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray <SectionModel *> *sectionInfos;

@end

@implementation ViewController

#pragma mark - override method

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sectionInfos = [SectionModel allSectionInfos];
    [self.view addSubview:self.tableView];
}
- (void)viewWillLayoutSubviews {
    self.tableView.frame = self.view.frame;
}
#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

/**自定义section header view*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeaderView = [[UIView alloc]init];
    sectionHeaderView.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.width, 30)];
    SectionModel *model = self.sectionInfos[section];
    label.text = model.name;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    [sectionHeaderView addSubview:label];
    return sectionHeaderView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionInfos.count;
}
//cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionModel *model = self.sectionInfos[section];
    return model.rowNames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    SectionModel *model = self.sectionInfos[indexPath.section];
    cell.textLabel.text = model.rowNames[indexPath.row];
    UIColor *bgColor = indexPath.section % 2 == 0 ? [[UIColor blueColor]colorWithAlphaComponent:.2] : [[UIColor greenColor]colorWithAlphaComponent:.2];
    cell.contentView.backgroundColor = bgColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SectionModel *model = self.sectionInfos[indexPath.section];
    NSString *className = model.classNames[indexPath.row];
    Class cls = NSClassFromString(className);
    UIViewController *vc = [cls new];
    vc.title = model.rowNames[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
