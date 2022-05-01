//
//  TOperation.m
//  KZOC
//
//  Created by KZ on 2022/5/1.
//

#import "TOperation.h"

@implementation TOperation

- (void)main {
    for (int i = 0; i<5; i++) {
        NSLog(@"自定义Opeation：%d - %@",i,[NSThread currentThread]);
    }
}

@end
