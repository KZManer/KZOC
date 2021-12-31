//
//  GainGoldTbView.m
//  KZOC
//
//  Created by Zzz... on 2021/12/27.
//

#import "GainGoldTbView.h"
#import "GainGoldTbCell.h"

@interface GainGoldTbView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GainGoldTbView

#pragma mark - override method
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}

#pragma mark private method
- (void)doViewUI {
    self.tableView.frame = self.bounds;
    [self addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.f;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 45.f;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GainGoldTbCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdGainGoldTb];
    if (!cell) {
        cell = [[GainGoldTbCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdGainGoldTb];
    }
    return cell;
}

#pragma mark - lazy loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = Color_Hex(@"#F5F5F5");
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 5)];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, Height_Bottom_Space)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[GainGoldTbCell class] forCellReuseIdentifier:cellIdGainGoldTb];
    }
    return _tableView;
}
@end
