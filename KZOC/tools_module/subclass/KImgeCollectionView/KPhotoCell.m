//
//  KPhotoCell.m
//  Runner
//
//  Created by KZ on 2021/4/15.
//

#import "KPhotoCell.h"

NSString * const cellIdWithKPhotoCell = @"KPhotoCellIdentifier";
@interface KPhotoCell()

@property (strong, nonatomic) IBOutlet UIImageView *merImageView;


@end

@implementation KPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/** 展示<添加图片>的图片 */
- (void)echoAlbumAddPhoto:(UIImage *)image {
    self.merImageView.image = image;
    self.deleteImageBtn.hidden = YES;
}
/** 展示内容 */
- (void)echoContent:(UIImage *)image {
    self.merImageView.image = image;
    self.deleteImageBtn.hidden = NO;
}

@end
