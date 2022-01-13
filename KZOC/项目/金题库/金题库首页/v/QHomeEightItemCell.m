//
//  QHomeEightItemCell.m
//  KingTalent
//
//  Created by Zzz... on 2022/1/12.
//

#import "QHomeEightItemCell.h"

NSString * const CellIdQHomeEightItem = @"CellIdQHomeEightItem";

@interface QHomeEightItemCell ()

@end

@implementation QHomeEightItemCell

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
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"八按钮";
    titleLabel.font = [UIFont font_fontPingFangSCMedium:28];
    titleLabel.textColor = [KTools tools_colorRandom];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - HomeEightBtnViewDelegate
- (void)dg_homeEightBtnPressed:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dg_homeEightItemDidSelect:)]) {
        [self.delegate dg_homeEightItemDidSelect:index];
    }
}


@end
