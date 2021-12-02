//  自定义新建收货地址页面的左label 右textFieldview
//  AddressCustomView.h
//  KZOC
//
//  Created by Zzz... on 2021/11/24.
//

#import <UIKit/UIKit.h>
#import "KTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressCustomView : UIView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) KTextView *textView;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder showArrow:(BOOL)showArrow isMutiLine:(BOOL)isMutiLine;

@end

NS_ASSUME_NONNULL_END
