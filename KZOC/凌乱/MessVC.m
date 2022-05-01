//
//  MessVC.m
//  KZOC
//
//  Created by KZ on 2022/5/1.
//

#import "MessVC.h"
#import "KZHomeBaseView.h"
#import "SectionModel.h"

@interface MessVC ()<KZHomeBaseViewDelegate>

@property (nonatomic, strong) KZHomeBaseView *homeView;

@end

@implementation MessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.homeView = [[KZHomeBaseView alloc]initWithFrame:self.view.frame projectTitles:[SectionModel sectionMessTitles] sectionInfos:[SectionModel sectionMessModels]];
    self.homeView.delegate = self;
    [self.view addSubview:self.homeView];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.homeView.frame = self.view.frame;
}

#pragma mark - KZHomeBaseViewDelegate
- (void)dg_homeDidSelectRowWithTitle:(NSString *)title className:(NSString *)className {
    Class cls = NSClassFromString(className);
    UIViewController *vc = [cls new];
    vc.title = title;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
