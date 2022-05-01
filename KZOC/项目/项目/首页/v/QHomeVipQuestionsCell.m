//
//  QHomeVipQuestionsCell.m
//  KingTalent
//
//  Created by Zzz... on 2022/1/12.
//

#import "QHomeVipQuestionsCell.h"

NSString * const CellIdQHomeVipQuestions = @"CellIdQHomeVipQuestions";

@interface QHomeVipQuestionsCell ()

@end

@implementation QHomeVipQuestionsCell

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
    titleLabel.text = @"VIP题库商品";
    titleLabel.font = [UIFont font_fontPingFangSCMedium:28];
    titleLabel.textColor = [KTools tools_colorRandom];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


@end
