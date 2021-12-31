//
//  UIViewController+KCustom.m
//  KZOC
//
//  Created by Zzz... on 2021/12/16.
//

#import "UIViewController+KCustom.h"

@implementation UIViewController (KCustom)

- (void)cg_navBackItemWithTintColor:(UIColor *)tintColor selector:(SEL)selector {
    
    //侧滑返回手势（自定义返回item的时候侧滑手势会失效，加上下面这句代码即可）
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    tintColor = tintColor ? tintColor : Color_Hex(@"#333333");
    selector = selector ? selector : @selector(private_pressedBackItem);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_show"]imageWithRenderingMode:UIImageRenderingModeAutomatic] style:UIBarButtonItemStylePlain target:self action:selector];
    backItem.tintColor = tintColor;
    self.navigationItem.leftBarButtonItem = backItem;
}
//返回上一页
- (void)private_pressedBackItem {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)cg_navShowWithTranslucent:(BOOL)translucent line:(BOOL)line bgColor:(UIColor *)bgColor {
    if (@available(iOS 13.0, *)) {
        
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc]init];
        if (translucent) {
            [appearance configureWithTransparentBackground];
        } else {
            [appearance configureWithDefaultBackground];
        }
        //是否半透明
        self.navigationController.navigationBar.translucent = translucent;
        //导航栏背景色
        appearance.backgroundColor = bgColor;
        //是否有底部线
        if (line) {
            //有线
            appearance.shadowColor = UIColor.lightGrayColor;
        } else {
            //没有线
            appearance.shadowColor = UIColor.clearColor;
        }
        self.navigationController.navigationBar.standardAppearance = appearance;
        if (@available(iOS 15.0, *)) {
            self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        }
    } else {
        self.navigationController.navigationBar.translucent = translucent;
        //是否有底部线
        if (line) {
            //有线
            self.navigationController.navigationBar.shadowImage = nil;
        } else {
            //没有线
            self.navigationController.navigationBar.shadowImage = [UIImage new];
        }
        //设置导航栏背景色
        self.navigationController.navigationBar.barTintColor = bgColor;
    }
}


- (void)cg_navHide {
    self.navigationController.navigationBar.hidden = true;
}

@end
