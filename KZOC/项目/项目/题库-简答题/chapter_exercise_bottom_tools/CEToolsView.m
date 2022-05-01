//  CE：Chapter Exercise（章节练习）
//  CEToolsView.m
//  KZOC
//
//  Created by Zzz... on 2021/12/6.
//

#import "CEToolsView.h"
#import "CEToolsCell.h"

@interface CEToolsView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<CEToolsCellModel *> *datasource;

@end

@implementation CEToolsView

#pragma mark - override method
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}

#pragma mark - private method
- (void)doViewUI {
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = Color_Hex(@"#999999");
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@0.5);
    }];

    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
}

#pragma mark - public method
- (void)echoContent:(NSArray<CEToolsCellModel *> *)models {
    self.datasource = [NSArray arrayWithArray:models];
    [self.collectionView reloadData];
}
- (void)reloadData {
    [self.collectionView reloadData];
}
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datasource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CEToolsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdChapterExerciseTools forIndexPath:indexPath];
    [cell echoContent:self.datasource[indexPath.item]];
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CEToolsCellModel *model = self.datasource[indexPath.item];
    model.isSelected = !model.isSelected;
    [collectionView reloadData];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dg_toolsViewCellPressed:)]) {
        [self.delegate dg_toolsViewCellPressed:(int)indexPath.item];
    }
//    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.frame.size.width / self.datasource.count;
    CGFloat height = self.frame.size.height;
    return CGSizeMake(width, height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //上 左 下 右
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - lazy loading
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[CEToolsCell class] forCellWithReuseIdentifier:CellIdChapterExerciseTools];
    }
    return _collectionView;
}
@end
