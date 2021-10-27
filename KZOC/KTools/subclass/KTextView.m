//
//  KTextView.m
//  Runner
//
//  Created by KZ on 2021/4/16.
//

#import "KTextView.h"

@interface KTextView()<UITextViewDelegate>

@property (nonatomic, copy) KLinkHandler linkHandler;

@property (nonatomic, strong) NSMutableArray *rangeLocArr;

@end

@implementation KTextView



#pragma mark - 设置placeholder内容和颜色

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 * 监听文字改变
 */
- (void)textDidChange {
    // 重绘（重新调用）
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor:[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1.0];
    // 画文字
    //    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = 10;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

- (void)layoutSubviews {
    [self setNeedsDisplay];
    [super layoutSubviews];
    
}

#pragma mark - 协议点击跳转功能
- (void)kTextViewProtocolWithText:(NSString *)text linkColor:(UIColor *)linkColor linkTexts:(NSArray<NSString *> *)linkTexts linkHandler:(nonnull KLinkHandler)linkHandler {

    [self.rangeLocArr removeAllObjects];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:text];
    self.delegate = self;
    
    for (int i = 0; i<linkTexts.count; i++) {
        NSString *linkText = linkTexts[i];
        NSRange linkRange = [text rangeOfString:linkText];
        [self.rangeLocArr addObject:[NSString stringWithFormat:@"%lu",linkRange.location]];
        [attString addAttribute:NSLinkAttributeName value:@"click://" range:linkRange];

    }
    self.linkTextAttributes = @{NSForegroundColorAttributeName:linkColor};
    self.attributedText = attString;
    self.selectable = YES;
    self.editable = NO;
    
    //设置回调
    self.linkHandler = linkHandler;
}

#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    if ([[URL scheme] isEqualToString:@"click"]) {
        int clickRangeLoc = (int)characterRange.location;
        int index = -1;//点击的第几个链接
        for (int i = 0; i<self.rangeLocArr.count; i++) {
            NSString *loc = self.rangeLocArr[i];
            int locInt = [loc intValue];
            if (locInt == clickRangeLoc) {
                index = i;break;
            }
        }
       
        if (self.linkHandler) {
            self.linkHandler(index);
        }
    }
    return NO;
}

#pragma mark override method

- (NSMutableArray *)rangeLocArr {
    if (!_rangeLocArr) {
        _rangeLocArr = [NSMutableArray array];
    }
    return _rangeLocArr;
}

@end


