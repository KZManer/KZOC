//
//  UITextField+KTextField.m
//  KZOC
//
//  Created by KZ on 2021/11/3.
//

#import "UITextField+KTextField.h"
#import <objc/runtime.h>

static NSString *kTextFieldTypeKey = @"kTextFieldTypeKey";

@implementation UITextField (KTextField)


- (KTextFieldType)kTextFieldType {
    NSNumber *numValue = objc_getAssociatedObject(self, &kTextFieldTypeKey);
    return [numValue integerValue];
}

- (void)setKTextFieldType:(KTextFieldType)kTextFieldType {
    objc_setAssociatedObject(self, &kTextFieldTypeKey, @(kTextFieldType), OBJC_ASSOCIATION_ASSIGN);
}

@end
