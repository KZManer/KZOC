//
//  KZHomeBaseView.m
//  KZOC
//
//  Created by KZ on 2022/5/1.
//

#import "KZHomeBaseView.h"
#import "SectionModel.h"
#import "HomeHeaderView.h"

@interface KZHomeBaseView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *proTitles;
@property (nonatomic, strong) NSArray<NSArray<SectionModel *> *> *sectionInfos;

@end

@implementation KZHomeBaseView

#pragma mark - override method

- (instancetype)initWithFrame:(CGRect)frame projectTitles:(NSArray *)titles sectionInfos:(NSArray<NSArray<SectionModel *> *> *)sectionInfos {
    self = [super initWithFrame:frame];
    if (self) {
        self.proTitles = [NSArray arrayWithArray:titles];
        self.sectionInfos = [NSArray arrayWithArray:sectionInfos];
        [self doViewUI];
    }
    return self;
}

#pragma mark - private method

- (void)doViewUI {
    [self addSubview:self.tableView];
    int headerViewCellRow = 1;
    
    headerViewCellRow = (int)self.proTitles.count / HOMEHEADERVIEWCELLCOLUMN;
    if (self.proTitles.count % HOMEHEADERVIEWCELLCOLUMN != 0) {
        headerViewCellRow++;
    }
    CGFloat headerViewHeight = HOMEHEADERVIEWCELLHEIGHT * headerViewCellRow;
    
    /**header view*/
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    HomeHeaderView *headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, [KTools tools_widthOfScreen], headerViewHeight) collectionViewLayout:flowLayout titles:self.proTitles];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.proTitles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray<SectionModel *> *rowArr = self.sectionInfos[section];
    return rowArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.proTitles[section];
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
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    SectionModel *model = self.sectionInfos[indexPath.section][indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dg_homeDidSelectRowWithTitle:className:)]) {
        [self.delegate dg_homeDidSelectRowWithTitle:model.name className:model.className];
    }
}

#pragma mark - lazy loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
