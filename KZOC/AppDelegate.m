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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    TabBarRootVC *tabbarVC = [[TabBarRootVC alloc]init];
    self.window.rootViewController = tabbarVC;

    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = true;
    
    [self monitorTextFieldInputAction];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
