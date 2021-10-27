//
//  UIColor+KCustomColor.h
//  Runner
//
//  Created by KZ on 2021/6/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (KCustomColor)

#pragma mark - define

#define Color_RGB_Same(RGB) [UIColor color_rgbSame:RGB alpha:1.0]
#define Color_RGB_Same_Alpha(RGB,A) [UIColor color_rgbSame:RGB alpha:A]

#define Color_RGB(R, G, B) [UIColor color_rgbWithRed:R green:G blue:B alpha:1.0f]
#define Color_RGB_Alpha(R, G, B, A) [UIColor color_rgbWithRed:R green:G blue:B alpha:A]

#define Color_Hex(H) [UIColor color_hexColor:H alpha:1.0f]
#define Color_Hex_Alpha(H,A) [UIColor color_hexColor:H alpha:A]


#pragma mark - RGB颜色
/**
 @brief 设置rgb相同的颜色+透明度
 */
+ (UIColor *)color_rgbSame:(CGFloat)rgb alpha:(CGFloat)alpha;

/**
 @brief 设置rgb不同的颜色+透明度
 */
+ (UIColor *)color_rgbWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

#pragma mark - 16进制颜色

/**
 @brief 设置16进制颜色+透明度
 */
+ (UIColor *)color_hexColor:(NSString *)hex alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
