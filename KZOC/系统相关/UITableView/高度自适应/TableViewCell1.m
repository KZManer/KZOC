//
//  TableViewCell1.m
//  KZOC
//
//  Created by KZ on 2021/11/10.
//

#import "TableViewCell1.h"

NSString * const cellIdentiferTableViewCell1 = @"cellIdentiferTableViewCell1";

@interface TableViewCell1 ()

@property (nonatomic, strong) UILabel *showLabel;

@end

@implementation TableViewCell1

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
    
        self.showLabel = [[UILabel alloc]init];
        self.showLabel.backgroundColor = [[UIColor orangeColor]colorWithAlphaComponent:.4];
        self.showLabel.numberOfLines = 2;
        self.showLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.showLabel];
        [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.bottom.right.mas_equalTo(-10);
        }];
    }
    return self;
}

- (void)echoContent:(NSString *)string {
    self.showLabel.text = string;
}

@end
