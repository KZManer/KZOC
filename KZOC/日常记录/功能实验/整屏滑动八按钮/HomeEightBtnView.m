//
//  HomeEightBtnView.m
//  KZOC
//
//  Created by Zzz... on 2021/11/18.
//

#import "HomeEightBtnView.h"
#import "HomeEightBtnCell.h"

static NSString *cellIdentifier = @"cellIdentifier";
int leftPageControlWidth = 18;
int rightPageControlWidth = 6;
int pageControlWidth = 30;


@interface HomeEightBtnView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *leftPageControl;
@property (nonatomic, strong) UIView *rightPageControl;
/**是不是在第一屏*/
@property (nonatomic, assign) BOOL inFirstScreen;
/**活跃态指示器的背景色*/
@property (nonatomic, strong) UIColor *activeColor;
/**非活跃态指示器的背景色*/
@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, strong) NSArray<HomeEightBtnModel *> *eightBtnModels;

@end

@implementation HomeEightBtnView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.inFirstScreen = true;
        self.activeColor = Color_Hex(@"#4085FC");
        self.normalColor = Color_Hex(@"#BCC3CF");
        [self doViewUI];
    }
    return self;
}

- (void)doViewUI {
    self.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = true;
    self.collectionView.bounces = false;
    self.collectionView.showsHorizontalScrollIndicator = false;
    [self.collectionView registerClass:[HomeEightBtnCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(80);
    }];
    
    UIView *pageControl = [[UIView alloc]init];
    [self addSubview:pageControl];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom);
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(pageControlWidth);
    }];
    
    self.leftPageControl = [[UIView alloc]init];
    self.leftPageControl.backgroundColor = self.activeColor;
    [pageControl addSubview:self.leftPageControl];
    
    float leftPageControlHeight = 3.f;
    [self.leftPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(leftPageControlHeight);
        make.width.mas_equalTo(leftPageControlWidth);
        make.left.centerY.equalTo(pageControl);
    }];
    [self.leftPageControl view_setCornerRadius:leftPageControlHeight/2 borderColor:nil borderWidth:0];
    
    self.rightPageControl = [[UIView alloc]init];
    self.rightPageControl.backgroundColor = self.normalColor;
    [pageControl addSubview:self.rightPageControl];
    [self.rightPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.leftPageControl);
        make.width.mas_equalTo(rightPageControlWidth);
        make.right.centerY.equalTo(pageControl);
    }];
    [self.rightPageControl view_setCornerRadius:leftPageControlHeight/2 borderColor:nil borderWidth:0];
    
}

#pragma mark - public method

- (void)echoContent:(NSArray<HomeEightBtnModel *> *)eightBtnModels {
    self.eightBtnModels = [NSArray arrayWithArray:eightBtnModels];
    [self.collectionView reloadData];
}


#pragma makr - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.collectionView) return;
    
    float screenWidth = [KTools tools_widthOfScreen];
    
    float xOffset = scrollView.contentOffset.x;
    
    if (xOffset == screenWidth) {
        //滑到了第二屏
        [self.leftPageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(rightPageControlWidth);
        }];
        [self.rightPageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(leftPageControlWidth);
        }];
        self.leftPageControl.backgroundColor = self.normalColor;
        self.rightPageControl.backgroundColor = self.activeColor;
        self.leftPageControl.alpha = 1.f;
        self.rightPageControl.alpha = 1.f;
        return;
    }
    if (xOffset == 0) {
        //滑到了第一屏
        [self.leftPageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(leftPageControlWidth);
        }];
        [self.rightPageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(rightPageControlWidth);
        }];
        self.leftPageControl.backgroundColor = self.activeColor;
        self.rightPageControl.backgroundColor = self.normalColor;
        self.leftPageControl.alpha = 1.f;
        self.rightPageControl.alpha = 1.f;
        return;
    }
    
    float ratio = xOffset / screenWidth;
    if (self.inFirstScreen) {
        //在第一屏滑动
        float leftWidth = leftPageControlWidth + (pageControlWidth - leftPageControlWidth) * ratio;
        [self.leftPageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(leftWidth);
        }];
        self.rightPageControl.alpha = 1 - ratio;
        
    } else {
        //在第二屏滑动
        ratio = 1 - ratio;
        float rightWith = leftPageControlWidth + (pageControlWidth - leftPageControlWidth) * ratio;
        [self.rightPageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(rightWith);
        }];
        self.leftPageControl.alpha = 1 - ratio;
    }
    NSLog(@"%f",scrollView.contentOffset.x);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.leftPageControl.alpha = 1.f;
    self.rightPageControl.alpha = 1.f;
    
    if (scrollView.contentOffset.x == 0) {
        self.inFirstScreen = true;
    } else {
        self.inFirstScreen = false;
    }
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.eightBtnModels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeEightBtnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [KTools tools_colorRandom];
    
    HomeEightBtnModel *model = self.eightBtnModels[indexPath.item];
    [cell echoContent:model];
    
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float w = ([KTools tools_widthOfScreen] ) / 4.0;
    return CGSizeMake(w, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //上 左 下 右
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
