//
//  KPickerView.m
//  oc_test
//
//  Created by KZ on 2021/4/17.
//

#import "KPickerView.h"

@interface KPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    CGFloat _buttonH;
    CGFloat _bottomViewY;
}
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *certainButton;
@property (nonatomic, strong) NSArray *titles;//数据源
@property (nonatomic, copy) NSString *selectTitle;//选中的数据
@property (nonatomic, assign) NSInteger selectIndex;//选中的数据在数组中的下标

@property (nonatomic, copy) KSelectFinishHandler finishHandler;

@end

@implementation KPickerView

+ (instancetype)showInView:(UIView *)view titleArr:(NSArray *)titleArr showIndex:(NSInteger)showIndex finishHandler:(KSelectFinishHandler)handler {
    
    return [[self alloc]initWithFrame:view.bounds titleArr:titleArr showIndex:showIndex showInView:view finishHandler:handler];
}

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr showIndex:(NSInteger)showIndex showInView:(UIView *)view finishHandler:(nonnull KSelectFinishHandler)handler {
    
    self = [super initWithFrame:frame];
    if (self) {
        if (titleArr.count == 0) return nil;
        self.titles = [NSArray arrayWithArray:titleArr];
        
        self.selectIndex = showIndex < titleArr.count ? showIndex : 0;
        
        [self doViewUI];
        
        //block 设置回调
        self.finishHandler = handler;
        
        [self showInView:view];
    }
    return self;
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
    
    _buttonH = 44;
    CGFloat bottomViewH = self.frame.size.height * 0.35;
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
    [cancelButton setFrame: CGRectMake(15, 0, cancelButtonW - 15, _buttonH)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f] forState:UIControlStateNormal];
    [cancelButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [cancelButton setBackgroundColor:defaultBtnColor];
    [cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:cancelButton];

    /**确定按钮*/
    CGFloat btnHorSpace = 1;//两个按钮之间的间隔
    CGFloat certainButtonX = CGRectGetMaxX(cancelButton.frame)+btnHorSpace;
    CGFloat certainButtonW = self.bottomView.frame.size.width/2-btnHorSpace-15;
    UIButton *certainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.certainButton = certainButton;
    [certainButton setTitle:@"确认" forState:UIControlStateNormal];
    [certainButton setTitleColor:[UIColor colorWithRed:56.f/255.f green:125.f/255.f blue:252.f/255.f alpha:1.f] forState:UIControlStateNormal];
    [certainButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//    [certainButton setBackgroundColor:defaultBtnColor];
    [certainButton addTarget:self action:@selector(certainButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [certainButton setFrame:CGRectMake(certainButtonX, 0, certainButtonW, _buttonH)];
    [self.bottomView addSubview:certainButton];
    
    /**分割线*/
    UIView *separateLine = [[UIView alloc]initWithFrame:CGRectMake(0, _buttonH, self.frame.size.width, .8f)];
    separateLine.backgroundColor = [UIColor colorWithRed:224.f/255.f green:224.f/255.f blue:224.f/255.f alpha:1.f];
    [self.bottomView addSubview:separateLine];
    
    /**pickerView*/
    CGFloat pickerViewHeight = self.bottomView.frame.size.height - CGRectGetMaxY(separateLine.frame);
    CGFloat pickerViewY = CGRectGetMaxY(separateLine.frame);
    self.pickerView.frame = CGRectMake(0, pickerViewY, self.frame.size.width, pickerViewHeight);
    [self.bottomView addSubview:self.pickerView];
    [self.pickerView selectRow:self.selectIndex inComponent:0 animated:YES];
    
    /**设置圆角*/
    [self viewCornerWithView:self.bottomView rectCorner:UIRectCornerTopLeft|UIRectCornerTopRight];
    [self viewCornerWithView:cancelButton rectCorner:UIRectCornerTopLeft];
    [self viewCornerWithView:certainButton rectCorner:UIRectCornerTopRight];
}
- (void)viewCornerWithView:(UIView *)view rectCorner:(UIRectCorner)rectCorner {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(8.0f, 8.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
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
    //block 赋值回调结果
    if (self.finishHandler) {
        self.finishHandler(self.selectIndex);
        [self hide];
    }
}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.titles.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.titles[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectTitle = self.titles[component];
    self.selectIndex = row;
}

#pragma mark - lazy loading
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
@end
