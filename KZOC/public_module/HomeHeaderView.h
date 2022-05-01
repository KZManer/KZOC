//
//  HomeHeaderView.h
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static int HOMEHEADERVIEWCELLHEIGHT = 54;
static int HOMEHEADERVIEWCELLCOLUMN = 3;

@interface HomeHeaderView : UICollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout titles:(NSArray *)titles;

@end

NS_ASSUME_NONNULL_END
