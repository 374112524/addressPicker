//
//  NSObject+Category.h
//  bullfighting
//
//  Created by JZY on 16/11/2.
//  Copyright © 2016年 JZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Category)

- (id)optObjectForKey:(id)aKey;
- (id)optObjectForKey:(id)aKey defaultValue:(id)value;
- (double)optDoubleForKey:(id)aKey;
- (NSInteger)optIntForKey:(id)aKey;
- (id)optDoubleStringForKey:(id)aKey defaultValue:(NSString*)value;


@end
