//
//  KBottomPopView.m
//  Runner
//
//  Created by KZ on 2021/6/16.
//

#import "KBottomPopView.h"

@interface KBottomPopView()
{
    CGFloat _buttonH;
    CGFloat _bottomViewY;
}

@property (nonatomic, strong) UIView *bottomView;
/**取消按钮*/
@property (nonatomic, strong) UIButton *cancelButton;
/**确定按钮*/
@property (nonatomic, strong) UIButton *certainButton;
/**展示数据源的view*/
@property (nonatomic, strong) UIScrollView *scrollView;
/**数据源*/
@property (nonatomic, strong) NSArray *titles;

/**以下出现的按钮字样不包括取消和确定按钮，表示展示内容的按钮*/

/**选中的数据名称*/
@property (nonatomic, copy) NSString *selectTitle;
/**选中的数据下标*/
@property (nonatomic, assign) NSInteger selectIndex;
/**正常的按钮背景色*/
@property (nonatomic, strong) UIColor *normalBgColor;
/**选中的按钮边框颜色*/
@property (nonatomic, strong) UIColor *normalBorderColor;
/**正常的按钮文字颜色*/
@property (nonatomic, strong) UIColor *normalTextColor;
/**选中的按钮背景色*/
@property (nonatomic, strong) UIColor *selectBgColor;
/**选中的按钮边框颜色*/
@property (nonatomic, strong) UIColor *selectBorderColor;
/**选中的按钮文字颜色*/
@property (nonatomic, strong) UIColor *selectTextColor;

/**记录哪个按钮被点击*/
@property (nonatomic, strong) UIButton *activeButton;
/**存放按钮的数组*/
@property (nonatomic, strong) NSMutableArray *buttonsArray;

@property (nonatomic, copy) KBottomPopViewSelectFinishHandler finishHandler;

@end

@implementation KBottomPopView

+ (instancetype)showInView:(UIView *)view titleArr:(NSArray *)titleArr showIndex:(NSInteger)showIndex finishHandler:(KBottomPopViewSelectFinishHandler)handler {
    
    return [[self alloc]initWithFrame:view.bounds titleArr:titleArr showIndex:showIndex showInView:view finishHandler:handler];
}

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr showIndex:(NSInteger)showIndex showInView:(UIView *)view finishHandler:(nonnull KBottomPopViewSelectFinishHandler)handler {
    
    self = [super initWithFrame:frame];
    if (self) {
        if (titleArr.count == 0) return nil;
        self.titles = [NSArray arrayWithArray:titleArr];
        
        self.selectIndex = (showIndex < titleArr.count && showIndex >= 0) ? showIndex : 0;
        
        [self configParameters];
        [self doViewUI];
        
        //block 设置回调
        self.finishHandler = handler;
        
        [self showInView:view];
    }
    return self;
}

//配置参数
- (void)configParameters {
    self.normalBgColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    self.normalBorderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    self.normalTextColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:96/255.0 alpha:1.0];
    self.selectBgColor = [UIColor whiteColor];
    self.selectBorderColor = [UIColor colorWithRed:37/255.0 green:162/255.0 blue:254/255.0 alpha:1.0];
    self.selectTextColor = [UIColor colorWithRed:37/255.0 green:162/255.0 blue:254/255.0 alpha:1.0];
    
    self.buttonsArray = [NSMutableArray array];
    [self.buttonsArray removeAllObjects];
}

#pragma mark - 定制参数

//设置取消和确认按钮的背景色
- (void)setPickerButtonColor:(UIColor *)pickerButtonColor {
    self.cancelButton.backgroundColor = pickerButtonColor;
    self.certainButton.backgroundColor = pickerButtonColor;
}

#pragma mark - method

- (void)doViewUI {
    
    self.alpha = 0.0f;
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.4];
    
    _buttonH = 40;
    CGFloat bottomViewH = self.frame.size.height * 0.4;
    _bottomViewY = self.frame.size.height - bottomViewH;
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)]];
    
    /**bottomView*/
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, bottomViewH)];
    self.bottomView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    [self addSubview:self.bottomView];
    
    UIColor *defaultBtnColor = [UIColor colorWithRed:33.0/255.0 green:141.0/255 blue:254.0/255.0 alpha:1.0];
    
    /**取消按钮*/
    CGFloat cancelButtonW = self.bottomView.frame.size.width/2;
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton = cancelButton;
    [cancelButton setFrame: CGRectMake(0, 0, cancelButtonW, _buttonH)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:defaultBtnColor];
    [cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:cancelButton];

    /**确定按钮*/
    CGFloat btnHorSpace = 1;//两个按钮之间的间隔
    CGFloat certainButtonX = CGRectGetMaxX(cancelButton.frame)+btnHorSpace;
    CGFloat certainButtonW = self.bottomView.frame.size.width/2-btnHorSpace;
    UIButton *certainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.certainButton = certainButton;
    [certainButton setTitle:@"确认" forState:UIControlStateNormal];
    [certainButton setBackgroundColor:defaultBtnColor];
    [certainButton addTarget:self action:@selector(certainButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [certainButton setFrame:CGRectMake(certainButtonX, 0, certainButtonW, _buttonH)];
    [self.bottomView addSubview:certainButton];
    
    /**内容view*/
    CGFloat contentViewW = self.bottomView.frame.size.width;
    CGFloat contentViewH = bottomViewH - _buttonH;
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _buttonH, contentViewW, contentViewH)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.clipsToBounds = NO;
    
    [self.bottomView addSubview:self.scrollView];
    
    NSInteger column = 3;//3列
    NSInteger row = (self.titles.count % 3 == 0) ? self.titles.count / 3 : self.titles.count / 3 + 1;//行数
    CGFloat horSpace = 10;//按钮之间的横向间隔
    CGFloat verSpace = 10;//按钮之间的竖向间隔
    
    CGFloat buttonW = (contentViewW - horSpace * (column+1)) / column;
    CGFloat buttonH = 44;
    
    self.scrollView.contentSize = CGSizeMake(contentViewW, (verSpace + buttonH) * row + verSpace);
    
    for (int i = 0; i<self.titles.count; i++) {
        CGFloat buttonX = horSpace + (buttonW + horSpace) * (i % column);
        CGFloat buttonY = verSpace + (buttonH + verSpace) * (i / column);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        
        //内容自适应
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.titleLabel.minimumScaleFactor = 0.5;
        button.titleLabel.numberOfLines = 2;
        
        
        [button setTitleColor:self.normalTextColor forState:UIControlStateNormal];
        [button setBackgroundColor:self.normalBgColor];
        
        [button.layer setBorderWidth:1.0f];
        [button.layer setCornerRadius:4.0f];
        [button.layer setBorderColor:self.normalBorderColor.CGColor];
        [button.layer setMasksToBounds:YES];
        
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:button];
        
        [self.buttonsArray addObject:button];
        
        if (self.selectIndex == i) {
//            self.activeButton = button;
            [self buttonPressed:button];
        }
        
    }
    
    /**设置圆角*/
    [self viewCornerWithView:self.bottomView rectCorner:UIRectCornerTopLeft|UIRectCornerTopRight];
    [self viewCornerWithView:cancelButton rectCorner:UIRectCornerTopLeft];
    [self viewCornerWithView:certainButton rectCorner:UIRectCornerTopRight];
}

//内容按钮被点击
- (void)buttonPressed:(UIButton *)button {
    
    //如果本次点击的按钮与上次的按钮是同一个，不做处理
    if (self.activeButton == button) return;
    
    //记录点击的按钮的下标（对应内容的下标）
    self.selectIndex = [self.buttonsArray indexOfObject:button];
    
    //将上次选中的按钮的样式设置为正常样式
    [self.activeButton setTitleColor:self.normalTextColor forState:UIControlStateNormal];
    [self.activeButton.layer setBorderColor:self.normalBorderColor.CGColor];
    [self.activeButton setBackgroundColor:self.normalBgColor];
    
    //将本次选中的按钮设置为选中样式
    [button setTitleColor:self.selectTextColor forState:UIControlStateNormal];
    [button setBackgroundColor:self.selectBgColor];
    [button.layer setBorderColor:self.selectBorderColor.CGColor];
    
    //将本次按钮更改为活跃按钮
    self.activeButton = button;
}

/**确认按钮被点击*/
- (void)certainButtonPressed {
    //block 赋值回调结果
    if (self.finishHandler) {
        self.finishHandler(self.selectIndex,self.titles[self.selectIndex]);
        [self hide];
    }
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

- (void)viewCornerWithView:(UIView *)view rectCorner:(UIRectCorner)rectCorner {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(8.0f, 8.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

@end
