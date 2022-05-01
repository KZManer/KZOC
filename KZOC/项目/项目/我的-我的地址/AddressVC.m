//
//  AddressVC.m
//  KZOC
//
//  Created by Zzz... on 2021/11/23.
//

#import "AddressVC.h"
#import "AddressView.h"

@interface AddressVC ()

@property (nonatomic, strong) AddressView *homeView;

@end

@implementation AddressVC

#pragma mark - override method

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doNavUI];
    [self doViewUI];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDarkContent;
}
#pragma mark - custom method

- (void)doNavUI {
    self.title = @"收货地址";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"c_arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(pressedBackItem)];
    backItem.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)doViewUI {
    
    self.homeView = [[AddressView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.homeView];
}

#pragma mark - gesture event
//点击返回按钮
- (void)pressedBackItem {
    [self.navigationController popViewControllerAnimated:true];
}

@end
