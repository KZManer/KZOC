//
//  CountdownTimer.h
//
//  Created by wu, hao on 2019/10/28.
//  Copyright © 2019 wuhao. All rights reserved.
//  https://github.com/remember17/CountdownTimer

#import <Foundation/Foundation.h>

// 当需要一个倒计时的时候就在这里加一个key
typedef enum : NSUInteger {
    CountdownKeyFirst = 0,
} CountdownKey;

typedef void(^CountdownCallback)(NSInteger count, BOOL isFinished);

@interface CountdownTimer : NSObject

/**
 开启某个倒计时
 
 @param key 倒计时key
 @param count 倒计时长
 @param callback 回调
 */
+ (void)startTimerWithKey:(CountdownKey)key
                    count:(NSInteger)count
                 callBack:(CountdownCallback)callback;

/**
 停止一个倒计时
 
 @param key 倒计时key
 */
+ (void)stopTimerWithKey:(CountdownKey)key;

/**
 继续某个倒计时
 
 @param key 倒计时key
 @param callback 回调
 */
+ (void)continueTimerWithKey:(CountdownKey)key
                     callBack:(CountdownCallback)callback;

/**
 判断某个倒计时是否已经完成
 
 @param key 倒计时key
 @return 倒计时是否完成
 */
+ (BOOL)isFinishedTimerWithKey:(CountdownKey)key;

@end
/**
 使用：
 1、把CountdownTimer.h和CountdownTimer.m文件拖进项目
 2、在CountdownTimer.h的枚举CountDownKey中添加定时器
    ：每个枚举值代表一个可供使用的定时器
 3、在需要的地方导入头文件 #import "CountdownTimer.h"
 4、开启一个定时器
[CountdownTimer startTimerWithKey:test1 count:60 callBack:^(NSInteger count, BOOL isFinished) {
     NSLog(@"倒计时：%ld", count);
     NSLog(@"是否结束倒计时：%d", isFinished);
 }];
 5、手动停止某个定时器.
    ：手动停止或倒计时结束，此定时器都会被移除，除非再次开启
 6、继续某个定时器
    ：已经被停止的定时器是无法继续的，因为停止的定时器会被移除
    ：这个方法的作用是当开始定时器的页面被销毁，又想继续获取定时器状态的时候使用
 [CountdownTimer continueTimerWithKey:test1 callBack:^(NSInteger count, BOOL isFinished) {
     NSLog(@"倒计时：%ld", count);
     NSLog(@"是否结束倒计时：%d", isFinished);
 }];
 7、判断某个定时器是否结束了
 BOOL isFinished = [CountdownTimer isFinishedTimerWithKey:test1];
 NSLog(@"倒计时是否已经结束：%d", isFinished);

 */
