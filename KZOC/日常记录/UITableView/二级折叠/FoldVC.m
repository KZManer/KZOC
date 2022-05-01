//
//  FoldVC.m
//  KZOC
//
//  Created by Zzz... on 2021/11/23.
//

#import "FoldVC.h"
#import "FoldHeaderView.h"
#import "FoldCell.h"

@interface FoldVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *sectionArr;
@property (nonatomic, strong) NSArray *countArr;

@end

@implementation FoldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.sectionArr = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0"]];
    self.countArr = @[@3,@10,@1,@4,@7];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 44;
    if (@available(ios 15.0,*)) {
        self.tableView.sectionHeaderTopPadding = 0;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //symbol_plus
    //symbol_minus
    FoldHeaderView *headerView = [[FoldHeaderView alloc]initWithFrame:CGRectZero];
    NSLog(@"%lu",section);
    [headerView setPressedAction:^(FoldHeaderView * _Nonnull view) {
        BOOL unfold = [self.sectionArr[section] boolValue];
        [self.sectionArr replaceObjectAtIndex:section withObject:unfold ? @"0" : @"1"];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        NSRange range = NSMakeRange(indexPath.section, 1);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    }];
    BOOL unfold = [self.sectionArr[section] boolValue];
    NSString *plusLogo = unfold ? @"symbol_minus" : @"symbol_plus";
    NSString *title = [NSString stringWithFormat:@"第%lu章",section+1];
    [headerView echoContent:plusLogo title:title unfold:unfold];
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArr.count;
}
//cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BOOL unfold = [self.sectionArr[section] boolValue];
    if (unfold) {
        NSNumber *number = self.countArr[section];
        int aa = [number intValue];
        return aa;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdFold];
    if (!cell) {
        cell = [[FoldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdFold];
    }
    int count = [self.countArr[indexPath.section] intValue];
    BOOL lastRow = count == indexPath.row + 1 ? true : false;
    [cell echoContent:[NSString stringWithFormat:@"第%lu节",indexPath.row + 1] lastRow:lastRow];
    return cell;
}

@end
