//
//  ScrollVC.m
//  KZOC
//
//  Created by KZ on 2021/11/15.
//

#import "ScrollVC.h"
#import "ScrollView.h"
#import "UIViewController+KNavigation.h"

@interface ScrollVC ()

@property (nonatomic, strong) ScrollView *homeView;

@end

@implementation ScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.homeView = [[ScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.homeView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = true;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = false;
}

@end
