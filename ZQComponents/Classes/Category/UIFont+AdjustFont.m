//
//  UIFont+AdjustFont.m
//  Pods-ZQComponents_Example
//
//  Created by zzq on 2020/4/16.
//

#import "UIFont+AdjustFont.h"
#import "ZQDefines.h"

@implementation UIFont (AdjustFont)

+ (UIFont *)adjustFontOfSize:(CGFloat)size{
    CGFloat adjustSize = ZQ_SCREEN_WIDTH / 375 * size;
    return [UIFont systemFontOfSize:adjustSize];
}

@end
