//
//  UIViewController+KNavigation.m
//  TimeInternational
//
//  Created by KZ on 2021/8/13.
//

#import "UIViewController+KNavigation.h"

@implementation UIViewController (KNavigation)

- (void)vc_navBackImageBlackWithAction:(nullable SEL)action {
    [self vc_navBackImageTintColor:[UIColor blackColor] action:action];
}

- (void)vc_navBackImageTintColor:(UIColor *)tintColor action:(nullable SEL)action {
    if (action == nil) {
        action = @selector(vc_navClickBackItem);
    }
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"c_arrow_l_black"] style:UIBarButtonItemStylePlain target:self action:action];
    [backItem setTintColor:tintColor];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)vc_navClickBackItem {
    [self.navigationController popViewControllerAnimated:YES];
}
//去掉导航栏下边的黑边
- (void)vc_navRemoveBottomBlackSide {
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}
//展示导航栏下边的黑边
- (void)vc_navShowBottomBlackSide {
    [self.navigationController.navigationBar setShadowImage:nil];
}
//导航栏透明
- (void)vc_navLucency {
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self vc_navRemoveBottomBlackSide];
    [self.navigationController.navigationBar setTranslucent:YES];
}
//导航栏不透明
- (void)vc_navNoLucency {
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController.navigationBar setTranslucent:NO];
}

//设置标题和标题颜色
- (void)vc_navTitle:(NSString *)title tintColor:(UIColor *)tintColor {
    self.navigationItem.title = title;
    [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:tintColor}];
}
@end
