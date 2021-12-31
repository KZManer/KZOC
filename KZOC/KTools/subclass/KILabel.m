//
//  KILabel.m
//  KZOC
//
//  Created by Zzz... on 2021/12/22.
//

#import "KILabel.h"

@implementation KILabel

- (instancetype)init {
    self = [super init];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    return [super initWithFrame:frame];
}
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.y = bounds.origin.y;
    return textRect;
}

- (void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}
@end
