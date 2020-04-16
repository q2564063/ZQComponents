//
//  UIFont+AdjustFont.m
//  Pods-ZQComponents_Example
//
//  Created by zzq on 2020/4/16.
//

#import "UIFont+AdjustFont.h"

#define ZQ_SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define ZQ_SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation UIFont (AdjustFont)

+ (UIFont *)adjustFontOfSize:(CGFloat)size{
    CGFloat adjustSize = ZQ_SCREENWIDTH / 375 * size;
    return [UIFont systemFontOfSize:adjustSize];
}

@end
