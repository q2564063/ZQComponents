//
//  ZQDatePicker.h
//  xinchejie
//
//  Created by ZZQ on 2019/12/26.
//  Copyright © 2019 DaChangAutoGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQDatePicker : UIView

//最小日期：格式 2019-09-01
@property (nonatomic, strong, nullable) NSString *minDate;
//日期格式，默认：年月日
@property (nonatomic, assign) UIDatePickerMode datePickerMode;

//定义已选择日期格式，默认：yyyy-MM-dd
@property (nonatomic, strong) NSString *resFormat;
//已选择日期回调
@property (nonatomic, copy) void(^selectedRes)(NSString *dateStr);


- (void)show:(UIView *)view;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
