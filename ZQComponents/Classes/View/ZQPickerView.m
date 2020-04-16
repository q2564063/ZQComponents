//
//  ZQDatePicker.m
//  新车界
//
//  Created by ZZQ on 2019/10/29.
//  Copyright © 2019 DaChangAutoGroup. All rights reserved.
//

#import "ZQPickerView.h"
#import <YogaKit/UIView+Yoga.h>
#import "ZQDefines.h"

@interface ZQPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *picker;

@end

@implementation ZQPickerView

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
    label.text = @"请选择";
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.dataSource.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.dataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

- (void)handleCancelAction:(UIButton *)sender{
    
    [self hide];
}

- (void)handleConfirmAction:(UIButton *)sender{
    NSInteger index = [self.picker selectedRowInComponent:0];
    [self hide];
    if (_selectedRes) {
        _selectedRes(index);
    }
}

- (void)show:(UIView *)view{
    [_picker selectRow:_defaultIndex inComponent:0 animated:NO];
    [_picker reloadAllComponents];
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
