//
//  ZQDatePicker.h
//  新车界
//
//  Created by ZZQ on 2019/10/29.
//  Copyright © 2019 DaChangAutoGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQMonthPicker : UIView

@property (nonatomic, strong) NSString *defaultYear;//格式：2019
@property (nonatomic, strong) NSString *defaultMonth;//格式09
@property (nonatomic, strong) NSString *minDate;//格式：2019-09
@property (nonatomic, strong) NSString *maxDate;//格式：2020-09

//是否按季度选择，只显示和选择：1，4，7，10月
@property (nonatomic, assign) BOOL seasonType;

@property (nonatomic, copy) void(^selectedRes)(NSString *yearMonth);

- (void)show:(UIView *)view;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
