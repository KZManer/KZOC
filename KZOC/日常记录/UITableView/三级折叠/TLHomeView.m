//
//  TLHomeView.m
//  KZOC
//
//  Created by Zzz... on 2021/12/31.
//

#import "TLHomeView.h"
#import "TLSectionHeader.h"
#import "TLFirstCell.h"
#import "TLSecondCell.h"
#import "TLThirdCell.h"

@interface TLHomeView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<TLModel *> *tlInfos;
@property (nonatomic, strong) NSMutableArray<TLModel *> *tempInfos;
@property (nonatomic, assign) int count;


@end

@implementation TLHomeView

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
- (void)echoContent:(NSArray<TLModel *> *)tlInfos {
    self.tlInfos = [NSArray arrayWithArray:tlInfos];
    [self.tlInfos enumerateObjectsUsingBlock:^(TLModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.level == TLLevelFirst) {
            [self.tempInfos addObject:obj];
        }
    }];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tempInfos.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TLModel *tlInfo = self.tempInfos[indexPath.row];
    if (tlInfo.level == TLLevelFirst) {
        //一级cell
        TLFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdTLFirstCell];
        if (!cell) {
            cell = [[TLFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdTLFirstCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell echoContent:tlInfo];
        return cell;
    } else if (tlInfo.level == TLLevelSecond) {
        //二级cell
        TLSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdTLSecondCell];
        if (!cell) {
            cell = [[TLSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdTLSecondCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell echoContent:tlInfo];
        return cell;
    } else if (tlInfo.level == TLLevelThird) {
        //三级cell
        TLThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdTLThirdCell];
        if (!cell) {
            cell = [[TLThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdTLThirdCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell echoContent:tlInfo];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TLModel *selInfo = self.tempInfos[indexPath.row];
    if (selInfo.level == TLLevelThird) {
        //点击了三级cell
        NSLog(@"点击了三级标题 %@",selInfo.title);
        return;
    } else {
        selInfo.fold = !selInfo.fold;
        if (selInfo.fold) {
            self.count = 0;
            [self foldWithId:selInfo.iid tlInfos:[self.tempInfos copy]];
            [self.tableView reloadData];
            NSLog(@"%d",self.count);
            return;
            //折叠
            //找到当前节点的子节点，从tempInfos中移除
            __block NSMutableArray<NSIndexPath *> *tempIndexPaths = [NSMutableArray array];
            NSArray<TLModel *> *tempINFOS = [self.tempInfos copy];
            [tempINFOS enumerateObjectsUsingBlock:^(TLModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                self.count++;
                if ([selInfo.iid isEqualToString:obj.fid]) {
                    //将当前节点的子节点删除
                    obj.fold = true;
                    [self.tempInfos removeObject:obj];
                    [tempIndexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
                }
                if (selInfo.level == TLLevelFirst) {
                    //进入此if说明点击的是一级节点，要删除子节点的子节点
                    [tempINFOS enumerateObjectsUsingBlock:^(TLModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                        self.count++;
                        //[obj.iid isEqualToString:obj1.fid] 此判断用于确定二级节点的子节点
                        //[selInfo.iid isEqualToString:obj.fid] 此判断用于确定处理的是当前一级节点的二级节点，防止误处理其他一级节点展开的二级节点
                        if ([obj.iid isEqualToString:obj1.fid] && [selInfo.iid isEqualToString:obj.fid]) {
                            obj1.fold = true;
                            [self.tempInfos removeObject:obj1];
                            [tempIndexPaths addObject:[NSIndexPath indexPathForRow:idx1 inSection:0]];
                        }
                    }];
                }
            }];
            NSLog(@"%d",self.count);
            [tableView deleteRowsAtIndexPaths:tempIndexPaths withRowAnimation:UITableViewRowAnimationNone];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        } else {
            //展开
            //找到当前节点的子节点，加到tempInfos中
            __block int insert = (int)indexPath.row+1;
            __block NSMutableArray<NSIndexPath *> *tempIndexPaths = [NSMutableArray array];
            [self.tlInfos enumerateObjectsUsingBlock:^(TLModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([selInfo.iid isEqualToString:obj.fid]) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:insert inSection:0];
                    [tempIndexPaths addObject:indexPath];
                    [self.tempInfos insertObject:obj atIndex:insert];
                    insert++;
                }
            }];
            [tableView insertRowsAtIndexPaths:tempIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }
    }
}
//递归处理
- (void)foldWithId:(NSString *)iid tlInfos:(NSArray<TLModel *> *)infos {
    NSLog(@"计算");
    NSMutableArray *tempInfos = [NSMutableArray arrayWithArray:infos];
    for (TLModel *obj in infos) {
        if (obj.level == TLLevelThird) {
            self.count++;
            if ([iid isEqualToString:obj.fid]) {
                
                [self.tempInfos removeObject:obj];
                [tempInfos removeObject:obj];
                //            return;
                continue;
            } else {
                [tempInfos removeObject:obj];
            }
        } else {
            self.count++;
            if ([iid isEqualToString:obj.fid]) {
                
                [self.tempInfos removeObject:obj];
                [tempInfos removeObject:obj];
                [self foldWithId:obj.iid tlInfos:tempInfos];
            } else {
                [tempInfos removeObject:obj];
            }
        }
    }
    
    NSLog(@"come in");
    
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
- (NSMutableArray<TLModel *> *)tempInfos {
    if (!_tempInfos) {
        _tempInfos = [NSMutableArray array];
    }
    return _tempInfos;
}
@end
