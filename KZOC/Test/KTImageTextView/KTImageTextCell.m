//
//  KTImageTextCell.m
//  KZOC
//
//  Created by Zzz... on 2021/12/18.
//

#import "KTImageTextCell.h"
#import "UIButton+KImageText.h"

NSString * const cellIdKTImageText = @"cellIdKTImageText";

@interface KTImageTextCell ()

@property (nonatomic, strong) UIImageView *kImageView;
@property (nonatomic, strong) UILabel *kTitleLabel;

@end

@implementation KTImageTextCell

#pragma mark - override method
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        UIView *baseView = [[UIView alloc]init];
        [self.contentView addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.width.equalTo(self.contentView);
        }];
        
        [baseView addSubview:self.kImageView];
        [self.kImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(baseView);
            make.centerX.equalTo(baseView);
        }];
        
        [baseView addSubview:self.kTitleLabel];
        [self.kTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kImageView.mas_bottom);
            make.centerX.equalTo(baseView);
            make.width.equalTo(baseView);
            make.bottom.equalTo(baseView);
        }];
    }
    return self;
}

#pragma mark - public method
- (void)echoContent:(KTImageTextModel *)model spaceImageText:(CGFloat)spaceImaegText {
    
    [self.kTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.kImageView.mas_bottom).offset(spaceImaegText);
    }];
    
    self.kImageView.image = [UIImage imageNamed:model.imageName];
    self.kTitleLabel.text = model.titleName;
}

#pragma mark - lazy loading

- (UIImageView *)kImageView {
    if (!_kImageView) {
        _kImageView = [[UIImageView alloc]init];
        _kImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _kImageView;
}
- (UILabel *)kTitleLabel {
    if (!_kTitleLabel) {
        _kTitleLabel = [[UILabel alloc]init];
        _kTitleLabel.textColor = Color_Hex(@"#333333");
        _kTitleLabel.font = [UIFont font_fontPingFangSC:12.f];
        _kTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _kTitleLabel;
}
@end
