//
//  AppDelegate.m
//  KZOC
//
//  Created by KZ on 2021/10/26.
//

#import "AppDelegate.h"
#import "TabBarRootVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    Class cl = NSClassFromString(@"ViewController");
    UIViewController *rootVC = [[cl alloc]init];
    TabBarRootVC *tabbarVC = [[TabBarRootVC alloc]init];
    self.window.rootViewController = tabbarVC;
//    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:rootVC];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
