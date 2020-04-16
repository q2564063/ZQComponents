//
//  ZQDatePicker.m
//  xinchejie
//
//  Created by ZZQ on 2019/12/26.
//  Copyright © 2019 DaChangAutoGroup. All rights reserved.
//

#import "ZQDatePicker.h"
#import <YogaKit/UIView+Yoga.h>
#import "ZQDefines.h"

@interface ZQDatePicker ()

@property (nonatomic, strong) NSString *currentDateStr;
@property (nonatomic, strong) UIDatePicker *picker;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZQDatePicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, ZQ_SCREEN_WIDTH, ZQ_SCREEN_HEIGHT)];
    if (self) {
        [self initMethod];
    }
    return self;
}

- (void)initMethod{
    
    _datePickerMode = UIDatePickerModeDate;
    _resFormat = @"yyyy-MM-dd";
    
    [self configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
    }];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
    UIView *tapView = [[UIView alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [tapView addGestureRecognizer:tap];
    [tapView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.height = YGPointValue(ZQ_SCREEN_HEIGHT);
        layout.width = YGPointValue(ZQ_SCREEN_WIDTH);
    }];
    [self addSubview:tapView];

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(ZQ_SCREEN_WIDTH);
        layout.height = YGPointValue(300);
        layout.flexDirection = YGFlexDirectionColumn;
    }];
    [self addSubview:view];
    
    
    UIView *headerView = [UIView new];
    [headerView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(ZQ_SCREEN_WIDTH);
        layout.flexDirection = YGFlexDirectionRow;
        layout.alignItems = YGAlignCenter;
        layout.paddingHorizontal = YGPointValue(12);
        layout.paddingVertical = YGPointValue(8);
    }];
    [view addSubview:headerView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.tintColor = [UIColor redColor];
    [cancelButton addTarget:self action:@selector(handleCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(60);
        layout.height = YGPointValue(44);
    }];
    [headerView addSubview:cancelButton];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"选择日期";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    [label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flex = 1;
    }];
    [headerView addSubview:label];
    _titleLabel = label;
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(handleConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(60);
        layout.height = YGPointValue(44);
    }];
    [headerView addSubview:confirmButton];
    
    _picker = [[UIDatePicker alloc] init];
    _picker.datePickerMode = _datePickerMode;
    [_picker addTarget:self action:@selector(handlePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_picker configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(ZQ_SCREEN_WIDTH);
        layout.flex = 1;
    }];
    [view addSubview:_picker];
    
    [self handlePickerValueChanged:_picker];
    
    
    [self.yoga applyLayoutPreservingOrigin:YES];
    
}

- (void)setMinDate:(NSString *)minDate{
    _minDate = minDate;
    if (minDate) {
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd";
        _picker.minimumDate = [formatter dateFromString:minDate];
           //设置日期的显示格式
           formatter.dateFormat = _resFormat;

           //将日期转为指定格式显示
           _currentDateStr = [formatter stringFromDate: _picker.minimumDate ];

           formatter.dateFormat = @"EEEE";
           NSString *week = [formatter stringFromDate: _picker.minimumDate ];
           _titleLabel.text = week;
    }else{
        _picker.minimumDate = nil;
    }
    
}

- (void)handlePickerValueChanged:(UIDatePicker *)picker{
    //创建一个日期格式

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期的显示格式
    fmt.dateFormat = _resFormat;

    //将日期转为指定格式显示
    _currentDateStr = [fmt stringFromDate:picker.date];
    
    //显示星期
    fmt.dateFormat = @"EEEE";
    NSString *week = [fmt stringFromDate:picker.date];
    _titleLabel.text = week;
}

- (void)handleCancelAction:(UIButton *)sender{
    [self hide];
}

- (void)handleConfirmAction:(UIButton *)sender{

    [self hide];
    if (_selectedRes) {
        _selectedRes(_currentDateStr);
    }
}

- (void)show:(UIView *)view{
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.picker.superview.transform = CGAffineTransformMakeTranslation(0, -300);
        self.alpha = 1;
    }];
    
    [view addSubview:self];
}

- (void)hide{
    [UIView animateWithDuration:0.25 animations:^{
        self.picker.superview.transform = CGAffineTransformMakeTranslation(0, 300);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
