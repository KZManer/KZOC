//
//  ProjectVC.m
//  KZOC
//
//  Created by Zzz... on 2021/11/23.
//

#import "ProjectVC.h"
#import "SectionModel.h"
#import "HomeHeaderView.h"

@interface ProjectVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionInfos;

@end

@implementation ProjectVC

#pragma mark - override method

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sectionInfos = [SectionModel sectionProjectModels];
    [self.view addSubview:self.tableView];
}
- (void)viewWillLayoutSubviews {
    self.tableView.frame = self.view.frame;
    
    int headerViewCellRow = 1;
    NSArray *sectionTitles = [SectionModel sectionProjectTitles];
    
    headerViewCellRow = (int)sectionTitles.count / HOMEHEADERVIEWCELLCOLUMN;
    if (sectionTitles.count % HOMEHEADERVIEWCELLCOLUMN != 0) {
        headerViewCellRow++;
    }
    CGFloat headerViewHeight = HOMEHEADERVIEWCELLHEIGHT * headerViewCellRow;
    
    /**header view*/
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    HomeHeaderView *headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, [KTools tools_widthOfScreen], headerViewHeight) collectionViewLayout:flowLayout titles:sectionTitles];
    self.tableView.tableHeaderView = headerView;
}
#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = [SectionModel sectionProjectTitles][section];
    return title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [SectionModel sectionProjectTitles].count;
}
//cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray<SectionModel *> *rowArray = self.sectionInfos[section];
    return rowArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    SectionModel *model = self.sectionInfos[indexPath.section][indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SectionModel *model = self.sectionInfos[indexPath.section][indexPath.row];
    NSString *className = model.className;
    Class cls = NSClassFromString(className);
    UIViewController *vc = [cls new];
    vc.title = model.name;
    vc.hidesBottomBarWhenPushed = YES;
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
