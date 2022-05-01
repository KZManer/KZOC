//
//  KPhotoCell.h
//  Runner
//
//  Created by KZ on 2021/4/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const cellIdWithKPhotoCell;

@interface KPhotoCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIButton *deleteImageBtn;//删除图片按钮

/** 展示<添加图片>的图片 */
- (void)echoAlbumAddPhoto:(UIImage *)image;
/** 展示内容 */
- (void)echoContent:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
