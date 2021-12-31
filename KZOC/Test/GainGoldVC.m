//
//  GainGoldVC.m
//  KZOC
//
//  Created by Zzz... on 2021/12/27.
//

#import "GainGoldVC.h"
#import "UIViewController+KNavigation.h"
#import "GainGoldView.h"

@interface GainGoldVC ()

@property (nonatomic, strong) GainGoldView *homeView;

@end

@implementation GainGoldVC

#pragma mark - override method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self doNavUI];
    [self doViewUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self cg_navShowWithTranslucent:false showLine:false bgColor:Color_Hex(@"#F5F5F5")];
}

#pragma mark - custom method
- (void)doNavUI {
    [self cg_navBackItemWithTintColor:nil selector:nil];
    self.title = @"赚金币";
}
- (void)doViewUI {
    self.view.backgroundColor = Color_Hex(@"#F5F5F5");
    self.homeView = [[GainGoldView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.homeView];
}

@end
