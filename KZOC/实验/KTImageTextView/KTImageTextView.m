//
//  KTImageTextView.m
//  KZOC
//
//  Created by Zzz... on 2021/12/18.
//

#import "KTImageTextView.h"
#import "KTImageTextCell.h"

@interface KTImageTextView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<KTImageTextModel *> *datasource;
@property (nonatomic, assign) NSInteger column;//一行几列
@property (nonatomic, assign) CGFloat rowHeight;//每行的高度
@end

@implementation KTImageTextView

#pragma mark - override method

- (instancetype)initWithFrame:(CGRect)frame datasource:(NSArray<KTImageTextModel *> *)datasource column:(NSInteger)column {
    self = [super initWithFrame:frame];
    if (self) {
        self.datasource = [NSArray arrayWithArray:datasource];
        self.column = column == -1 ? 3 : column;
        
        [self doViewUI];
    }
    return self;
}
//在下面这个方法中计算每行的高度
- (void)drawRect:(CGRect)rect {
    NSInteger count = self.datasource.count;
    NSInteger column = self.column;
    NSInteger row = 0;
    row = count / column;
    if (count % column != 0) row += 1;
    self.rowHeight = rect.size.height / row;
    [self.collectionView reloadData];
}
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.collectionView.backgroundColor = backgroundColor;
}

- (CGFloat)spaceImageText {
    return _spaceImageText == 0 ? 8 : _spaceImageText;
}
#pragma mark - private method
- (void)doViewUI {
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datasource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KTImageTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdKTImageText forIndexPath:indexPath];
    KTImageTextModel *model = self.datasource[indexPath.item];
    [cell echoContent:model spaceImageText:self.spaceImageText];
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dg_imageTextItemDidSelect:)]) {
        [self.delegate dg_imageTextItemDidSelect:indexPath.item];
    }
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.width / self.column, self.rowHeight);
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
        [_collectionView registerClass:[KTImageTextCell class] forCellWithReuseIdentifier:cellIdKTImageText];
        _collectionView.scrollEnabled = false;
        _collectionView.backgroundColor = UIColor.whiteColor;
    }
    return _collectionView;
}

@end
