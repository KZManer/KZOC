//
//  HomeHeaderViewCell.m
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import "HomeHeaderViewCell.h"

@interface HomeHeaderViewCell ()

@property (nonatomic, strong) UILabel *showLabel;

@end

@implementation HomeHeaderViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}
- (void)doViewUI {
    self.showLabel = [[UILabel alloc]init];
    self.showLabel.textColor = [UIColor blackColor];
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    self.showLabel.backgroundColor = Color_RGB_Same(240);
    self.showLabel.adjustsFontSizeToFitWidth = true;
    self.showLabel.minimumScaleFactor = 0.5;
    [self.contentView addSubview:self.showLabel];
    [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(5);
        make.bottom.right.mas_equalTo(-5);
    }];
    [self.showLabel view_setCornerRadius:4 borderColor:nil borderWidth:0];
}

- (void)echoContent:(NSString *)text {
    self.showLabel.text = text;
}

@end
