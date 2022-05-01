//
//  TableViewVC1.m
//  KZOC
//
//  Created by KZ on 2021/11/10.
//

#import "TableViewVC1.h"
#import "TableViewCell1.h"

@interface TableViewVC1 ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *datasource;

@end

@implementation TableViewVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datasource = @[
        @"这是一行测试文本",
        @"这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本",
        @"这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本这是多行测试文本",
    ];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 90;
    [tableView registerClass:[TableViewCell1 class] forCellReuseIdentifier:cellIdentiferTableViewCell1];
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

//cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentiferTableViewCell1];
    if (!cell) {
        cell = [[TableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentiferTableViewCell1];
    }
    [cell echoContent:self.datasource[indexPath.row]];
    return cell;
}

@end
