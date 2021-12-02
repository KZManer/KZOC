//
//  AddressCell.m
//  KZOC
//
//  Created by Zzz... on 2021/11/23.
//

#import "AddressCell.h"
#import "UIButton+KImageText.h"

NSString * const CellIdAddress = @"CellIdAddress";

@interface AddressCell ()

/**姓名*/
@property (nonatomic, strong) UILabel *nameLabel;
/**手机号*/
@property (nonatomic, strong) UILabel *phoneLabel;
/**地址*/
@property (nonatomic, strong) UILabel *addressLabel;
/**默认地址icon按钮*/
@property (nonatomic, strong) UIButton *defaultAddrIconBtn;
/**默认地址*/
@property (nonatomic, strong) UIButton *defaultAddrBtn;
/**编辑*/
@property (nonatomic, strong) UIButton *editBtn;
/**删除*/
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation AddressCell

#pragma mark - override method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self doViewUI];
        self.nameLabel.text = @"小小";
        self.phoneLabel.text = @"1234343223";
        self.addressLabel.text = @"山东省济南市崂山区东明县东明集镇东明集村001号";
    }
    return self;
}

#pragma mark - private method

- (void)doViewUI {
    /**姓名*/
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    //手机号
    [self.contentView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.height.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right);
    }];
    
    //底部留白
    UIView *bottomSpaceLine = [[UIView alloc]init];
    bottomSpaceLine.backgroundColor = Color_Hex(@"#F5F5F5");
    [self.contentView addSubview:bottomSpaceLine];
    [bottomSpaceLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(10);
    }];
    
    //底部按钮view
    UIView *bottomView = [[UIView alloc]init];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(bottomSpaceLine.mas_top);
        make.height.mas_equalTo(40);
    }];
    //分割线（地址下面的一条线）
    UIView *line = [[UIView alloc]init];
    [bottomView addSubview:line];
    line.backgroundColor = Color_Hex(@"#F5F5F5");
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bottomView);
        make.height.mas_equalTo(0.8f);
    }];
    
    //默认地址icon
    [bottomView addSubview:self.defaultAddrIconBtn];
    [self.defaultAddrIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.centerY.equalTo(bottomView);
        make.height.width.mas_equalTo(25);
    }];
    //默认地址文字按钮
    [bottomView addSubview:self.defaultAddrBtn];
    [self.defaultAddrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.defaultAddrIconBtn.mas_right).offset(3);
        make.height.centerY.equalTo(self.defaultAddrIconBtn);
    }];
    
    //删除按钮
    [bottomView addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.phoneLabel);
        make.centerY.equalTo(bottomView);
        make.height.equalTo(self.defaultAddrIconBtn);
    }];
    
    //编辑按钮
    [bottomView addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.deleteBtn.mas_left).offset(-15);
        make.height.centerY.equalTo(self.deleteBtn);
    }];
    [self.deleteBtn button_leftImageRightText:3];
    [self.editBtn button_leftImageRightText:3];
    
    /**地址*/
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.phoneLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.bottom.equalTo(bottomView.mas_top).offset(-5);
    }];
}

#pragma mark - gesture event
//默认地址按钮被点击
- (void)pressedDefaultAddressButton {
    if (self.defaultAddrIconBtn.isSelected) return;
}
//编辑按钮被点击
- (void)pressedEditButton {
    
}
//删除按钮被点击
- (void)pressedDeleteButton {
    
}

#pragma mark - lazy loading
/**姓名*/
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = Color_Hex(@"#333333");
        _nameLabel.font = [UIFont font_fontPingFangSCMedium:14];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

/**手机号*/
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = Color_Hex(@"#333333");
        _phoneLabel.font = [UIFont font_fontPingFangSCMedium:14];
        _phoneLabel.textAlignment = NSTextAlignmentRight;
    }
    return _phoneLabel;
}

/**地址*/
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = Color_Hex(@"#333333");
        _addressLabel.font = [UIFont font_fontPingFangSCMedium:14];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.numberOfLines = 2;
    }
    return _addressLabel;
}
/**默认地址logo按钮*/
- (UIButton *)defaultAddrIconBtn {
    if (!_defaultAddrIconBtn) {
        _defaultAddrIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_defaultAddrIconBtn setImage:[UIImage imageNamed:@"c_rect_nor"] forState:UIControlStateNormal];
        [_defaultAddrIconBtn setImage:[UIImage imageNamed:@"c_rect_sel"] forState:UIControlStateSelected];
        [_defaultAddrIconBtn addTarget:self action:@selector(pressedDefaultAddressButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultAddrIconBtn;
}
/**默认地址*/
- (UIButton *)defaultAddrBtn {
    if (!_defaultAddrBtn) {
        _defaultAddrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_defaultAddrBtn setTitle:@"默认地址" forState:UIControlStateNormal];
        [_defaultAddrBtn setTitleColor:Color_Hex(@"#333333") forState:UIControlStateNormal];
        _defaultAddrBtn.titleLabel.font = [UIFont font_fontPingFangSCMedium:14];
        [_defaultAddrBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_defaultAddrBtn addTarget:self action:@selector(pressedDefaultAddressButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultAddrBtn;;
}
/**编辑按钮*/
- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setImage:[UIImage imageNamed:@"c_edit"] forState:UIControlStateNormal];
        [_editBtn setTitleColor:Color_Hex(@"#666666") forState:UIControlStateNormal];
        _editBtn.titleLabel.font = [UIFont font_fontPingFangSCMedium:14];
        [_editBtn addTarget:self action:@selector(pressedEditButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}
/**删除按钮*/
- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setImage:[UIImage imageNamed:@"c_delete"] forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:Color_Hex(@"#666666") forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont font_fontPingFangSCMedium:14];
        [_deleteBtn addTarget:self action:@selector(pressedDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
@end
