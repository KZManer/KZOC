//
//  AddressView.m
//  KZOC
//
//  Created by Zzz... on 2021/11/23.
//

#import "AddressView.h"
#import "AddressCell.h"
#import "UIScrollView+EmptyDataSet.h"

@interface AddressView ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AddressView

#pragma mark - override method

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}

#pragma mark - private method

- (void)doViewUI {
    //tableView
//    self.backgroundColor = Color_Hex(@"#F5F5F5");
    self.tableView.backgroundColor = Color_Hex(@"#F5F5F5");
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    //防止底部按钮遮挡住tableView的内容
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, [KTools tools_heightOfTabBar])];
//    footerView.backgroundColor = Color_Hex(@"#F5F5F5");
    self.tableView.tableFooterView = footerView;
    
    //添加新地址按钮
    UIButton *addNewAddrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addNewAddrBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [addNewAddrBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addNewAddrBtn.backgroundColor = Color_Hex(@"#387DFC");
    [self addSubview:addNewAddrBtn];
    [addNewAddrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-([KTools tools_heightOfTabBar] - 44));
        make.height.mas_equalTo(44);
    }];
}


#pragma mark - UITableViewDataSource & UITableViewDelegate
//cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdAddress];
    if (!cell) {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdAddress];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - DZNEmptyDataSetSource & DZNEmptyDataSetDelegate
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return Color_Hex(@"#F5F5F5");
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"empty_placeholder_1"];
}
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"c_bg_blue"];
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"添加新地址";
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName : [UIFont font_fontPingFangSCMedium:16],
    };
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 30;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    //添加新地址按钮被点击
}

#pragma mark - lazy loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.estimatedRowHeight = 115;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[AddressCell class] forCellReuseIdentifier:CellIdAddress];
    }
    return _tableView;
}

@end
