//
//  TTListView.m
//  KZOC
//
//  Created by KZ on 2022/1/2.
//

#import "TTListView.h"
#import "TTNodeModel.h"
#import "TLFirstCell.h"
#import "TLSecondCell.h"
#import "TLThirdCell.h"

@interface TTListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<TTFirstNode *> *nodeInfos;
@property (nonatomic, strong) NSMutableArray<TTNodeModel *> *tempNodeInfos;
@property (nonatomic, assign) int count;


@end

@implementation TTListView

#pragma mark - override method
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}

#pragma mark private method
- (void)doViewUI {
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark public method
- (void)echoContent:(NSArray<TTFirstNode *> *)nodeInfos {
    self.nodeInfos = [NSArray arrayWithArray:nodeInfos];
    [self.tempNodeInfos addObjectsFromArray:self.nodeInfos];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tempNodeInfos.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TTNodeModel *nodeInfo = self.tempNodeInfos[indexPath.row];
    if ([nodeInfo isKindOfClass:[TTFirstNode class]]) {
        TTFirstNode *firstNodeInfo = (TTFirstNode *)nodeInfo;
        //一级cell
        TLFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdTLFirstCell];
        if (!cell) {
            cell = [[TLFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdTLFirstCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell echoNodeContent:firstNodeInfo];
        return cell;
    } else if ([nodeInfo isKindOfClass:[TTSecondNode class]]) {
        TTSecondNode *secondNodeInfo = (TTSecondNode *)nodeInfo;
        //二级cell
        TLSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdTLSecondCell];
        if (!cell) {
            cell = [[TLSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdTLSecondCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell echoNodeContent:secondNodeInfo];
        return cell;
    } else if ([nodeInfo isKindOfClass:[TTThirdNode class]]) {
        TTThirdNode *thirdNodeInfo = (TTThirdNode *)nodeInfo;
        //三级cell
        TLThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdTLThirdCell];
        if (!cell) {
            cell = [[TLThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdTLThirdCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell echoNodeContent:thirdNodeInfo];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TTNodeModel *nodeInfo = self.tempNodeInfos[indexPath.row];
    nodeInfo.expand = !nodeInfo.expand;
    NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
    if ([nodeInfo isKindOfClass:[TTFirstNode class]]) {
        //点击一级节点
        TTFirstNode *firstNode = (TTFirstNode *)nodeInfo;
        if (firstNode.expand) {
            //展开列表
            //插入二级节点数据
            NSRange insertRange = NSMakeRange(indexPath.row+1, firstNode.children.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:insertRange];
            [self.tempNodeInfos insertObjects:firstNode.children atIndexes:indexSet];
            //插入indexpath array
            for (int i = 0; i<firstNode.children.count; i++) {
                NSIndexPath *indexP = [NSIndexPath indexPathForRow:indexPath.row+1+i inSection:0];
                [indexPaths addObject:indexP];
            }
            //更新UI
            [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } else {
            //折叠列表
            //移除二级节点（如果有对应展开的三级节点，也要移除）
            int foldNum = 0;//要折叠的节点数量
            //计算二级节点的子节点展开数量
            for (TTSecondNode *obj in firstNode.children) {
                
                if (obj.expand) {
                    //将二级节点的展开状态设置为false
                    obj.expand = false;
                    //二级节点是展开状态，加上二级节点的字节点数量
                    foldNum += obj.children.count;
                }
            }
            //加上二级节点数量
            foldNum += firstNode.children.count;
            NSLog(@"%d",foldNum);
            //移除数据
            [self.tempNodeInfos removeObjectsInRange:NSMakeRange(indexPath.row+1, foldNum)];
            //indexpath array
            for (int i = 0; i<foldNum; i++) {
                NSIndexPath *indexP = [NSIndexPath indexPathForRow:indexPath.row+1+i inSection:0];
                [indexPaths addObject:indexP];
            }
            //更新UI
            [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }
    } else if ([nodeInfo isKindOfClass:[TTSecondNode class]]) {
        //点击二级节点
        TTSecondNode *secondNode = (TTSecondNode *)nodeInfo;
        if (secondNode.expand) {
            //展开列表
            //插入三级节点数据
            NSRange insertRange = NSMakeRange(indexPath.row + 1, secondNode.children.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:insertRange];
            [self.tempNodeInfos insertObjects:secondNode.children atIndexes:indexSet];
            //插入indexpath array
            for (int i = 0; i<secondNode.children.count; i++) {
                NSIndexPath *indexP = [NSIndexPath indexPathForRow:indexPath.row+1+i inSection:0];
                [indexPaths addObject:indexP];
            }
            //更新UI
            [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } else {
            //折叠列表
            //移除三级节点
            //移除数据
            [self.tempNodeInfos removeObjectsInArray:secondNode.children];
            //indexpath arr
            for (int i = 0; i<secondNode.children.count; i++) {
                NSIndexPath *indexP = [NSIndexPath indexPathForRow:indexPath.row+1+i inSection:0];
                [indexPaths addObject:indexP];
            }
            //更新UI
            [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    } else if ([nodeInfo isKindOfClass:[TTThirdNode class]]) {
        //点击三级节点
        TTThirdNode *thirdNode = (TTThirdNode *)nodeInfo;
        NSLog(@"点击了三级节点:%@",thirdNode.shortName);
    }
    
}
#pragma mark - lazy loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TLFirstCell class] forCellReuseIdentifier:CellIdTLFirstCell];
        [_tableView registerClass:[TLSecondCell class] forCellReuseIdentifier:CellIdTLSecondCell];
        [_tableView registerClass:[TLThirdCell class] forCellReuseIdentifier:CellIdTLThirdCell];
    }
    return _tableView;
}
- (NSMutableArray<TTNodeModel *> *)tempNodeInfos {
    if (!_tempNodeInfos) {
        _tempNodeInfos = [NSMutableArray array];
    }
    return _tempNodeInfos;
}
@end
