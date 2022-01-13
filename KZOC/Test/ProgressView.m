//
//  ProgressView.m
//  圆形进度条
//
//  Created by rexsu on 2017/3/13.
//  Copyright © 2017年 Winny. All rights reserved.
//

#import "ProgressView.h"
@interface ProgressView ()
@property (nonatomic,strong)UILabel * dataLabel;
@property (nonatomic,strong)UILabel * dataNameLabel;

@end

@implementation ProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+(instancetype)createProgressWithFrame:(CGRect)frame backColor:(UIColor *)backColor color:(UIColor *)color proportion:(CGFloat)proportion{
    ProgressView * progressView = [[self alloc]initWithFrame:frame];
    if (!color) {
        progressView.progressColor  = [UIColor whiteColor];
    }else{
        progressView.progressColor  = color;
    }
    progressView.progressBackColor  = backColor;
    if (proportion <= 0) {
        proportion = 0;
    }
    else if (proportion > 0 && proportion < 1) {
        proportion = proportion;
    }
    else{
        proportion = 1;
    }
    progressView.proportion = proportion;
    [progressView showProgress];
    return progressView;
};



-(void)showProgress{
    
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height)/2 - MIN(self.bounds.size.width, self.bounds.size.height)/10;
    UIBezierPath * path     = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:radius startAngle:  -M_PI/2 endAngle:1.5*M_PI clockwise:YES];
    
    CAShapeLayer * backLayer    = [CAShapeLayer layer];
    backLayer.fillColor         = [[UIColor clearColor] CGColor];
    backLayer.strokeColor       = self.progressBackColor.CGColor;
    backLayer.lineWidth         = radius / 10;
    backLayer.strokeEnd         = 1;
    backLayer.path             = path.CGPath;
    [self.layer addSublayer:backLayer];
    
    CAShapeLayer * progressLayer    = [CAShapeLayer layer];
    progressLayer.fillColor         = [UIColor clearColor].CGColor;
    progressLayer.strokeColor       = self.progressColor.CGColor;
    progressLayer.lineWidth         = radius / 10;
    progressLayer.path              = path.CGPath;
    [self.layer addSublayer:progressLayer];
    
    CABasicAnimation * animation    = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue             = @(0);
    animation.toValue               = @(self.proportion);
    animation.duration              = 1;
    animation.fillMode              = kCAFillModeForwards;
    animation.removedOnCompletion   = NO;
    [progressLayer addAnimation:animation forKey:nil];
}

-(void)showContentData{
    _dataLabel.text                         = self.data;
    [self addSubview:self.dataLabel];
    [self addSubview:self.dataNameLabel];
}

-(UILabel *)dataLabel{
    if (!_dataLabel) {
        CGFloat radius                          = MIN(self.bounds.size.width, self.bounds.size.height) - 20;
        _dataLabel                              = [[UILabel alloc]init];
        _dataLabel.bounds                       = CGRectMake(0, 8, radius - 10 ,self.bounds.size.width /4+8);
        _dataLabel.center                       = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 - self.bounds.size.height/8+30);
        _dataLabel.textColor                    = [UIColor blackColor];
        _dataLabel.font                         = [UIFont font_fontPingFangSC:21];
        _dataLabel.center                       = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 + self.bounds.size.height/8 - 5);
        _dataLabel.textColor                    = Color_Hex(@"#666666");
        _dataLabel.font                         = [UIFont font_fontPingFangSC:25];
        _dataLabel.text                         = self.data;
        _dataLabel.adjustsFontSizeToFitWidth    = YES;
        _dataLabel.textAlignment                = NSTextAlignmentCenter;
    }
    return _dataLabel;
}

-(UILabel *)dataNameLabel{
    if (!_dataNameLabel) {
        CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) - 20;
        _dataNameLabel                              = [[UILabel alloc]init];
        _dataNameLabel.bounds                       = CGRectMake(0, 8, radius - 10 ,self.bounds.size.width /4+5);
        _dataNameLabel.center                       = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 + self.bounds.size.height/8-35);
        _dataNameLabel.textColor                    = Color_Hex(@"#666666");
//        _dataNameLabel.font                         = FONT(16);
        _dataNameLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _dataNameLabel.center                       =
        CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 - self.bounds.size.height/8-10);
        _dataNameLabel.textColor                    = Color_Hex(@"#999999");
        _dataNameLabel.font                         = [UIFont font_fontPingFangSC:14];
        _dataNameLabel.text                         = self.dataName;
        _dataNameLabel.adjustsFontSizeToFitWidth    = YES;
        
        _dataNameLabel.textAlignment                = NSTextAlignmentCenter;
    }
    return _dataNameLabel;
}
@end
