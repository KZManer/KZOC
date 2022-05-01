//
//  UIFont+KFont.h
//  KZOC
//
//  Created by KZ on 2021/10/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (KFont)

/**
 @brief 返回fontName字体
 @param fontName 字体名称
 @param fontSize 字体大小
 */
+ (UIFont *)font_fontName:(NSString *)fontName fontSize:(CGFloat)fontSize;

/**
 @brief 返回PingFangSC-Regular字体
 @param fontSize 字体大小
 */
+ (UIFont *)font_fontPingFangSC:(CGFloat)fontSize;

/**
 @brief 返回PingFangSC-Medium字体
 @param fontSize 字体大小
 */
+ (UIFont *)font_fontPingFangSCMedium:(CGFloat)fontSize;

/**
 @brief 返回PingFangSC-Semibold字体
 @param fontSize 字体大小
 */
+ (UIFont *)font_fontPingFangSCBold:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
