//
//  FoldHeaderView.m
//  KZOC
//
//  Created by Zzz... on 2021/11/26.
//

#import "FoldHeaderView.h"

@interface FoldHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *verLine;

@end

@implementation FoldHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}

- (void)doViewUI {
    self.backgroundColor = [UIColor whiteColor];
    
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressedSelfView)]];
    
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.width.height.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont font_fontPingFangSCBold:14];
    self.titleLabel.textColor = Color_Hex(@"#333333");
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(10);
        make.centerY.equalTo(self);
    }];
    
    UIView *verLine = [[UIView alloc]init];
    verLine.backgroundColor = Color_Hex(@"#3376FF");
    self.verLine = verLine;
    [self addSubview:verLine];
    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(3);
        make.bottom.equalTo(self);
        make.centerX.equalTo(self.imageView);
        make.width.mas_equalTo(2);
    }];
}

- (void)echoContent:(NSString *)imageName title:(NSString *)title unfold:(BOOL)unfold {
    self.verLine.hidden = !unfold;
    self.imageView.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = title;
}

- (void)pressedSelfView {
    if (self.pressedAction) {
        self.pressedAction(self);
    }
}

@end
