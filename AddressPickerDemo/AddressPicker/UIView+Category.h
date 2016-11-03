//
//  UIView+Category.h
//  Loans
//
//  Created by JZY on 16/6/12.
//  Copyright © 2016年 JZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

@property(nonatomic,assign)CGFloat left;
@property(nonatomic,assign)CGFloat right;
@property(nonatomic,assign)CGFloat top;
@property(nonatomic,assign)CGFloat bottom;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,strong)UIViewController * viewController;

-(void)addTapAction:(SEL )selector Target:(id)target;

-(void)createViews;

@end
