//
//  KTShare.h
//  KZOC
//
//  Created by Zzz... on 2021/12/16.
//

#import <Foundation/Foundation.h>
/**
 PGoodsMoreEnumFriends,//朋友圈
 PGoodsMoreEnumQQ,//QQ
 PGoodsMoreEnumWechat,//微信
 PGoodsMoreEnumDetail,//详情
 PGoodsMoreEnumUp,//置顶
 PGoodsMoreEnumCancelUp,//取消置顶
 PGoodsMoreEnumDelete,//删除
 PGoodsMoreEnumNull,//占位，不做任何操作
 */
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    KTShareItemNull,//占位，不做任何操作
    KTShareItemDetail,//详情
    KTShareItemDelete,//删除
    KTShareItemUp,//置顶
    KTShareItemCancelUp,//取消置顶
    KTShareItemFriends,//朋友圈
    KTShareItemWechat,//微信聊天
    KTShareItemQQ,//QQ
    KTShareItemSina,//新浪
} KTShareItem;

@interface KTShare : NSObject

@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) KTShareItem shareItem;

+ (instancetype)shareItemWithTitle:(NSString *)titleName imageName:(NSString *)imageName shareItem:(KTShareItem)shareItem;

@end

NS_ASSUME_NONNULL_END
