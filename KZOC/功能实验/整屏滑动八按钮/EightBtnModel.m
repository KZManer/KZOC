//
//  EightBtnModel.m
//  KZOC
//
//  Created by Zzz... on 2021/11/18.
//

#import "EightBtnModel.h"

@implementation EightBtnModel

- (instancetype)initWithTitle:(NSString *)title imageLink:(NSString *)imageLink {
    self = [super init];
    if (self) {
        self.title = title;
        self.imageLink = imageLink;
    }
    return self;
}

+ (instancetype)eightBtnWithTitle:(NSString *)title imageLink:(NSString *)imageLink {
    return [[self alloc]initWithTitle:title imageLink:imageLink];
}

@end
