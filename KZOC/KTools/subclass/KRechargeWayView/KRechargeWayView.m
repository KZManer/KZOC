//
//  KRechargeWayView.m
//  Runner
//
//  Created by KZ on 2021/7/24.
//

#import "KRechargeWayView.h"

@interface KRechargeWayView()
{
    CGFloat _bottomViewY;
}
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) NSMutableArray *buttonArray;

/**要充值的金额*/
@property (nonatomic, copy) NSString *rechargeMoney;

@property (nonatomic, copy) KRechargeSelectFinishHandler finishHandler;

@end

@implementation KRechargeWayView

+ (instancetype)showInView:(UIView *)view rechargeMoney:(NSString *)rechargeMoney finishHandler:(KRechargeSelectFinishHandler)handler {
    
    return [[self alloc]initWithFrame:view.bounds showInView:view rechargeMoney:rechargeMoney finishHandler:handler];
}

- (instancetype)initWithFrame:(CGRect)frame showInView:(UIView *)view rechargeMoney:(NSString *)rechargeMoney finishHandler:(nonnull KRechargeSelectFinishHandler)handler {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.rechargeMoney = rechargeMoney;
        
        [self doViewUI];
        
        //block 设置回调
        self.finishHandler = handler;
        
        [self showInView:view];
    }
    return self;
}


#pragma mark - method

- (void)doViewUI {
    
    self.alpha = 0.0f;
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.4];
    
    
    CGFloat titleH = 40;
    CGFloat subTitleH = 30;
    CGFloat subTitleBottomSpace = 10;
    CGFloat cellH = 60;
    CGFloat cetatinButtonTopSpace = 10;
    CGFloat certainButtonH = 40;
    CGFloat certainButtonBottomSpace = 30;
    CGFloat bottomViewH = titleH + subTitleH + subTitleBottomSpace + cellH * 2 + cetatinButtonTopSpace + certainButtonH + certainButtonBottomSpace;
    CGFloat tempH = self.frame.size.height * 0.4;
    bottomViewH = bottomViewH > tempH ? bottomViewH : tempH;
    _bottomViewY = self.frame.size.height - bottomViewH;
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)]];
    
    /**bottomView*/
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, bottomViewH)];
//    self.bottomView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.bottomView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doNothing)]];
    [self addSubview:self.bottomView];
    
    UIColor *defaultBtnColor = [UIColor colorWithRed:33.0/255.0 green:141.0/255 blue:254.0/255.0 alpha:1.0];
    
    /**标题*/
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bottomView.frame), titleH)];
    titleLabel.text = [NSString stringWithFormat:@"¥%@",self.rechargeMoney];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:18 weight:0.2];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:titleLabel];
    /**副标题*/
    UILabel *subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(titleLabel.frame), subTitleH)];
    subTitleLabel.text = @"选择支付方式";
    subTitleLabel.textColor = [UIColor darkGrayColor];
    subTitleLabel.font = [UIFont systemFontOfSize:15];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:subTitleLabel];
    
    /**微信支付*/
    CGFloat wechatViewH = CGRectGetMaxY(subTitleLabel.frame) + subTitleBottomSpace;
    UIImage *wechatImg = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"recharge_wechat" ofType:@"png"]];
    UIView *wechatView = [self contentView:CGRectMake(0, wechatViewH, CGRectGetWidth(self.bottomView.frame), cellH) image:wechatImg title:@"微信支付"];
    [self.bottomView addSubview:wechatView];
    
    /**支付宝支付*/
    CGFloat alipayViewH = CGRectGetMaxY(wechatView.frame);
    UIImage *alipayImg = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"recharge_alipay" ofType:@"png"]];
    UIView *alipayView = [self contentView:CGRectMake(0, alipayViewH, CGRectGetWidth(self.bottomView.frame), cellH) image:alipayImg title:@"支付宝支付"];
    [self.bottomView addSubview:alipayView];
    
    /**确定按钮*/
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [certainBtn setFrame:CGRectMake(20, bottomViewH - certainButtonH - certainButtonBottomSpace, CGRectGetWidth(self.bottomView.frame) - 40, certainButtonH)];
    [certainBtn setTitle:@"确定" forState:UIControlStateNormal];
    [certainBtn setBackgroundColor:defaultBtnColor];
    [certainBtn addTarget:self action:@selector(certainButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:certainBtn];
    
    /**设置圆角*/
    [self viewCornerWithView:self.bottomView rectCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:8.0f];
    [self viewCornerWithView:certainBtn rectCorner:UIRectCornerAllCorners radius:20.0f];
}
- (UIView *)contentView:(CGRect)frame image:(UIImage *)image title:(NSString *)title {
    UIView *view = [[UIView alloc]initWithFrame:frame];
    
    CGFloat imageViewH = frame.size.height * 0.6;
    CGFloat imageViewY = (frame.size.height - imageViewH)/2;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, imageViewY, imageViewH, imageViewH)];
    imageView.image = image;
    [view addSubview:imageView];
    
    CGFloat buttonH = 30.0;
    buttonH = buttonH > frame.size.height ? frame.size.height : buttonH;
    CGFloat buttonY = (frame.size.height - buttonH)/2;
    CGFloat buttonX = frame.size.width - buttonH - 20;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(buttonX, buttonY, buttonH, buttonH)];
    UIImage *normalImg = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"recharge_normal" ofType:@"png"]];
    UIImage *selectImg = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"recharge_select" ofType:@"png"]];
    [button setImage:normalImg forState:UIControlStateNormal];
    [button setImage:selectImg forState:UIControlStateSelected];
    [button setSelected:NO];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [self.buttonArray addObject:button];
    
    CGFloat labelX = CGRectGetMaxX(imageView.frame) + 10;
    CGFloat labelW = CGRectGetMinX(button.frame) - labelX - 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, 0,labelW, frame.size.height)];
    label.text = title;
    [view addSubview:label];
    
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellPressed:)]];
    
    return view;
}
- (void)buttonPressed:(UIButton *)button {

    for (UIButton *btn in self.buttonArray) {
        btn.selected = NO;
    }
    button.selected = YES;
}
- (void)cellPressed:(UITapGestureRecognizer *)gesture {
    for (UIButton *btn in self.buttonArray) {
        btn.selected = NO;
    }
    UIView *view = gesture.view;
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *activeBtn = (UIButton *)subView;
            activeBtn.selected = YES;
        }
    }
}
- (void)viewCornerWithView:(UIView *)view rectCorner:(UIRectCorner)rectCorner radius:(CGFloat)radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
- (void)doNothing {
    
}
/**隐藏视图*/
- (void)hide {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 0.0f;
        
        CGRect frame = self.bottomView.frame;
        frame.origin.y = self.frame.size.height;
        self.bottomView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}

/**展示视图*/
- (void)showInView:(UIView *)view {
    
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0f;
        
        CGRect frame = self.bottomView.frame;
        frame.origin.y = self->_bottomViewY;
        self.bottomView.frame = frame;
        
    }];
}

/**确认按钮被点击*/
- (void)certainButtonPressed {
    RechargeWay recharge = RechargeWayNone;
    for (int i = 0; i<self.buttonArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        if (button.isSelected) {
            recharge = i;
        }
    }
    //block 赋值回调结果
    if (self.finishHandler) {
        self.finishHandler(recharge);
    }
    if (recharge != RechargeWayNone) {
        [self hide];
    }
}

#pragma mark - override method
- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

@end

