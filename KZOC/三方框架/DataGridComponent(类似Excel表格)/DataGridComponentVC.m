//
//  DataGridComponentVC.m
//  KZOC
//
//  Created by KZ on 2021/10/29.
//

#import "DataGridComponentVC.h"
#import "DataGridComponent.h"

@interface DataGridComponentVC ()

@end

@implementation DataGridComponentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //首先构建数据，用户也可以自己从文件中读取 
    DataGridComponentDataSource *ds = [[DataGridComponentDataSource alloc] init];
    ds.columnWidth = (NSMutableArray *)[NSArray arrayWithObjects:@"80",@"80",@"80",@"80",@"80",nil];
    ds.titles = (NSMutableArray *)[NSArray  arrayWithObjects:@"姓名",@"性别",@"年龄",@"籍贯",@"婚姻", nil];
    ds.data   = (NSMutableArray *)[NSArray arrayWithObjects:
                 [NSArray arrayWithObjects:@"周一",@"男",@"21",@"甘肃",@"已婚", nil],
                 [NSArray arrayWithObjects:@"张三",@"男",@"21",@"河南",@"未婚", nil],
                 [NSArray arrayWithObjects:@"张三",@"男",@"21",@"河南",@"已婚", nil],
                 [NSArray arrayWithObjects:@"李四",@"女",@"21",@"浙江",@"未婚", nil],
                 [NSArray arrayWithObjects:@"王五",@"男",@"21",@"湖北",@"未婚", nil],
                 [NSArray arrayWithObjects:@"赵六",@"男",@"21",@"福建",@"已婚", nil],
                 [NSArray arrayWithObjects:@"钱七",@"女",@"21",@"海南",@"未婚", nil],
                 [NSArray arrayWithObjects:@"刘八",@"男",@"21",@"天津",@"未婚", nil],
                 [NSArray arrayWithObjects:@"黄九",@"女",@"21",@"广东",@"已婚", nil],
                 nil
                 ];
    CGRect frame = CGRectMake(0, 100, self.view.width, 240);
    DataGridComponent *dataGird = [[DataGridComponent alloc] initWithFrame:frame data:ds];
    [self.view addSubview: dataGird];
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
