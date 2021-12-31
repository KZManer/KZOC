//
//  UIViewController+KCustom.h
//  KZOC
//
//  Created by Zzz... on 2021/12/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (KCustom)

- (void)cg_navBackItemWithTintColor:(UIColor *_Nullable)tintColor selector:(SEL _Nullable)selector;

- (void)cg_navShowWithTranslucent:(BOOL)translucent line:(BOOL)line bgColor:(UIColor *_Nullable)bgColor;

- (void)cg_navHide;

@end

NS_ASSUME_NONNULL_END
