//
//  KTextView.h
//  Runner
//
//  Created by KZ on 2021/4/16.
//

/**阅读协议之类的富文本，点击可跳转(此功能需在block回调中自己写)*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^KLinkHandler)(int linkIndex);

@interface KTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 @brief 阅读协议之类的富文本，点击可跳转(此功能需在block回调中自己写)
 @param text 文本内容
 @param linkColor 要点击的链接的颜色
 @param linkTexts 要点击的链接文本数组(clickTexts元素要是text的子字符串)
 */
- (void)kTextViewProtocolWithText:(NSString *)text linkColor:(UIColor *)linkColor linkTexts:(NSArray<NSString *> *)linkTexts linkHandler:(nonnull KLinkHandler)linkHandler;

@end

NS_ASSUME_NONNULL_END

