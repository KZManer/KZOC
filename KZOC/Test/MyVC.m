//
//  MyVC.m
//  KingTalent
//
//  Created by KZ on 2021/11/17.
//

#import "MyVC.h"
#import "MyView.h"
#import "UIViewController+KNavigation.h"

@interface MyVC ()

@property (nonatomic, strong) MyView *homeView;

@end

@implementation MyVC

#pragma mark - override method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self doNavUI];
    [self doViewUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = false;
    [self vc_navLucency];
    
}
#pragma mark - custom method
- (void)doNavUI {
    //标题
    self.title = @"我的";
    //返回item
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"c_arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(pressedBackItem)];
    self.navigationItem.leftBarButtonItem = backItem;
    backItem.tintColor = Color_Hex(@"#333333");
    //名片item
    UIBarButtonItem *cardItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"my_card"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressedCardItem)];
    //设置item
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"my_setting"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressedSettingItem)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,cardItem];
    
}
- (void)doViewUI {
    
    [self.view addSubview:self.homeView];
}

#pragma mark - gesture event

//点击了返回按钮
- (void)pressedBackItem {
    [self.navigationController popViewControllerAnimated:true];
}
//点击了个人名片按钮
- (void)pressedCardItem {
    
}
//点击了设置按钮
- (void)pressedSettingItem {
    
}

#pragma mark - lazy loading
- (MyView *)homeView {
    if (!_homeView) {
        _homeView = [[MyView alloc]initWithFrame:self.view                             .frame];
    }
    return _homeView;
}

@end
