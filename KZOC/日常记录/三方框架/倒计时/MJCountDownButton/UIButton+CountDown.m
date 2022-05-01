//
//  UIButton+CountDown.m
//  MJCountDownButton
//
//  Created by Mengjie.Wang on 2016/06/22.
//  Copyright © 2016年 王梦杰. All rights reserved.
//

#import "UIButton+CountDown.h"

@implementation UIButton (CountDown)


- (void)button_countDownTotalSeconds:(NSInteger)seconds normalTitle:(NSString *)normalTitle changeTitlePre:(NSString *)changeTitlePre changeTitleSuf:(NSString *)changeTitleSuf normalBgColor:(UIColor *)normalBgColor changeBgColor:(UIColor *)changeBgColor normalTitleColor:(UIColor *)normalTitleColor changeTitleColor:(UIColor *)changeTitleColor {
    normalBgColor = normalBgColor ? normalBgColor : UIColor.blackColor;
    changeBgColor = changeBgColor ? changeBgColor : UIColor.blackColor;
    normalTitleColor = normalTitleColor ? normalTitleColor : UIColor.whiteColor;
    changeTitleColor = changeTitleColor ? changeTitleColor : UIColor.whiteColor;
    __weak typeof(self) weakSelf = self;
    
    // 剩余的时间
    __block NSInteger remainTime = seconds;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行一次
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    // 子线程（queue）执行event_handler
    dispatch_source_set_event_handler(timer, ^{
        
        if (remainTime <= 0) { // 倒计时结束
            dispatch_source_cancel(timer);
            // 主线程更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = normalBgColor;
                [weakSelf setTitle:normalTitle forState:UIControlStateNormal];
                [weakSelf setTitleColor:normalTitleColor forState:UIControlStateNormal];
                weakSelf.enabled = YES;
            });
        } else {
            NSString *timeStr = [NSString stringWithFormat:@"%ld", remainTime];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = changeBgColor;
                [weakSelf setTitle:[NSString stringWithFormat:@"%@%@%@",changeTitlePre,timeStr,changeTitleSuf] forState:UIControlStateDisabled];
                [weakSelf setTitleColor:changeTitleColor forState:UIControlStateNormal];
                weakSelf.enabled = NO;
            });
            remainTime--;
        }
    });
    dispatch_resume(timer);
}

@end
