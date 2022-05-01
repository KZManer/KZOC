//
//  AppDelegate+KTextField.h
//  KZOC
//
//  Created by KZ on 2021/11/2.
//  对textField输入内容统一进行管理

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (KTextField)

/**监听textField输入事件*/
- (void)monitorTextFieldInputAction;

@end

NS_ASSUME_NONNULL_END
