//
//  KSelectView.m
//  demo
//
//  Created by KZ on 2021/10/23.
//

#import "KSelectView.h"

@interface KSelectView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) KSelectAction selectAction;

@end

@implementation KSelectView

+ (instancetype)view {
    KSelectView *view = [[KSelectView alloc]init];
    return view;
}
- (KFrame)kFrame {
    return ^(CGRect frame) {
        self.frame = frame;
        
        self.tableView = [[UITableView alloc]initWithFrame:frame];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableView];
        
        return self;
    };
}
- (KBackgroundColor)kBackgroundColor {
    return ^(UIColor *bgColor) {
        self.backgroundColor = bgColor;
        return self;
    };
}

- (KShow)kShow {
    return ^(UIView *superView){
        [superView addSubview:self];
        return self;
    };
}

- (KDatasource)kDatasource {
    return ^(NSArray *datasource) {
        if (!datasource) {
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i < 13; i++) {
                [array addObject:[NSString stringWithFormat:@"%d页",i]];
            }
            datasource = [NSArray arrayWithArray:array];
        }
        if (self.datasource) [self.datasource removeAllObjects];
        self.datasource = [NSMutableArray arrayWithArray:datasource];
        return self;
    };
}

- (KSelectCell)kSelectCell {
    return ^(KSelectAction action) {
        self.selectAction = action;
        return self;
    };
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
//cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // 153 209 211
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    UIColor *bgColor = indexPath.row % 2 == 0 ?
    [UIColor colorWithRed:201/255.0 green:228/255.0 blue:214/255.0 alpha:0.6] :
    [UIColor colorWithRed:202/209 green:229/255.0 blue:232/255.0 alpha:0.6];
    cell.backgroundColor = bgColor;
    cell.textLabel.text = self.datasource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *rowName = self.datasource[indexPath.row];
    NSInteger rowIndex = indexPath.row;
    if (self.selectAction) {
        self.selectAction(rowName, rowIndex);
    }
}

@end
