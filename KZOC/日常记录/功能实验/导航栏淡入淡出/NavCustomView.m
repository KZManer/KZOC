//
//  NavCustomView.m
//  demo
//
//  Created by KZ on 2021/10/25.
//

#import "NavCustomView.h"
#import "NavCustomViewCell.h"

static int CollectionViewHeight = 40;

@interface NavCustomView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, assign) BOOL clickedPageMenu;

@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) UICollectionView *collectionView;
/**选中的菜单项下标*/
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation NavCustomView

- (instancetype)initWithFrame:(CGRect)frame menuTitles:(NSArray *)menuTitles {
    self = [super initWithFrame:frame];
    if (self) {
        self.menuTitles = [NSArray arrayWithArray:menuTitles];
        self.selectIndex = 0;
        [self doVVUI];
    }
    return self;
}

#pragma mark - private method
- (void)doVVUI {
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton addTarget:self action:@selector(backButtonPressedAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.height.mas_equalTo(30);
        make.centerY.mas_equalTo(0);
    }];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.shareButton];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@-10);
        make.width.height.centerY.mas_equalTo(self.backButton);
    }];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.alpha = 0;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[NavCustomViewCell class] forCellWithReuseIdentifier:CellIdentifierNavCustomeView];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(CollectionViewHeight);
    }];
}

- (void)showModeImage {
    [self.backButton setImage:[UIImage imageNamed:@"back_show"] forState:UIControlStateNormal];
    [self.shareButton setImage:[UIImage imageNamed:@"share_show"] forState:UIControlStateNormal];
}

- (void)hideModeImage {
    [self.backButton setImage:[UIImage imageNamed:@"back_hide"] forState:UIControlStateNormal];
    [self.shareButton setImage:[UIImage imageNamed:@"share_hide"] forState:UIControlStateNormal];
}

- (void)backButtonPressedAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backButtonPressed)]) {
        [self.delegate backButtonPressed];
    }
}

#pragma mark public method

- (void)pageMenuAlpha:(CGFloat)alpha {
    self.collectionView.alpha = alpha;
}

- (void)updateCollectionViewCellStatus:(NSInteger)index {
    if (self.selectIndex == index) return;
    NavMenuModel *oldModel = self.menuTitles[self.selectIndex];
    oldModel.active = false;
    NavMenuModel *newModel = self.menuTitles[index];
    newModel.active = true;
    
    self.selectIndex = index;
    
    [self.collectionView reloadData];
}

#pragma makr - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.menuTitles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NavCustomViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierNavCustomeView forIndexPath:indexPath];
    [cell echoContent:self.menuTitles[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.width/3, CollectionViewHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.selectIndex) return;
    
    //更新标题的活跃态
    NavMenuModel *oldModel = self.menuTitles[self.selectIndex];
    oldModel.active = false;
    NavMenuModel *newModel = self.menuTitles[indexPath.row];
    newModel.active = true;
    
    self.selectIndex = indexPath.item;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionViewCellDidSelect:)]) {
        [self.delegate collectionViewCellDidSelect:indexPath.item];
        [self.collectionView reloadData];
    }
}

@end
