//
//  AppDelegate.m
//  KZOC
//
//  Created by KZ on 2021/10/26.
//

#import "AppDelegate.h"
#import "TabBarRootVC.h"
#import "AppDelegate+KTextField.h"
#import "IQKeyboardManager.h"
#import "TABAnimated.h"

#import "PrivacyProtocolVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"%f",Height_Bottom_Space);
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    TabBarRootVC *tabbarVC = [[TabBarRootVC alloc]init];
    
    Class cls = NSClassFromString(@"MyVC");
    UIViewController *vc = [cls new];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    self.window.rootViewController = tabbarVC;
//    self.window.rootViewController = nav;

    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = true;
    
    /**骨架*/
    [[TABAnimated sharedAnimated] initWithBinAnimation];
    [[TABAnimated sharedAnimated] openLog];
    [TABAnimated sharedAnimated].openAnimationTag = true;
    
    [self monitorTextFieldInputAction];
    [self.window makeKeyAndVisible];
    
    NSLog(@"%f",[UIScreen mainScreen].scale);
    
    return YES;
}

@end
