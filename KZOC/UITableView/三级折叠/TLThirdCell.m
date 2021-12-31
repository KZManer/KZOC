//
//  TLThirdCell.m
//  KZOC
//
//  Created by Zzz... on 2021/12/31.
//

#import "TLThirdCell.h"

NSString * const CellIdTLThirdCell = @"CellIdTLThirdCell";

@interface TLThirdCell ()
/**icon 用button的好处：当展开与收起的时候button可以设置展示对应的图标*/
@property (nonatomic, strong) UIButton *headBtn;
/**主标题*/
@property (nonatomic, strong) UILabel *titleLabel;
/**副标题*/
@property (nonatomic, strong) UILabel *subheadLabel;

@end

@implementation TLThirdCell

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
    //分割线
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = UIColor.lightGrayColor;
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@10);
        make.right.equalTo(@0);
        make.height.equalTo(@.5f);
    }];
    //图标
    [self.contentView addSubview:self.headBtn];
    [self.headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.centerY.equalTo(@0);
        make.height.width.equalTo(@30);
    }];
    //标题
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headBtn.mas_right).offset(10);
        make.centerY.equalTo(@0);
    }];
    //副标题
    [self.contentView addSubview:self.subheadLabel];
    [self.subheadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(@0);
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
    }];
//    self.headBtn.backgroundColor = UIColor.orangeColor;
//    self.titleLabel.backgroundColor = [UIColor.blueColor colorWithAlphaComponent:.4];
//    self.subheadLabel.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:.6];
}

#pragma mark public method
- (void)echoContent:(TLModel *)tlInfo {
    self.titleLabel.text = tlInfo.title;
    self.subheadLabel.text = tlInfo.subhead;
    self.headBtn.selected = !tlInfo.fold;
}

#pragma mark lazy loading
- (UIButton *)headBtn {
    if (!_headBtn) {
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.userInteractionEnabled = false;
        [_headBtn setImage:[UIImage imageNamed:@"tl_third_normal"] forState:UIControlStateNormal];
        [_headBtn setImage:[UIImage imageNamed:@"tl_third_normal"] forState:UIControlStateSelected];
        _headBtn.selected = false;
    }
    return _headBtn;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (UILabel *)subheadLabel {
    if (!_subheadLabel) {
        _subheadLabel = [[UILabel alloc]init];
        _subheadLabel.font = [UIFont systemFontOfSize:12];
        _subheadLabel.textColor = UIColor.grayColor;
        _subheadLabel.textAlignment = NSTextAlignmentRight;
    }
    return _subheadLabel;
}
@end

