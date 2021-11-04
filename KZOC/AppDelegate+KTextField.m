//
//  AppDelegate+KTextField.m
//  KZOC
//
//  Created by KZ on 2021/11/2.
//

#import "AppDelegate+KTextField.h"

@implementation AppDelegate (KTextField)

- (void)monitorTextFieldInputAction {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditingAction:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoAction:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)beginEditingAction:(NSNotification *)noti {
    if(![noti.object isKindOfClass:[UITextField class]]) return;
    UITextField *textField = (UITextField *)noti.object;
    self.tempTextFieldString = textField.text;
}
- (void)infoAction:(NSNotification *)noti {
    if(![noti.object isKindOfClass:[UITextField class]]) return;

    UITextField *textField = (UITextField *)noti.object;
    
    NSString *string = textField.text;
    
    if (textField.kTextFieldType == KTextFieldTypePhone) {
        NSString *string = textField.text;
        //手机号校验
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest || string.length > 11) {
            textField.text = self.tempTextFieldString;
            return;
        } else {
            self.tempTextFieldString = textField.text;
        }
        return;
    } else if (textField.kTextFieldType == KTextFieldTypePassword) {
        if ([KTools tools_isBlankString:string]) {
            self.tempTextFieldString = @"";
            textField.text = self.tempTextFieldString;
            return;
        }
        //设置密码 校验
        BOOL result = false;
//        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        //字母+数字
        NSString *regex = @"^[a-zA-Z0-9]+$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        NSLog(@"%@",textField.text);
        result = [pred evaluateWithObject:textField.text];
        if (result) {
            self.tempTextFieldString = string;
        } else {
            textField.text = self.tempTextFieldString;
        }
    }
}



@end
