//
//  KPhotoCollectionView.m
//  Runner
//
//  Created by KZ on 2021/4/15.
//

#import "KPhotoCell.h"
#import "KPhotoCollectionView.h"

int const kPhotoColumnNum = 4;//每行4个item
int const kPhotoCellSpace = 5;

@interface KPhotoCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray <UIImage *> *merPhotos;

@end

@implementation KPhotoCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([KPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:cellIdWithKPhotoCell];
}

/** 更新数据源 */
- (void)updateKPhotoCollectionViewWithNewArr:(NSArray<UIImage *> *)newArr {
    self.merPhotos = [NSMutableArray arrayWithArray:newArr];
    [self reloadData];
}

- (void)deleteImageBtnPressed:(UIButton *)button {

    if (self.kDelegate && [self.kDelegate respondsToSelector:@selector(kPhotoCVDelegateDeletePhoto:collectionView:)]) {
        [self.kDelegate kPhotoCVDelegateDeletePhoto:button.tag collectionView:self];
    }
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.merPhotos.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdWithKPhotoCell forIndexPath:indexPath];
    
    //设置删除按钮的tag，用于删除图片时使用
    cell.deleteImageBtn.tag = indexPath.item;
    //设置按钮点击事件
    [cell.deleteImageBtn addTarget:self action:@selector(deleteImageBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.row == self.merPhotos.count) {
        //展示<添加图片>这张图
        [cell echoAlbumAddPhoto:[UIImage imageNamed:@"k_add_photo"]];
    } else {    
        //展示内容
        [cell echoContent:self.merPhotos[indexPath.row]];
    }
    
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //代理将值传出去
    if (self.kDelegate && [self.kDelegate respondsToSelector:@selector(kPhotoCVDelegatePressedPhoto:collectionView:)]) {
        [self.kDelegate kPhotoCVDelegatePressedPhoto:indexPath.row collectionView:self];
    }
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemSide = (self.bounds.size.width - kPhotoCellSpace * (kPhotoColumnNum + 1)) / kPhotoColumnNum;
    return CGSizeMake(itemSide, itemSide);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //上 左 下 右
    return UIEdgeInsetsMake(kPhotoCellSpace, kPhotoCellSpace, kPhotoCellSpace, kPhotoCellSpace);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kPhotoCellSpace;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kPhotoCellSpace;
}
@end
