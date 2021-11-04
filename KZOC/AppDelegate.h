//
//  AppDelegate.h
//  KZOC
//
//  Created by KZ on 2021/10/26.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

/**用于分类(AppDelegate+KTextField)中使用*/
@property (nonatomic, copy) NSString *tempTextFieldString;

@end

/**
 - AppIcon RGB：rgb(63,113,154)
           HEX：#3f719a
 */
