//
//  ViewController.m
//  KZOC
//
//  Created by KZ on 2021/10/26.
//

#import "ViewController.h"
#import "SectionModel.h"
#import "HomeHeaderView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray <SectionModel *> *sectionInfos;

@end

@implementation ViewController

#pragma mark - override method

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日常记录";
    self.sectionInfos = [SectionModel allSectionInfos];
    [self.view addSubview:self.tableView];
}
- (void)viewWillLayoutSubviews {
    self.tableView.frame = self.view.frame;
    
//    extern int HOMEHEADERVIEWCELLHEIGHT;
//    extern int HOMEHEADERVIEWCELLCOLUMN;
    
    int headerViewCellRow = 1;
    NSArray *sectionTitles = [SectionModel sectionTitles];
    
    headerViewCellRow = (int)sectionTitles.count / HOMEHEADERVIEWCELLCOLUMN;
    if (sectionTitles.count % HOMEHEADERVIEWCELLCOLUMN != 0) {
        headerViewCellRow++;
    }
    CGFloat headerViewHeight = HOMEHEADERVIEWCELLHEIGHT * headerViewCellRow;
    
    /**header view*/
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    HomeHeaderView *headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, [KTools tools_widthOfScreen], headerViewHeight) collectionViewLayout:flowLayout titles:sectionTitles];
    self.tableView.tableHeaderView = headerView;
    
    /**footer view*/
    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    bottomLabel.text = @"end";
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:.3];
    self.tableView.tableFooterView = bottomLabel;
}
#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    SectionModel *model = self.sectionInfos[section];
    return model.name;
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
