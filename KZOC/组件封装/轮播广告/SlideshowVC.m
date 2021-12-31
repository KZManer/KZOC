//
//  SlideshowVC.m
//  KZOC
//
//  Created by Zzz... on 2021/12/3.
//
/**
 http://image.jinyingjie.com/Uploads/MobileIndexAds/61a73ccada395.png,
 http://image.jinyingjie.com/Uploads/MobileIndexAds/6146fff651a83.png,
 http://image.jinyingjie.com/Uploads/MobileIndexAds/61946e0201239.jpg,
 http://image.jinyingjie.com/Uploads/MobileIndexAds/61a71659241e8.png,
 http://image.jinyingjie.com/Uploads/MobileIndexAds/61a736750871d.jpg,
 http://image.jinyingjie.com/Uploads/MobileIndexAds/5fabcda1c6b96.jpg
 */
#import "SlideshowVC.h"
#import "NewPagedFlowView.h"
#import "SDWebImage.h"

@interface SlideshowVC ()<NewPagedFlowViewDataSource,NewPagedFlowViewDelegate>

@property (nonatomic, strong) NSArray<NSString *> *imageLinks;

@end

@implementation SlideshowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.imageLinks = @[
        @"http://image.jinyingjie.com/Uploads/MobileIndexAds/61a73ccada395.png",
        @"http://image.jinyingjie.com/Uploads/MobileIndexAds/6146fff651a83.png",
        @"http://image.jinyingjie.com/Uploads/MobileIndexAds/61946e0201239.jpg",
        @"http://image.jinyingjie.com/Uploads/MobileIndexAds/61a71659241e8.png",
        @"http://image.jinyingjie.com/Uploads/MobileIndexAds/61a736750871d.jpg",
        @"http://image.jinyingjie.com/Uploads/MobileIndexAds/5fabcda1c6b96.jpg"
    ];
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 200, Width_Screen, Width_Screen * 0.373)];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.1;
    pageFlowView.isCarousel = YES;
    pageFlowView.autoTime = 2;
    pageFlowView.contentMode = UIViewContentModeScaleAspectFill;
    pageFlowView.clipsToBounds = YES;
    [pageFlowView.layer setMasksToBounds:YES];
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = YES;
    [self.view addSubview:pageFlowView];
    [pageFlowView reloadData];

}

#pragma mark - NewPagedFlowViewDataSource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.imageLinks.count;
}
- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 5;
        bannerView.layer.masksToBounds = YES;
    }
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.imageLinks[index]] placeholderImage:[UIImage imageNamed:@"sy_banner_temImage"]];
    return bannerView;
}

#pragma mark - NewPagedFlowViewDelegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(Width_Screen - 40, (Width_Screen - 40) * 0.373);
}
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
}
- (void)didSelectCell:(PGIndexBannerSubiew *)subView withSubViewIndex:(NSInteger)subIndex {
    
}
@end
