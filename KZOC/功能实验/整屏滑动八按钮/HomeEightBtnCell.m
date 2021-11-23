//
//  HomeEightBtnCell.m
//  KZOC
//
//  Created by Zzz... on 2021/11/18.
//

#import "HomeEightBtnCell.h"
#import "UIButton+KImageText.h"
#import "SDWebImage.h"

NSString * const CellIdHomeEightBtn = @"CellIdHomeEightBtn";

@interface HomeEightBtnCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HomeEightBtnCell

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
    /**标题*/
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = Color_Hex(@"666666");
    self.titleLabel.font = [UIFont font_fontPingFangSCMedium:13];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
    }];
    
    /**图标*/
    self.imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-2);
        make.centerX.equalTo(self.contentView);
        make.width.height.equalTo(self.contentView.mas_height).multipliedBy(0.7);
    }];
    
}

#pragma mark - public method
- (void)echoContent:(HomeEightBtnModel *)model {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.imageLink]];
    self.titleLabel.text = model.title;
}

#pragma mark - lazy loading


@end
