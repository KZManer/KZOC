//
//  UIView+kView.m
//  Runner
//
//  Created by KZ on 2021/4/16.
//

#import "UIView+KView.h"

@implementation UIView (KView)

//setCornerRadius   给view设置圆角
- (void)view_setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner {
    
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
  
}
- (void)view_setCornerRadius:(CGFloat)value borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
//    [self layoutIfNeeded];//这句代码很重要，不能忘了
    borderColor = borderColor == nil ? [UIColor clearColor] : borderColor;
    self.layer.cornerRadius = value;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}
//设置渐变颜色
- (void)view_setColorGradual:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations horizontalLayout:(BOOL)horizontal {
    if (colors.count != locations.count) return;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    NSMutableArray *bridgeColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [bridgeColors addObject:(__bridge  id)color.CGColor];
    }
    gradientLayer.colors = bridgeColors;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = CGPointMake(0, 0);
    
    if (horizontal) {
        gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    } else {
        gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    }
    gradientLayer.frame = self.bounds;
    [self.layer addSublayer:gradientLayer];
}
@end
