//
//  RuntimeVC.m
//  KZOC
//
//  Created by KZ on 2021/10/29.
//

#import "RuntimeVC.h"

@interface RuntimeVC ()

@end

@implementation RuntimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [KSelectView view]
    .kFrame(self.view.frame)
    .kDatasource(@[@"动态获取一个类有几个属性"])
    .kShow(self.view)
    .kSelectCell(^(NSString * _Nonnull cellName, NSInteger cellIndex) {
        if (cellIndex == 0) {
            
        }
    });
}


- (void)getCalssProperty {
    
}

@end
