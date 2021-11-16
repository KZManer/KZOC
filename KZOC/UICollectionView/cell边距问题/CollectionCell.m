//
//  CollectionCell.m
//  demo
//
//  Created by KZ on 2021/10/25.
//

#import "CollectionCell.h"
#import "SDWebImage.h"

@interface CollectionCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}

- (void)doViewUI {
    self.imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(50);
    }];
}
- (void)echoContent:(NSString *)imageLink indexPath:(NSIndexPath *)indexPath {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageLink]];
    if (indexPath.item < 4) {
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(80);
        }];
    }
    
}
@end
