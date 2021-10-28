//
//  NavCustomViewCell.m
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import "NavCustomViewCell.h"

NSString * const CellIdentifierNavCustomeView = @"CellIdentifierNavCustomeView";

@interface NavCustomViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation NavCustomViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    /**下划线*/
    self.bottomLine = [[UIView alloc]init];
    self.bottomLine.backgroundColor = COLOR_THEME;
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(3);
        make.centerX.equalTo(self);
    }];
    [self.bottomLine view_setCornerRadius:1 borderColor:nil borderWidth:0];
    
    /**标题*/
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomLine.mas_top);
        make.top.left.right.mas_equalTo(0);
    }];
    
    self.bottomLine.hidden = true;
    
    return self;
}

- (void)echoContent:(NavMenuModel *)model {
    self.titleLabel.text = model.name;
    if (model.active) {
        self.titleLabel.textColor = COLOR_THEME;
        self.bottomLine.hidden = false;
    } else {
        self.titleLabel.textColor = [UIColor blackColor];
        self.bottomLine.hidden = true;
    }
}

@end
