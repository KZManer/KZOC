//
//  UIButton+KImageText.h
//  test
//
//  Created by KZ on 2021/8/7.
//  按钮上的文字和图片位置，使用Masonry会出现错位，用frame没发现问题
 
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KImageText)

/**
 @brief 上图片 下文字
 @param space 水平间隔
 */
- (void)button_topImageBottomText:(CGFloat)space;

/**
 @brief 上文字 下图片
 @param space 水平间隔
 */
- (void)button_topTextBottomImage:(CGFloat)space;

/**
 @brief 左图片 右文字
 @param space 水平间隔
 */
- (void)button_leftImageRightText:(CGFloat)space;

/**
 @brief 左文字 右图片
 @param space 水平间隔
 */
- (void)button_leftTextRightImage:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
