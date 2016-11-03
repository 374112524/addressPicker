//
//  ViewController.m
//  AddressPickerDemo
//
//  Created by JZY on 16/11/3.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import "ViewController.h"

#import "addressPickerView.h"

@interface ViewController ()

@property (nonatomic,strong)addressPickerView * addressPickerView;

@property (nonatomic,strong)UILabel * label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
    label.layer.masksToBounds = YES;
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    label.layer.borderWidth = 0.5;
    [self.view addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击选择地址";
    self.label = label;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAddressTapAction:)];
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:tap];
    
}
-(addressPickerView *)addressPickerView{
    if (!_addressPickerView) {
        _addressPickerView = [[addressPickerView alloc]initWithFrame:self.view.bounds selectedBlock:^(AddressInfoModel *province, AddressInfoModel *city, AddressInfoModel *area) {
            self.label.text = [NSString stringWithFormat:@"%@%@%@",province.addressName,city.addressName,area.addressName];
        } hiddenSelf:^{
            _addressPickerView.hidden = YES;
        }];
        [self.view addSubview:_addressPickerView];
    }
    return _addressPickerView;
}
-(void)chooseAddressTapAction:(UITapGestureRecognizer *)tap{
    self.addressPickerView.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
