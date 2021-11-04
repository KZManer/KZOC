//
//  UITextField+KTextField.h
//  KZOC
//
//  Created by KZ on 2021/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /**未设置*/
    KTextFiledTypeNotSet = 0,
    /**手机号*/
    KTextFieldTypePhone,
    /**密码 (>6位)*/
    KTextFieldTypePassword,
} KTextFieldType;

@interface UITextField (KTextField)

@property (nonatomic, assign) KTextFieldType kTextFieldType;

@end

NS_ASSUME_NONNULL_END
