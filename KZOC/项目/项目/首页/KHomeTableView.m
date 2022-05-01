//
//  KHomeTableView.m
//  KZOC
//
//  Created by Zzz... on 2022/1/13.
//

#import "KHomeTableView.h"

@implementation KHomeTableView

// 返回YES表示可以继续传递触摸事件，这样便可实现了两个嵌套的scrollView同时滚动。
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
