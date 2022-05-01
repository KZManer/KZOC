//
//  TSingleton.m
//  KZOC
//
//  Created by KZ on 2022/5/1.
//

#import "TSingleton.h"

@implementation TSingleton

static TSingleton *_instance;

+ (instancetype)shareInstance {
    NSLog(@"%s",__func__);
    return [[self alloc]init];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    NSLog(@"%s",__func__);
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone {
    NSLog(@"%s",__func__);
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    NSLog(@"%s",__func__);
    return _instance;
}
@end
