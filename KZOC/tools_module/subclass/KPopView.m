//
//  KPopView.m
//  TimeInternational
//
//  Created by KZ on 2021/8/13.
//

#import "KPopView.h"

@implementation KPopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.4];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)]];
        
        self.baseView = [[UIView alloc]init];
        self.baseView.backgroundColor = [UIColor whiteColor];
        [self.baseView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doNothing)]];
        [self addSubview:self.baseView];
    }
    return self;
}

- (void)doNothing {
    
}
- (void)showInView:(UIView *)view {
    [view addSubview:self];
    self.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
@end
