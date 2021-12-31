//
//  TLSectionHeader.m
//  KZOC
//
//  Created by Zzz... on 2021/12/31.
//

#import "TLSectionHeader.h"

@interface TLSectionHeader ()
/**icon 用button的好处：当展开与收起的时候button可以设置展示对应的图标*/
@property (nonatomic, strong) UIButton *headBtn;
/**主标题*/
@property (nonatomic, strong) UILabel *titleLabel;
/**副标题*/
@property (nonatomic, strong) UILabel *subheadLabel;

@end

@implementation TLSectionHeader

#pragma mark - override method
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}

#pragma mark private method
- (void)doViewUI {
    //图标
    [self addSubview:self.headBtn];
    [self.headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(@0);
    }];
    //标题
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headBtn.mas_right).offset(10);
        make.centerY.equalTo(@0);
    }];
    //副标题
    [self addSubview:self.subheadLabel];
    [self.subheadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(@0);
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
    }];
}

#pragma mark public method
- (void)echoContent:(NSString *)title subhead:(NSString *)subhead fold:(BOOL)fold {
    self.titleLabel.text = title;
    self.subheadLabel.text = subhead;
    self.headBtn.selected = fold;
}

#pragma mark lazy loading
- (UIButton *)headBtn {
    if (!_headBtn) {
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.userInteractionEnabled = false;
        [_headBtn setImage:[UIImage imageNamed:@"tl_first_fold"] forState:UIControlStateNormal];
        [_headBtn setImage:[UIImage imageNamed:@"tl_first_unfold"] forState:UIControlStateSelected];
        _headBtn.selected = false;
    }
    return _headBtn;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
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
