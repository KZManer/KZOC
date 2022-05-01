//
//  ShearVC.m
//  KZOC
//
//  Created by KZ on 2021/11/8.
//

#import "ShearVC.h"
#import "ShearView.h"

@interface ShearVC ()

@property (nonatomic, strong) ShearView *shearView;

@end

@implementation ShearVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.shearView = [[ShearView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.shearView];
}

@end
