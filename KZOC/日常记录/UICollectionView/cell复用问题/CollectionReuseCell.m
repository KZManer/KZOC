//
//  CollectionReuseCell.m
//  KZOC
//
//  Created by Zzz... on 2021/12/7.
//

#import "CollectionReuseCell.h"

@interface CollectionReuseCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation CollectionReuseCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}

- (void)doViewUI {
    UILabel *label = [[UILabel alloc]initWithFrame:self.contentView.bounds];
    self.label = label;
    label.font = [UIFont font_fontPingFangSC:16];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:label];
    
    [self.contentView view_setCornerRadius:12.f borderColor:nil borderWidth:0];
    
    self.contentView.backgroundColor = Color_Hex(@"#3376FF");
    label.textColor = UIColor.whiteColor;
}

- (void)echoContent:(NSString *)text {
    self.label.text = text;
}

@end
