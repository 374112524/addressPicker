//
//  AddressInfoModel.m
//  AddressPickerDemo
//
//  Created by JZY on 16/11/3.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import "AddressInfoModel.h"

@implementation AddressInfoModel

-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    
    self.addressID = [[keyedValues objectForKey:@"value"]intValue];
    self.addressName = [keyedValues objectForKey:@"name"];
    self.parentsID = [[keyedValues objectForKey:@"parent"]intValue];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"undefine:%@",key);
}

@end
