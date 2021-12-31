//
//  TabAnimatedVC.m
//  KZOC
//
//  Created by KZ on 2021/11/15.
//

#import "TabAnimatedVC.h"
#import "TABAnimated.h"
#import "TabAnimatedCell.h"
#import "TabAnimatedCollectionCell.h"

static NSString *CellIdentifierTabAnimated = @"CellIdentifierTabAnimated";
static NSString *CellIdTabAnimatedCollectionCell = @"CellIdTabAnimatedCollectionCell";

@interface TabAnimatedVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TabAnimatedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[TabAnimatedCell class] forCellReuseIdentifier:CellIdentifierTabAnimated];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(0.5);
    }];
    
    self.tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[TabAnimatedCell class] cellHeight:120];
    self.tableView.tabAnimated.adjustBlock = ^(TABComponentManager * _Nonnull manager) {
//        manager.animation(2).remove();
//        manager.animation(3).remove();
//        manager.animation(4).height(18).space(5).line(4).radius(3);
    };
    [self.tableView tab_startAnimation];
    
    
    /**collectionView*/
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom).offset(20);
        make.left.bottom.right.equalTo(self.view);
    }];
    CGFloat w = (self.view.width - 50)/4.f;
    self.collectionView.tabAnimated = [TABCollectionAnimated animatedWithCellClass:[TabAnimatedCollectionCell class] cellSize:CGSizeMake(w, 100)];
    self.collectionView.tabAnimated.adjustBlock = ^(TABComponentManager * _Nonnull manager) {
        manager.animation(0).radius(30);
    };
    [self.collectionView tab_startAnimation];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
//cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    TabAnimatedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TabAnimatedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TabAnimatedCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdTabAnimatedCollectionCell forIndexPath:indexPath];
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int rowNum = 4;//每行4个cell
    return CGSizeMake((self.view.width - 30)/rowNum, 100);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //上 左 下 右
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

#pragma mark - lazy loading
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[TabAnimatedCollectionCell class] forCellWithReuseIdentifier:CellIdTabAnimatedCollectionCell];
    }
    return _collectionView;
}
@end
