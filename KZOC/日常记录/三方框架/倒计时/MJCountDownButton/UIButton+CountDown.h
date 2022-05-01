//
//  UIButton+CountDown.h
//  MJCountDownButton
//
//  Created by Mengjie.Wang on 2016/06/22.
//  Copyright © 2016年 王梦杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown)

/**
 *
 *  倒计时按钮
 *
 *  @param seconds           倒计时时长
 *  @param normalTitle       倒计时结束按钮上显示的文字
 *  @param changeTitlePre    倒计时的前半部分
 *  @param changeTitleSuf    倒计时的后半部分
 *  @param normalBgColor     按钮的背景色
 *  @param changeBgColor     倒计时中按钮的背景色
 *  @param normalTitleColor  按钮上文字的颜色
 *  @param changeTitleColor  倒计时中按钮上文字的颜色
 */
- (void)button_countDownTotalSeconds:(NSInteger)seconds normalTitle:(NSString *)normalTitle changeTitlePre:(NSString *)changeTitlePre changeTitleSuf:(NSString *)changeTitleSuf normalBgColor:(UIColor *)normalBgColor changeBgColor:(UIColor *)changeBgColor normalTitleColor:(UIColor *)normalTitleColor changeTitleColor:(UIColor *)changeTitleColor;

@end
