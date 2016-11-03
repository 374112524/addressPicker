//
//  NSObject+Category.m
//  bullfighting
//
//  Created by JZY on 16/11/2.
//  Copyright © 2016年 JZY. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

- (id)optObjectForKey:(id)aKey
{
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id obj = [self objectForKey:aKey];
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}

- (NSString*)optDoubleStringForKey:(id)aKey defaultValue:(NSString*)value
{
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id obj = [self objectForKey:aKey];
    if (obj == [NSNull null]) {
        return value;
    }
    return [NSString stringWithFormat:@"%.2f", [obj doubleValue]];
}

- (id)optObjectForKey:(id)aKey defaultValue:(id)value
{
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id obj = [self objectForKey:aKey];
    if (obj == [NSNull null]) {
        return value;
    }
    if (!obj) {
        return value;
    }
    return obj;
}

- (double)optDoubleForKey:(id)aKey
{
    id obj = [self optObjectForKey:aKey];
    return [obj doubleValue];
}

- (NSInteger)optIntForKey:(id)aKey
{
    id obj = [self optObjectForKey:aKey];
    return [obj integerValue];
}


@end
