//
//  CEToolsCell.m
//  KZOC
//
//  Created by Zzz... on 2021/12/6.
//

#import "CEToolsCell.h"
#import "UIButton+KImageText.h"

NSString * const CellIdChapterExerciseTools = @"CellIdChapterExerciseTools";

@interface CEToolsCell ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIImageView *kImageView;
@property (nonatomic, strong) UILabel *kLabel;

@end

@implementation CEToolsCell

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
    
    
    self.kLabel = [[UILabel alloc]init];
    self.kLabel.textColor = Color_Hex(@"#999999");
    self.kLabel.font = [UIFont font_fontPingFangSC:12];
    self.kLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.kLabel];
    [self.kLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-5));
        make.left.right.equalTo(self.contentView);
    }];
    
    self.kImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.kImageView];
    [self.kImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.kLabel.mas_top).offset(4);
        make.top.equalTo(@5);
        make.centerX.equalTo(@0);
    }];
}

#pragma mark - public method
- (void)echoContent:(CEToolsCellModel *)model {
    if (model.isSelected) {
        self.kLabel.text = model.selectTitle;
        self.kImageView.image = [UIImage imageNamed:model.selectImageName];
    } else {
        self.kLabel.text = model.normalTitle;
        self.kImageView.image = [UIImage imageNamed:model.normalImageName];
    }

}

@end
