//
//  NavigationBadgeVC.m
//  KZOC
//
//  Created by Zzz... on 2022/1/12.
//

#import "NavigationBadgeVC.h"
#import "UIBarButtonItem+WZLBadge.h"
#import "UIView+WZLBadge.h"//设置角标"
#import "UIButton+KImageText.h"

@interface NavigationBadgeVC ()

@property (nonatomic, strong) UIBarButtonItem *personalItem;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UIButton *centerBtn;
@property (nonatomic, assign) NSInteger badgeNum;
@property (nonatomic, strong) UIButton *titleBtn;

@end

@implementation NavigationBadgeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.badgeNum = 2;
    
    //导航栏左侧item
    UIBarButtonItem *personalItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_personal"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(pressedPersonalItem)];
    self.personalItem = personalItem;
    //导航栏右侧item
    UIImage *messageImg = [UIImage imageNamed:@"nav_message"];
    self.messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.messageBtn.frame = CGRectMake(0, 0, messageImg.size.width, messageImg.size.height);
    [self.messageBtn setBadgeCenterOffset:CGPointMake(2, -2)];
    [self.messageBtn setImage:messageImg forState:UIControlStateNormal];
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc]initWithCustomView:self.messageBtn];
    
    self.navigationController.navigationBar.tintColor = Color_Hex(@"#333333");
    
    self.navigationItem.leftBarButtonItem = personalItem;
    self.navigationItem.rightBarButtonItem = messageItem;
    
    //导航栏titleView
    self.navigationItem.titleView = self.titleBtn;
    self.navigationItem.titleView.backgroundColor = UIColor.whiteColor;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self cg_navShowWithTranslucent:false showLine:false bgColor:nil];
    [self updateBadgeNum];
    NSLog(@"%s",__func__);
    
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self pressedButtonAction];
    [self updateBadgeNum];
    NSLog(@"%s",__func__);
}

- (void)pressedPersonalItem {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)pressedButtonAction {
    
    NSArray *titleArr = @[
        @"临床执业医师",
        @"这是一段非常长的专业用来测试一下可以放置的最长字符串",
        @"这是一段不是很长的专业测试一下",
        @"乡村全科助理医师",
    ];
    int random = arc4random_uniform(4);
    NSString *title = titleArr[random];
    
    [self.titleBtn setTitle:title forState:UIControlStateNormal];
    [self.titleBtn button_leftTextRightImage:5];
    
}

- (void)updateBadgeNum {
    [self.personalItem showBadgeWithStyle:WBadgeStyleNumber value:self.badgeNum animationType:WBadgeAnimTypeNone];
    [self.personalItem setBadgeCenterOffset:CGPointMake(-10, 10)];
    [self.messageBtn showBadgeWithStyle:WBadgeStyleNumber value:self.badgeNum animationType:WBadgeAnimTypeNone];
    [self.centerBtn showBadgeWithStyle:WBadgeStyleNumber value:self.badgeNum animationType:WBadgeAnimTypeNone];
}
- (UIButton *)titleBtn {
    if (!_titleBtn) {
        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_titleBtn setTitleColor:Color_Hex(@"#333333") forState:UIControlStateNormal];
        _titleBtn.titleLabel.font = [UIFont font_fontPingFangSCMedium:18.f];
        [_titleBtn setImage:[[UIImage imageNamed:@"nav_change"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        _titleBtn.titleLabel.numberOfLines = 1;
        _titleBtn.titleLabel.adjustsFontSizeToFitWidth = true;
        _titleBtn.titleLabel.minimumScaleFactor = 0.4;
        [_titleBtn addTarget:self action:@selector(pressedButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtn;
}
@end
