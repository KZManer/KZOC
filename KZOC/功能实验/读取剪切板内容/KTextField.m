//
//  KTextField.m
//  KZOC
//
//  Created by KZ on 2021/11/15.
//

#import "KTextField.h"

@implementation KTextField

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    return inset;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    if (self.text.length > 0) {
        return [super editingRectForBounds:bounds];
    } else {
        // 可通过默认文案来调整inset.origin.x保证光标在两个字之间
        CGRect inset = CGRectMake(bounds.origin.x + bounds.size.width / 2, bounds.origin.y, bounds.size.width - bounds.size.width / 2, bounds.size.height);
        return inset;
    }
}


@end
