//
//  TabAnimatedVC.m
//  KZOC
//
//  Created by KZ on 2021/11/15.
//

#import "TabAnimatedVC.h"
#import "TABAnimated.h"
#import "TabAnimatedCell.h"

static NSString *CellIdentifierTabAnimated = @"CellIdentifierTabAnimated";

@interface TabAnimatedVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TabAnimatedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[TabAnimatedCell class] forCellReuseIdentifier:CellIdentifierTabAnimated];
    self.tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[TabAnimatedCell class] cellHeight:44];
    [self.view addSubview:self.tableView];
    
    
    [self.tableView tab_startAnimation];
    
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
//cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    TabAnimatedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TabAnimatedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

@end
