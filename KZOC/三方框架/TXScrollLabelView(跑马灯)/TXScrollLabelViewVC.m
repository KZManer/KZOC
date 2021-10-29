//
//  TXScrollLabelViewVC.m
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import "TXScrollLabelViewVC.h"
#import "TXScrollLabelView.h"

@interface TXScrollLabelViewVC ()

@end

@implementation TXScrollLabelViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    TXScrollLabelView *view1 = [[TXScrollLabelView alloc]initWithTitle:@"type:TXScrollLabelViewTypeLeftRight" type:TXScrollLabelViewTypeLeftRight velocity:0.6 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    view1.frame = CGRectMake(50, 100, self.view.width - 100, 40);
    [self.view addSubview:view1];
    [view1 beginScrolling];
    
    TXScrollLabelView *view2 = [[TXScrollLabelView alloc]initWithTitle:@"type请看右侧" type:TXScrollLabelViewTypeUpDown velocity:0.6 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    view2.font = [UIFont systemFontOfSize:22];
    view2.frame = CGRectMake(50, 150, 40, 140);
    [self.view addSubview:view2];
    [view2 beginScrolling];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, CGRectGetMinY(view2.frame) + (CGRectGetHeight(view2.frame) - 80)/2, CGRectGetWidth(view1.frame) - 50, 80)];
    label.numberOfLines = 0;
    label.text = @"TXScrollLabelViewTypeUpDown";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    TXScrollLabelView *view3 = [[TXScrollLabelView alloc]initWithTitle:@"type:TXScrollLabelViewTypeFlipRepeat" type:TXScrollLabelViewTypeFlipRepeat velocity:3 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    view3.frame = CGRectMake(50, 300, self.view.width - 100, 40);
    [self.view addSubview:view3];
    [view3 beginScrolling];
    
    TXScrollLabelView *view4 = [[TXScrollLabelView alloc]initWithTitle:@"type:TXScrollLabelViewTypeFlipNoRepeat" type:TXScrollLabelViewTypeFlipNoRepeat velocity:3 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    view4.frame = CGRectMake(50, 350, self.view.width - 100, 40);
    [self.view addSubview:view4];
    [view4 beginScrolling];
}

@end
