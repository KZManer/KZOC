//
//  CellSelectVC.m
//  demo
//
//  Created by KZ on 2021/10/25.
//

#import "CellSelectVC.h"
#import "KZSelectView.h"

@interface CellSelectVC ()

@end

@implementation CellSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *names = @[@"北京市",@"天津市",@"上海市",@"广州市",@"青岛市",@"西安市"];
    
    [KZSelectView view]
    .kFrame(self.view.frame)
    .kDatasource(names)
    .kShow(self.view)
    .kSelectCell(^NSString * _Nullable(NSString * _Nonnull cellName, NSInteger cellIndex) {
        NSLog(@"cell name : %@ cell index : %lu",cellName,cellIndex);
        return nil;
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
