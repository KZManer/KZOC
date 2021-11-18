//
//  MyView.m
//  KingTalent
//
//  Created by KZ on 2021/11/17.
//

#import "MyView.h"
#import "SDWebImage.h"

@interface MyView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/**头像*/
@property (nonatomic, strong) UIButton *headBtn;
/**昵称*/
@property (nonatomic, strong) UILabel *nickNameLabel;
/**累计学习*/
@property (nonatomic, strong) UILabel *studyLabel;
/**累计做题*/
@property (nonatomic, strong) UILabel *questionLabel;
/**累计看课时长*/
@property (nonatomic, strong) UILabel *classLabel;

/**我的账户collectionView*/
@property (nonatomic, strong) UICollectionView *myAccountCV;//CV => CollectionView
/**我的工具collectionView*/
@property (nonatomic, strong) UICollectionView *myToolsCV;

@end

@implementation MyView

#pragma mark - override method
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
        [self doInitConfig];
    }
    return self;
}

#pragma mark - private method

- (void)doViewUI {
    
    /**scrollView*/
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    /**contentView*/
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [[UIColor orangeColor]colorWithAlphaComponent:.4];
    [scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    /**背景图*/
    UIImageView *bgImageView = [[UIImageView alloc]init];
    bgImageView.backgroundColor = [UIColor lightGrayColor];
    bgImageView.image = [UIImage imageNamed:@"my_bg"];
    [contentView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).offset(-[KTools tools_heightOfStatusBarAndNavigationBar]);
        make.left.right.bottom.equalTo(contentView);
    }];
    
    /**顶部module*/
    //头像
    [contentView addSubview:self.headBtn];
    [self.headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.width.height.mas_equalTo(54);
    }];
    [self.headBtn view_setCornerRadius:27 borderColor:nil borderWidth:0];
    
    //昵称
    [contentView addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headBtn.mas_right).offset(6);
        make.centerY.equalTo(self.headBtn);
    }];
    //右箭头
    UIButton *rightArrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightArrowBtn setImage:[UIImage imageNamed:@"my_arrow_right"] forState:UIControlStateNormal];
    [rightArrowBtn addTarget:self action:@selector(pressedPersonalInfoButton) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:rightArrowBtn];
    [rightArrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView).offset(-15);
        make.centerY.equalTo(self.headBtn);
    }];
    //个人资料
    UIButton *personalInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [personalInfoBtn setImage:[UIImage imageNamed:@"my_info"] forState:UIControlStateNormal];
    [personalInfoBtn addTarget:self action:@selector(pressedPersonalInfoButton) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:personalInfoBtn];
    [personalInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightArrowBtn.mas_left).offset(-10);
        make.centerY.equalTo(self.headBtn);
    }];
    
    /**累计学习、累计做题...*/
    float recordHorSpace = 10;//累计学习、累计做题、累计看课时长之间的间隔
    UIView *recordView = [[UIView alloc]init];
    [contentView addSubview:recordView];
    [recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(self.headBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(60);
    }];
    //累计学习标题
    UILabel *studyTitle = [[UILabel alloc]init];
    studyTitle.text = @"累计学习";
    studyTitle.textColor = Color_Hex(@"999999");
    studyTitle.font = [UIFont font_fontPingFangSCMedium:13];
    studyTitle.textAlignment = NSTextAlignmentCenter;
    [recordView addSubview:studyTitle];
    [studyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(recordView);
        make.width.equalTo(recordView).dividedBy(3);
    }];
    //累计做题标题
    UILabel *questionTitle = [[UILabel alloc]init];
    questionTitle.text = @"累计学习";
    questionTitle.textColor = Color_Hex(@"999999");
    questionTitle.font = [UIFont font_fontPingFangSCMedium:13];
    questionTitle.textAlignment = NSTextAlignmentCenter;
    [recordView addSubview:questionTitle];
    [questionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(recordView);
        make.width.equalTo(recordView).dividedBy(3);
    }];
    //累计看课时长标题
    //累计学习内容
    [recordView addSubview:self.studyLabel];
    [self.studyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(recordView);
        make.left.equalTo(recordView).offset(10);
//        make.width.mas_equalTo((recordView - recordHorSpace * 4)/4);
    }];

    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
    }];
}

- (void)doInitConfig {
    self.headBtn.backgroundColor = [UIColor orangeColor];
    self.nickNameLabel.text = @"蜗牛";
}

#pragma mark - gesture event
//点击了头像
- (void)pressedHeadButton {
    
}
//点击了个人资料
- (void)pressedPersonalInfoButton {
    
}

#pragma mark - lazy loading
/**头像*/
- (UIButton *)headBtn {
    if (!_headBtn) {
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headBtn addTarget:self action:@selector(pressedHeadButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headBtn;
}
/**昵称*/
- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc]init];
        _nickNameLabel.textColor = Color_Hex(@"#333333");
        _nickNameLabel.font = [UIFont font_fontPingFangSCBold:18];
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nickNameLabel;
}
/**累计学习天数*/
- (UILabel *)studyLabel {
    if (!_studyLabel) {
        _studyLabel = [[UILabel alloc]init];
        _studyLabel.textColor = Color_Hex(@"4c4c4c");
        _studyLabel.font = [UIFont font_fontPingFangSCBold:19];
        _studyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _studyLabel;
}
/**累计做题*/
- (UILabel *)questionLabel {
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc]init];
        _questionLabel.textColor = Color_Hex(@"4c4c4c");
        _questionLabel.font = [UIFont font_fontPingFangSCBold:19];
        _questionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _questionLabel;
}
/**累计看课时长*/
- (UILabel *)classLabel {
    if (!_classLabel) {
        _classLabel = [[UILabel alloc]init];
        _classLabel.textColor = Color_Hex(@"4c4c4c");
        _classLabel.font = [UIFont font_fontPingFangSCBold:19];
        _classLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _classLabel;
}
@end
