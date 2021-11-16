//
//  TabAnimatedCell.m
//  KZOC
//
//  Created by KZ on 2021/11/15.
//

#import "TabAnimatedCell.h"

@interface TabAnimatedCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *label;

@end

@implementation TabAnimatedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc]init];
        self.imageV.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.width.mas_equalTo(100);
        }];
        
        self.label = [[UILabel alloc]init];
        self.label.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageV.mas_right).offset(10);
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(-20);
        }];
    }
    return self;
}
@end
