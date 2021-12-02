//
//  FoldCell.m
//  KZOC
//
//  Created by Zzz... on 2021/11/26.
//

#import "FoldCell.h"

NSString * const CellIdFold = @"CellIdFold";

@interface FoldCell ()

@property (nonatomic, strong) UIImageView *kImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *verLine2;

@end

@implementation FoldCell

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
        [self doViewUI];
    }
    return self;
}

- (void)doViewUI {
    self.kImageView = [[UIImageView alloc]init];
    self.kImageView.image = [UIImage imageNamed:@"symbol_circle"];
    [self.contentView addSubview:self.kImageView];
    [self.kImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.width.height.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont font_fontPingFangSC:14];
    self.titleLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kImageView.mas_right).offset(10);
        make.centerY.equalTo(self);
    }];
    
    UIView *verLine1 = [[UIView alloc]init];
    verLine1.backgroundColor = Color_Hex(@"#3376FF");
    [self.contentView addSubview:verLine1];
    [verLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.kImageView.mas_top).offset(-3);
        make.centerX.equalTo(self.kImageView);
        make.width.mas_equalTo(2);
    }];
    
    UIView *verLine2 = [[UIView alloc]init];
    verLine2.backgroundColor = Color_Hex(@"#3376FF");
    self.verLine2 = verLine2;
    [self.contentView addSubview:verLine2];
    [verLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.kImageView.mas_bottom).offset(3);
        make.bottom.equalTo(self.contentView);
        make.centerX.equalTo(self.kImageView);
        make.width.mas_equalTo(2);
    }];
}

- (void)echoContent:(NSString *)content lastRow:(BOOL)lastRow {
    self.titleLabel.text = content;
    self.verLine2.hidden = lastRow;
}

@end
