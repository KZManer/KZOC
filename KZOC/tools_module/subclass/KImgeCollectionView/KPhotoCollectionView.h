//
//  KPhotoCollectionView.h
//  Runner
//
//  Created by KZ on 2021/4/15.
//

#import <UIKit/UIKit.h>
@class KPhotoCollectionView;

NS_ASSUME_NONNULL_BEGIN

/** 照片的上下左右边距，用于计算collectionview的高度 */
extern int const kPhotoCellSpace;
/**每行放置的item数*/
extern int const kPhotoColumnNum;

@protocol KPhotoCollectionViewDelegate <NSObject>

@optional

/** 点击了照片：打开相册||预览该张照片 collectionView用于多个collectView的区分*/
- (void)kPhotoCVDelegatePressedPhoto:(NSInteger)index collectionView:(KPhotoCollectionView *_Nonnull)collectionView;

/** 点击了删除图片按钮 */
- (void)kPhotoCVDelegateDeletePhoto:(NSInteger)deleteIndex collectionView:(KPhotoCollectionView *_Nonnull)collectionView;

@end

@interface KPhotoCollectionView : UICollectionView

@property (nonatomic, weak) id<KPhotoCollectionViewDelegate> kDelegate;

/** 更新数据源 */
- (void)updateKPhotoCollectionViewWithNewArr:(NSArray<UIImage *> *)newArr;

@end

NS_ASSUME_NONNULL_END
