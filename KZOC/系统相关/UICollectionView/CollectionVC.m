//
//  CollectionVC.m
//  demo
//
//  Created by KZ on 2021/10/25.
//
//https://randomuser.me/api/portraits/lego/2.jpg

#import "CollectionVC.h"
#import "CollectionCell.h"

static NSString *cellIdentifier = @"CollectionCellIdentifier";

@interface CollectionVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.datasource = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        int random = arc4random_uniform(10);
        NSLog(@"%d",random);
        [self.datasource addObject:[NSString stringWithFormat:@"https://randomuser.me/api/portraits/lego/%d.jpg",random]];
    }
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:[UICollectionViewFlowLayout new]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.collectionView];
}
#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datasource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    CGFloat redRandom =0.0, greenRandom =0.0, blueRandom = 0.0;
    for (int i = 0; i<3; i++) {
        int random = arc4random_uniform(255);
        if (i == 0) {
            redRandom = random * 1.0 / 255.0;
        } else if (i == 1) {
            greenRandom = random * 1.0 / 255.0;
        } else {
            blueRandom = random * 1.0 / 255.0;
        }
    }
    cell.contentView.backgroundColor = [UIColor colorWithRed:redRandom green:greenRandom blue:blueRandom alpha:0.6];
    
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int rowNum = 2;//每行4个cell
    return CGSizeMake((self.view.frame.size.width - 30)/2, (self.view.frame.size.width - 30)/2);
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
@end
