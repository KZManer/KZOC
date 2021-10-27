//
//  TableViewVC.m
//  demo
//
//  Created by KZ on 2021/10/25.
//

#import "TableViewVC.h"

@interface TableViewVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *value = @"unknown";
    switch (section) {
        case 0:
            value = @"UITableViewCellStyleDefault";break;
        case 1:
            value = @"UITableViewCellStyleValue1";break;
        case 2:
            value = @"UITableViewCellStyleValue2";break;
        case 3:
            value = @"UITableViewCellStyleSubtitle";break;
        default:
            break;
    }
    return value;
}
//cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId1 = @"cellId1";
    static NSString *cellId2 = @"cellId2";
    static NSString *cellId3 = @"cellId3";
    static NSString *cellId4 = @"cellId4";
    
    UITableViewCell *cell = nil;
    NSString *cellId = cellId1;
    UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
    
    if ( indexPath.section == 0) {
        cellId = cellId1;
        cellStyle = UITableViewCellStyleDefault;
    } else if (indexPath.section == 1) {
        cellId = cellId2;
        cellStyle = UITableViewCellStyleValue1;
    } else if (indexPath.section == 2) {
        cellId = cellId3;
        cellStyle = UITableViewCellStyleValue2;
    } else {
        cellId = cellId4;
        cellStyle = UITableViewCellStyleSubtitle;
    }
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:cellStyle reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = @"textLabel";
    cell.detailTextLabel.text = @"detailTextLabel";
    cell.imageView.image = [UIImage imageNamed:@"image"];
    
    return cell;
}

@end
