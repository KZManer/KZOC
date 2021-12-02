//
//  AddressOperateView.m
//  KZOC
//
//  Created by Zzz... on 2021/11/24.
//

#import "AddressOperateView.h"
#import "AddressCustomView.h"

@interface AddressOperateView ()

/**收货人*/
@property (nonatomic, strong) AddressCustomView *consigneeView;
/**手机号*/
@property (nonatomic, strong) AddressCustomView *phoneView;
/**所在省份*/
@property (nonatomic, strong) AddressCustomView *provinceView;
/**所在城市*/
@property (nonatomic, strong) AddressCustomView *cityView;
/**所在区域*/
@property (nonatomic, strong) AddressCustomView *countyView;
/**详细地址*/
@property (nonatomic, strong) AddressCustomView *detailAddressView;
/**设为默认地址开关*/
@property (nonatomic, strong) UISwitch *defaultAddressSwitch;

@end

@implementation AddressOperateView

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
    self.backgroundColor = Color_Hex(@"#F5F5F5");
    
    CGFloat verticalSpace = 2;//垂直方向的间距
    
    /**收货人*/
    self.consigneeView = [[AddressCustomView alloc]initWithFrame:CGRectZero title:@"收货人：" placeholder:@"请输入收货人姓名" showArrow:false isMutiLine:false];
    [self addSubview:self.consigneeView];
    [self.consigneeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(verticalSpace);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    /**手机号*/
    self.phoneView = [[AddressCustomView alloc]initWithFrame:CGRectZero title:@"手机号：" placeholder:@"请输入手机号" showArrow:false isMutiLine:false];
    [self addSubview:self.phoneView];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.consigneeView.mas_bottom).offset(verticalSpace);
        make.left.right.height.equalTo(self.consigneeView);
    }];
    
    /**所在省份*/
    self.provinceView = [[AddressCustomView alloc]initWithFrame:CGRectZero title:@"所在省份：" placeholder:@"请选择所在省份" showArrow:true isMutiLine:false];
    [self addSubview:self.provinceView];
    [self.provinceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom).offset(verticalSpace);
        make.left.right.height.equalTo(self.phoneView);
    }];
    /**所在城市*/
    self.cityView = [[AddressCustomView alloc]initWithFrame:CGRectZero title:@"所在城市：" placeholder:@"请选择所在城市" showArrow:true isMutiLine:false];
    [self addSubview:self.cityView];
    [self.cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.provinceView.mas_bottom).offset(verticalSpace);
        make.left.right.height.equalTo(self.phoneView);
    }];
    /**所在区域*/
    self.countyView = [[AddressCustomView alloc]initWithFrame:CGRectZero title:@"所在区域：" placeholder:@"请选择所在区域" showArrow:true isMutiLine:false];
    [self addSubview:self.countyView];
    [self.countyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cityView.mas_bottom).offset(verticalSpace);
        make.left.right.height.equalTo(self.phoneView);
    }];
    /**详细地址*/
    self.detailAddressView = [[AddressCustomView alloc]initWithFrame:CGRectZero title:@"详细地址：" placeholder:@"如学校，街道，小区，楼牌，房号等，请准确填写，以保证快递到达" showArrow:false isMutiLine:true];
    [self addSubview:self.detailAddressView];
    [self.detailAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countyView.mas_bottom).offset(verticalSpace);
        make.left.right.equalTo(self.countyView);
        make.height.mas_equalTo(60);
    }];
    
    /**设为默认地址*/
    UIView *defaultAddressView = [[UIView alloc]init];
    defaultAddressView.backgroundColor = [UIColor whiteColor];
    [self addSubview:defaultAddressView];
    [defaultAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailAddressView.mas_bottom).offset(9);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    //默认地址标题
    UILabel *defaultAddressTitle = [[UILabel alloc]init];
    defaultAddressTitle.text = @"设为默认地址";
    defaultAddressTitle.font = [UIFont font_fontPingFangSCMedium:14];
    defaultAddressTitle.textColor = Color_Hex(@"#333333");
    defaultAddressTitle.textAlignment = NSTextAlignmentLeft;
    [defaultAddressView addSubview:defaultAddressTitle];
    [defaultAddressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(0);
    }];
    //设为默认地址开关
    self.defaultAddressSwitch = [[UISwitch alloc]initWithFrame:CGRectZero];
    self.defaultAddressSwitch.onTintColor = Color_Hex(@"#387DFC");
    [defaultAddressView addSubview:self.defaultAddressSwitch];
    [self.defaultAddressSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
    }];
    
    //如未选到所在地区，请联系客服400-606-1615
    UILabel *hintLabel = [[UILabel alloc]init];
    hintLabel.text = @"如未选到所在地区，请联系客服400-606-1615";
    hintLabel.textColor = Color_Hex(@"#999999");
    hintLabel.font = [UIFont font_fontPingFangSCMedium:12];
    [self addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(defaultAddressView.mas_bottom).offset(15);
    }];
    
    //保存按钮
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.backgroundColor = Color_Hex(@"#387DFC");
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hintLabel.mas_bottom).offset(45);
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.height.mas_equalTo(45);
    }];
    [saveBtn view_setCornerRadius:45.0/2 borderColor:nil borderWidth:0];
}

@end
