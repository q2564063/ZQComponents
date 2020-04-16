//
//  ZQDatePicker.m
//  新车界
//
//  Created by ZZQ on 2019/10/29.
//  Copyright © 2019 DaChangAutoGroup. All rights reserved.
//

#import "ZQMonthPicker.h"
#import <YogaKit/UIView+Yoga.h>
#import "ZQDefines.h"

@interface ZQMonthPicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *yearArr;
@property (nonatomic, strong) NSArray *monthArr;
@property (nonatomic, strong) UIPickerView *picker;

@end

@implementation ZQMonthPicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSArray *)yearArr{
    if (!_yearArr) {
        NSInteger curYear = [[self getCurrentDateWithFormat:@"yyyy"] integerValue];
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < curYear + 2 - 2018; i++) {
            [arr addObject: [NSString stringWithFormat:@"%d年", 2018 + i]];
        }
        _yearArr = [NSArray arrayWithArray:arr];
    }
    return _yearArr;
}

- (NSArray *)monthArr{
    if (!_monthArr) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 1; i < 13; i++) {
            if (_seasonType && (i-1)%3==0) {//1,4,7,10
                [arr addObject: [NSString stringWithFormat:@"%@%d月",i<10?@"0":@"", i]];
            }else if(!_seasonType){
                [arr addObject: [NSString stringWithFormat:@"%@%d月",i<10?@"0":@"", i]];
            }
            
        }
        _monthArr = [NSArray arrayWithArray:arr];
    }
    return _monthArr;
}

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, ZQ_SCREEN_WIDTH, ZQ_SCREEN_HEIGHT)];
    if (self) {
        _defaultYear = [self getCurrentDateWithFormat:@"yyyy"];
        _defaultMonth = [self getCurrentDateWithFormat:@"MM"];
        [self initMethod];
    }
    return self;
}

- (void)initMethod{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
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
    label.text = @"选择月份";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    [label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flex = 1;
    }];
    [headerView addSubview:label];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(handleConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(60);
        layout.height = YGPointValue(44);
    }];
    [headerView addSubview:confirmButton];
    
    
    _picker = [[UIPickerView alloc] init];
    _picker.delegate = self;
    _picker.dataSource = self;
    [_picker configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(ZQ_SCREEN_WIDTH);
        layout.flex = 1;
    }];
    [view addSubview:_picker];
    
    [self.yoga applyLayoutPreservingOrigin:YES];
}

- (NSString *)getCurrentDateWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    NSDate *curDate = [NSDate date];
    return [formatter stringFromDate: curDate];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.yearArr.count;
    }else{
        return self.monthArr.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.yearArr[row];
    }else{
        return self.monthArr[row];
    }
}
 
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (_minDate){
        NSString *minYear = [NSString stringWithFormat:@"%@年", [_minDate substringToIndex:4]];
        NSString *minMonth = [NSString stringWithFormat:@"%@月", [_minDate substringFromIndex:5]];
        NSUInteger indexYear = [self.yearArr indexOfObject:minYear];
        NSUInteger indexMonth = [self.monthArr indexOfObject:minMonth];
        if (component == 0) {
            if (indexYear >= 0) {
                NSInteger mRow = [pickerView selectedRowInComponent:1];
                if (row < indexYear) {
                    [pickerView selectRow:indexYear inComponent:0 animated:YES];
                    [self pickerView:pickerView didSelectRow:indexYear inComponent:0];
                }else if (row == indexYear && mRow < indexMonth){
                    [pickerView selectRow:indexMonth inComponent:1 animated:YES];
                }
            }
        }else if (component == 1){
            NSInteger yRow = [pickerView selectedRowInComponent:0];
            if (yRow <= indexYear && indexMonth >= 0 && row < indexMonth) {
                [pickerView selectRow:indexMonth inComponent:1 animated:YES];
            }
        }
    }
    if (_maxDate){
        NSString *maxYear = [NSString stringWithFormat:@"%@年", [_maxDate substringToIndex:4]];
        NSString *maxMonth = [NSString stringWithFormat:@"%@月", [_maxDate substringFromIndex:5]];
        NSUInteger indexYear = [self.yearArr indexOfObject:maxYear];
        NSUInteger indexMonth = [self.monthArr indexOfObject:maxMonth];
        if (component == 0) {
            if (indexYear >= 0) {
                NSInteger mRow = [pickerView selectedRowInComponent:1];
                if (row > indexYear) {
                    [pickerView selectRow:indexYear inComponent:0 animated:YES];
                    [self pickerView:pickerView didSelectRow:indexYear inComponent:0];
                }else if (row == indexYear && mRow > indexMonth){
                    [pickerView selectRow:indexMonth inComponent:1 animated:YES];
                }
            }
        }else if (component == 1){
            NSInteger yRow = [pickerView selectedRowInComponent:0];
            if (yRow >= indexYear && indexMonth >= 0 && row > indexMonth) {
                [pickerView selectRow:indexMonth inComponent:1 animated:YES];
            }
        }
    }
}

- (void)handleCancelAction:(UIButton *)sender{
    
    [self hide];
}

- (void)handleConfirmAction:(UIButton *)sender{
    NSString *year = self.yearArr[[self.picker selectedRowInComponent:0]];
    NSString *month = self.monthArr[[self.picker selectedRowInComponent:1]];
    [self hide];
    if (_selectedRes) {
        NSString *yearMonth = [NSString stringWithFormat:@"%@-%@", [year stringByReplacingOccurrencesOfString:@"年" withString:@""], [month stringByReplacingOccurrencesOfString:@"月" withString:@""]];
        _selectedRes(yearMonth);
    }
}

- (void)show:(UIView *)view{
    _monthArr = nil;
    [self.picker reloadAllComponents];
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.picker.superview.transform = CGAffineTransformMakeTranslation(0, -300);
        self.alpha = 1;
    }];
    NSInteger row1 = 0;
    NSInteger row2 = 0;
    if (_defaultYear &&  [self.yearArr containsObject:[NSString stringWithFormat:@"%@年", _defaultYear]]) {
        row1 = [self.yearArr indexOfObject:[NSString stringWithFormat:@"%@年", _defaultYear]];
    }
    [_picker selectRow:row1 inComponent:0 animated:NO];
    
    if (_defaultMonth && [self.monthArr containsObject:[NSString stringWithFormat:@"%@月", _defaultMonth]]) {
        row2 = [self.monthArr indexOfObject:[NSString stringWithFormat:@"%@月", _defaultMonth]];
    }
    [_picker selectRow:row2 inComponent:1 animated:NO];
    
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
