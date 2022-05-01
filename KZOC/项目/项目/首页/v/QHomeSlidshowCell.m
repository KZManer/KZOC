//
//  QHomeSlidshowCell.m
//  KingTalent
//
//  Created by Zzz... on 2022/1/12.
//

#import "QHomeSlidshowCell.h"

NSString * const CellIdQHomeSlideshow = @"CellIdQHomeSlideshow";

@interface QHomeSlidshowCell ()

@end

@implementation QHomeSlidshowCell

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
    titleLabel.text = @"顶部轮播图";
    titleLabel.font = [UIFont font_fontPingFangSCMedium:28];
    titleLabel.textColor = [KTools tools_colorRandom];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


@end
