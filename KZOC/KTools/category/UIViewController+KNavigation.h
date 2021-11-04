//
//  UIViewController+KNavigation.h
//  TimeInternational
//
//  Created by KZ on 2021/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (KNavigation)

/**
 @brief 自定义返回导航栏返回按钮的图片，主题色为黑色
 @param action 点击事件
 */
- (void)vc_navBackImageBlackWithAction:(nullable SEL)action;

/**
 @brief 自定义返回导航栏返回按钮的图片
 @param tintColor 返回图片的颜色（图片要用png）
 @param action    点击事件
 */
- (void)vc_navBackImageTintColor:(UIColor *)tintColor action:(nullable SEL)action;

/**去掉导航栏下边的黑边*/
- (void)vc_navRemoveBottomBlackSide;
/**展示导航栏下边的黑边*/
- (void)vc_navShowBottomBlackSide;
/**导航栏透明*/
- (void)vc_navLucency;
//导航栏不透明
- (void)vc_navNoLucency;

//设置标题和标题颜色
- (void)vc_navTitle:(NSString *)title tintColor:(UIColor *)tintColor;

@end

NS_ASSUME_NONNULL_END
