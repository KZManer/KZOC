//
//  ShortAnswerQuestionView.m
//  KZOC
//
//  Created by Zzz... on 2021/12/4.
//

#import "ShortAnswerQuestionView.h"
#import "ShortAnswerQuestionCell.h"


@interface ShortAnswerQuestionView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,CEToolsViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CEToolsView *toolsView;
/**底部工具栏*/
@property (nonatomic, strong) NSArray<CEToolsCellModel *> *toolsModels;
/**当前活跃的cell*/
@property (nonatomic, strong) ShortAnswerQuestionCell *activeCell;
/**当前活跃的cell的下标*/
@property (nonatomic, assign) int activeCellIndex;

@end

@implementation ShortAnswerQuestionView

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
    /**底部按钮base view*/
    UIView *bottomView = [[UIView alloc]init];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@(Height_TabBar));
    }];
    //四按钮view
    self.toolsView = [[CEToolsView alloc]init];
    self.toolsView.delegate = self;
    [bottomView addSubview:self.toolsView];
    [self.toolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@49);
    }];
    
    /** collection view */
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.bottom.equalTo(bottomView.mas_top);
    }];
}

#pragma mark - public method
- (void)echoContent:(NSArray<CEToolsCellModel *> *)models {
    self.toolsModels = [NSArray arrayWithArray:models];
    [self.toolsView echoContent:models];
}

#pragma mark - CEToolsViewDelegate
//底部功能按钮被点击
- (void)dg_toolsViewCellPressed:(int)index {
    if (index == 1) {
        CEToolsCellModel *model = self.toolsModels[index];
//        model.isSelected = !model.isSelected;
//        [self.toolsView reloadData];
        NSLog(@"%d",model.isSelected);
        [self.activeCell changeBottomContentWithShowAnswer:model.isSelected];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index = scrollView.contentOffset.x / Width_Screen;
    NSLog(@"%d",index);
    self.activeCellIndex = index;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    self.activeCell = (ShortAnswerQuestionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
}
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShortAnswerQuestionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdShortAnswerQuestion forIndexPath:indexPath];
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.width, Height_Active_Min);
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
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = true;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[ShortAnswerQuestionCell class] forCellWithReuseIdentifier:CellIdShortAnswerQuestion];
    }
    return _collectionView;
}

@end
