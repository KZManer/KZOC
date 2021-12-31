//
//  UIView+kView.h
//  Runner
//
//  Created by KZ on 2021/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KView)

/**
 * @brief category   给view设置圆角
 * @param value      圆角大小
 * @param rectCorner 圆角位置
 **/
- (void)view_setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner;

/**
 * @brief category    给view设置圆角+边框
 * @param value       圆角大小
 * @param borderColor 边框颜色
 * @param borderWidth 边框宽度
 **/
- (void)view_setCornerRadius:(CGFloat)value borderColor:(UIColor *_Nullable)borderColor borderWidth:(CGFloat)borderWidth;
/**设置渐变颜色*/
- (void)view_setColorGradual:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations horizontalLayout:(BOOL)horizontal;
@end

NS_ASSUME_NONNULL_END
