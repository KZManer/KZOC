//
//  AddressOperateVC.m
//  KZOC
//
//  Created by Zzz... on 2021/11/24.
//

#import "AddressOperateVC.h"
#import "AddressOperateView.h"

@interface AddressOperateVC ()

@property (nonatomic, strong) AddressOperateView *homeView;

@end

@implementation AddressOperateVC

#pragma mark - override method

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doNavUI];
    [self doViewUI];
}

#pragma mark - custom method
- (void)doNavUI {
    
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    self.title = @"新建收货地址";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"c_arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(pressedBackItem)];
    backItem.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)doViewUI {
    self.view.backgroundColor = Color_Hex(@"#F5F5F5");
    self.homeView = [[AddressOperateView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.homeView];
}

#pragma mark - gesture event
//点击返回按钮
- (void)pressedBackItem {
    [self.navigationController popViewControllerAnimated:true];
}

@end
