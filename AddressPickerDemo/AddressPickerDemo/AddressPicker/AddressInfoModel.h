//
//  AddressInfoModel.h
//  AddressPickerDemo
//
//  Created by JZY on 16/11/3.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressInfoModel : NSObject

@property (nonatomic,assign)int addressID;
@property (nonatomic,strong)NSString * addressName;
@property (nonatomic,assign)int parentsID;

@end
