//
//  TLModel.m
//  KZOC
//
//  Created by Zzz... on 2021/12/31.
//

#import "TLModel.h"

@implementation TLModel


- (instancetype)initWithId:(NSString *)iid fid:(NSString *)fid level:(TLLevel)level title:(NSString *)title subhead:(NSString *)subhead fold:(BOOL)fold {
    self = [super init];
    if (self) {
        self.iid = iid;
        self.fid = fid;
        self.level = level;
        self.title = title;
        self.subhead = subhead;
        self.fold = fold;
    }
    return self;
}

+ (instancetype)modelWithId:(NSString *)iid fid:(NSString *)fid level:(TLLevel)level title:(NSString *)title subhead:(NSString *)subhead fold:(BOOL)fold {
    return [[self alloc]initWithId:iid fid:fid level:level title:title subhead:subhead fold:fold];
}

@end
