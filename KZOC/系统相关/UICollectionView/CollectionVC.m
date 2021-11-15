//
//  CollectionVC.m
//  demo
//
//  Created by KZ on 2021/10/25.
//
//https://randomuser.me/api/portraits/lego/2.jpg

#import "CollectionVC.h"
#import "CollectionCell.h"
#import "TwoVC.h"

static NSString *cellIdentifier = @"CollectionCellIdentifier";

@interface CollectionVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.datasource = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        if (i < 4) {
            [self.datasource addObject:@"https://randomuser.me/api/portraits/men/75.jpg"];
        } else {
            [self.datasource addObject:@"https://randomuser.me/api/portraits/thumb/men/75.jpg"];
        }
//        int random = arc4random_uniform(10);
//        NSLog(@"%d",random);
//        [self.datasource addObject:[NSString stringWithFormat:@"https://randomuser.me/api/portraits/lego/%d.jpg",random]];
    }
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nothing)];
    tap.cancelsTouchesInView = false;
    [self.view addGestureRecognizer:tap];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-0);
        make.bottom.mas_equalTo(-200);
    }];
    self.collectionView.backgroundColor = [UIColor orangeColor];
}
- (void)nothing {
    NSLog(@"%s",__func__);
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datasource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [KTools tools_colorRandom];
    [cell echoContent:self.datasource[indexPath.row] indexPath:indexPath];
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"come in");
    TwoVC *twoVC = [[TwoVC alloc]init];
    [self.navigationController pushViewController:twoVC animated:true];
}
#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.width / 4;
    CGFloat height = width;
    return CGSizeMake(width, height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //上 左 下 右
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

@end
