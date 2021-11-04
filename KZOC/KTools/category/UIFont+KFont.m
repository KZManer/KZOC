//
//  UIFont+KFont.m
//  KZOC
//
//  Created by KZ on 2021/10/29.
//

#import "UIFont+KFont.h"

@implementation UIFont (KFont)

+ (UIFont *)font_fontName:(NSString *)fontName fontSize:(CGFloat)fontSize {
    return [UIFont fontWithName:fontName size:fontSize];
}

+ (UIFont *)font_fontPingFangSC:(CGFloat)fontSize {
    return [self font_fontName:@"PingFangSC-Regular" fontSize:fontSize];
}

+ (UIFont *)font_fontPingFangSCMedium:(CGFloat)fontSize {
    return [self font_fontName:@"PingFangSC-Medium" fontSize:fontSize];
}

+ (UIFont *)font_fontPingFangSCBold:(CGFloat)fontSize {
    return [self font_fontName:@"PingFangSC-Semibold" fontSize:fontSize];
}

@end
