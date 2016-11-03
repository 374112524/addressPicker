//
//  addressPickerView.h
//  bullfighting
//
//  Created by JZY on 16/9/20.
//  Copyright © 2016年 JZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressInfoModel.h"

typedef void (^SureSelect)(AddressInfoModel * province,AddressInfoModel * city,AddressInfoModel * area);
typedef void (^HiddenView)();

@interface addressPickerView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong)SureSelect sureSelect;
@property (nonatomic, strong)HiddenView hiddenView;

- (id)initWithFrame:(CGRect)frame selectedBlock:(SureSelect)sureSelect hiddenSelf:(HiddenView)hiddenView;

@end
