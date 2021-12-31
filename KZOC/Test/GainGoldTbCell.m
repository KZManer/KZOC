//
//  GainGoldTbCell.m
//  KZOC
//
//  Created by Zzz... on 2021/12/27.
//

#import "GainGoldTbCell.h"

NSString * const cellIdGainGoldTb = @"cellIdGainGoldTb";

@interface GainGoldTbCell ()

@property (nonatomic, strong) UIImageView *kImageView;
@property (nonatomic, strong) UILabel *kTitleLabel;
@property (nonatomic, strong) UILabel *kSubheadLabel;

@end

@implementation GainGoldTbCell

#pragma mark - override method
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self doViewUI];
    }
    return self;
}

#pragma mark private method
- (void)doViewUI {
    self.contentView.backgroundColor = Color_Hex(@"#F5F5F5");
    /**baseView*/
    UIView *baseView = [[UIView alloc]init];
    baseView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.bottom.equalTo(@0);
    }];
    /**分割线*/
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = Color_Hex(@"F5F5F5");
    [baseView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
        make.height.equalTo(@.5f);
    }];
    /**状态imageView*/
    [baseView addSubview:self.kImageView];
    [self.kImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@-25);
        make.size.equalTo(@(CGSizeMake(73, 28)));
    }];
    /**标题*/
    [baseView addSubview:self.kTitleLabel];
    [self.kTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.left.equalTo(@30);
        make.right.equalTo(self.kImageView.mas_left).offset(-5);
    }];
    /**子标题*/
    [baseView addSubview:self.kSubheadLabel];
    [self.kSubheadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.kTitleLabel);
        make.top.equalTo(self.kTitleLabel.mas_bottom);
        make.bottom.equalTo(@-8);
    }];
    
    bottomLine.backgroundColor = UIColor.redColor;
    self.kTitleLabel.text = @"完成3此快速练习（0/3）";
    self.kSubheadLabel.text = @"金币 +30";
}

#pragma mark lazy loading
- (UIImageView *)kImageView {
    if (!_kImageView) {
        _kImageView = [[UIImageView alloc]init];
    }
    return _kImageView;
}
- (UILabel *)kTitleLabel {
    if (!_kTitleLabel) {
        _kTitleLabel = [[UILabel alloc]init];
        _kTitleLabel.font = [UIFont font_fontPingFangSCMedium:14.f];
        _kTitleLabel.textColor = UIColor.blackColor;
        _kTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _kTitleLabel;
}
- (UILabel *)kSubheadLabel {
    if (!_kSubheadLabel) {
        _kSubheadLabel = [[UILabel alloc]init];
        _kSubheadLabel.font = [UIFont font_fontPingFangSCMedium:10.f];
        _kSubheadLabel.textColor = Color_Hex(@"#F77848");
        _kSubheadLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _kSubheadLabel;
}
@end
