//
//  UIView+Category.m
//  Loans
//
//  Created by JZY on 16/6/12.
//  Copyright © 2016年 JZY. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

-(void)createViews{
    self.backgroundColor = ClearColor;
}

-(void)setLeft:(CGFloat)left{
    left = Xpoint(self);
}
-(CGFloat)left{
    return Xpoint(self);
}
-(void)setRight:(CGFloat)right{
    right = ViewEndX(self);
}
-(CGFloat)right{
    return ViewEndX(self);
}
-(void)setTop:(CGFloat)top{
    top = Ypoint(self);
}
-(CGFloat)top{
    return Ypoint(self);
}
-(void)setBottom:(CGFloat)bottom{
    bottom = ViewEndY(self);
}
-(CGFloat)bottom{
    return ViewEndY(self);
}
-(void)setHeight:(CGFloat)height{
    height = ViewHeight(self);
}
-(CGFloat)height{
    return ViewHeight(self);
}
-(void)setWidth:(CGFloat)width{
    width = ViewWidth(self);
}
-(CGFloat)width{
    return ViewWidth(self);
}
-(UIViewController *)viewController{
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(void)setViewController:(UIViewController *)viewController{
    
}

-(void)addTapAction:(SEL )selector Target:(id)target{
    self.userInteractionEnabled = YES;
    for (UIView *next = self; next; next = next.superview) {
        next.userInteractionEnabled = YES;
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
    
}


@end
