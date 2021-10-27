//
//  UIButton+KImageText.m
//  test
//
//  Created by KZ on 2021/8/7.
//

#import "UIButton+KImageText.h"

@implementation UIButton (KImageText)

//上图片 下文字
- (void)button_topImageBottomText:(CGFloat)space {
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    =   (tit_H / 2 + space / 2),
        .left   = - (img_W / 2),
        .bottom = - (tit_H / 2 + space / 2),
        .right  =   (img_W / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = - (img_H / 2 + space / 2),
        .left   =   (tit_W / 2),
        .bottom =   (img_H / 2 + space / 2),
        .right  = - (tit_W / 2),
    };
}

//上文字 下图片
- (void)button_topTextBottomImage:(CGFloat)space {
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = - (tit_H / 2 + space / 2),
        .left   = - (img_W / 2),
        .bottom =   (tit_H / 2 + space / 2),
        .right  =   (img_W / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    =   (img_H / 2 + space / 2),
        .left   =   (tit_W / 2),
        .bottom = - (img_H / 2 + space / 2),
        .right  = - (tit_W / 2),
    };
}

//左图片 右文字
- (void)button_leftImageRightText:(CGFloat)space {
    self.titleEdgeInsets = (UIEdgeInsets) {
        .top    = 0,
        .left   = space/2,
        .bottom = 0,
        .right  = -space/2,
    };
    self.imageEdgeInsets = (UIEdgeInsets) {
        .top    = 0,
        .left   = -space/2,
        .bottom = 0,
        .right  = space/2,
    };
}

//左文字 右图片
- (void)button_leftTextRightImage:(CGFloat)space {
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = - (img_W + space / 2),
        .bottom = 0,
        .right  =   (img_W + space / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   =   (tit_W + space / 2),
        .bottom = 0,
        .right  = - (tit_W + space / 2),
    };
}

@end
