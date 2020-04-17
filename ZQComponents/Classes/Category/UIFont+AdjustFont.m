//
//  UIFont+AdjustFont.m
//  Pods-ZQComponents_Example
//
//  Created by zzq on 2020/4/16.
//

#import "UIFont+AdjustFont.h"
#import "ZQDefines.h"
#import <objc/runtime.h>

@implementation UIFont (AdjustFont)

+ (void)load{
    //获取替换后的类方法
       Method newMethod = class_getClassMethod([self class], @selector(adjustFontOfSize:));
       //获取替换前的类方法
       Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
       //然后交换类方法
       method_exchangeImplementations(newMethod, method);
}

+ (UIFont *)adjustFontOfSize:(CGFloat)size{
    CGFloat adjustSize = [UIScreen mainScreen].bounds.size.width / 375 * size;
    return [UIFont adjustFontOfSize:adjustSize];
}

@end
