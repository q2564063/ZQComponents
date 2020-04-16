//
//  ZQYearPicker.h
//  xinchejie
//
//  Created by ZZQ on 2020/1/10.
//  Copyright © 2020 DaChangAutoGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQYearPicker : UIView

@property (nonatomic, strong) NSString *defaultYear;

@property (nonatomic, copy) void(^selectedRes)(NSString *year);

- (void)show:(UIView *)view;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
