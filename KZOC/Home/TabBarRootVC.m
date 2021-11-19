//
//  TabBarRootVC.m
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import "TabBarRootVC.h"

@interface TabBarRootVC ()

@end

@implementation TabBarRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *titles = @[@"日常记录",@"实验"];
    NSArray *vcNames = @[@"HomeeVC",@"TestVC"];
    NSArray *images = @[@"home",@"test"];
    for (int i = 0; i < titles.count; i++) {
        Class cls = NSClassFromString(vcNames[i]);
        UIViewController *vc = [cls new];
        vc.title = titles[i];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        
        nav.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_nor_%@",images[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_sel_%@",images[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_RGB_Same(51)} forState:UIControlStateNormal];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:COLOR_THEME} forState:UIControlStateSelected];
        
        [self addChildViewController:nav];
    }
    self.selectedIndex = 0;
}

@end
