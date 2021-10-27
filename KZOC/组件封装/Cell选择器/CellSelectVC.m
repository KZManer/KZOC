//
//  CellSelectVC.m
//  demo
//
//  Created by KZ on 2021/10/25.
//

#import "CellSelectVC.h"
#import "KSelectView.h"

@interface CellSelectVC ()

@end

@implementation CellSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *names = @[@"北京市",@"天津市",@"上海市",@"广州市",@"青岛市",@"西安市"];
    
    [KSelectView view]
    .kFrame(self.view.frame)
    .kDatasource(names)
    .kShow(self.view)
    .kSelectCell(^NSString * _Nullable(NSString * _Nonnull cellName, NSInteger cellIndex) {
        NSString *text = [NSString stringWithFormat:@"cell name:%@ index:%ld",cellName,(long)cellIndex];
        [MBProgressHUD showText:text];
        NSLog(@"cell name : %@ cell index : %lu",cellName,cellIndex);
        return nil;
    });
}

@end
