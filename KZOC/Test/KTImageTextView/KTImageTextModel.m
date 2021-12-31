//
//  KTImageTextModel.m
//  KZOC
//
//  Created by Zzz... on 2021/12/18.
//

#import "KTImageTextModel.h"

@implementation KTImageTextModel

- (instancetype)initWithText:(NSString *)text imageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        self.imageName = imageName;
        self.titleName = text;
    }
    return self;
}

+ (instancetype)imageTextWithText:(NSString *)text imageName:(NSString *)imageName {
    return [[self alloc]initWithText:text imageName:imageName];
}

@end
