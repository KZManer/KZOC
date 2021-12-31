//
//  CollectionReuseVC.m
//  KZOC
//
//  Created by Zzz... on 2021/12/7.
//

#import "CollectionReuseVC.h"
#import "CollectionReuseCell.h"

static const CGFloat CellSide = 45.f;
static const CGFloat collectionViewSpace = 20;//collectionView的左右间距

@interface CollectionReuseVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat cellSpace;//cell之间的间距
@property (nonatomic, strong) NSMutableArray *numArrs;

@end

@implementation CollectionReuseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellSpace = (Width_Screen - collectionViewSpace * 2 - 5 * CellSide)/5;
    self.numArrs = [NSMutableArray array];
    for (int i = 0; i<100; i++) {
        [self.numArrs addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = UIColor.lightGrayColor;
    [self.collectionView registerClass:[CollectionReuseCell class] forCellWithReuseIdentifier:@"idid"];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(0.6);
    }];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.numArrs.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionReuseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"idid" forIndexPath:indexPath];
    [cell echoContent:[NSString stringWithFormat:@"%ld",indexPath.item]];
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CellSide, CellSide);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //上 左 下 右
    return UIEdgeInsetsMake(collectionViewSpace, 10, collectionViewSpace, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.cellSpace;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.cellSpace;
}


@end
