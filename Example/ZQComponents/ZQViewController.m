//
//  ZQViewController.m
//  ZQComponents
//
//  Created by zzq on 04/14/2020.
//  Copyright (c) 2020 zzq. All rights reserved.
//

#import "ZQViewController.h"
#import "UIView+Yoga.h"
#import <ZQComponents/ZQComponents.h>


@interface ZQViewController ()

@property (nonatomic, assign) NSInteger num;

@end

@implementation ZQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView *containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    [containerView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.alignItems = YGAlignCenter;
        layout.paddingTop = YGPointValue(100);
    }];
    [self.view addSubview:containerView];
    
    {
        UILabel *label = [UILabel new];
        label.text = @"ZQRowLayoutInfoView：";
        [label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.alignSelf = YGAlignFlexStart;
            layout.marginBottom = YGPointValue(12);
            layout.marginTop = YGPointValue(20);
        }];
        [containerView addSubview:label];

        ZQRowLayoutInfoView *tView = [[ZQRowLayoutInfoView alloc] init];
        [tView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
        }];
        [containerView addSubview:tView];
        
        UIView *redView = [UIView new];
        redView.backgroundColor = [UIColor redColor];
        [redView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = layout.height = YGPointValue(20);
        }];
        tView.nameSuffixView = redView;
        
        UIView *greenView = [UIView new];
        greenView.backgroundColor = [UIColor greenColor];
        [greenView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = layout.height = YGPointValue(20);
        }];
        tView.infoSuffixView = greenView;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //模拟info为空
            [tView.infoLabel setText:@""];
            
            //模拟name为空
            [tView.nameLabel setText:@""];
        });
    }
    
    {
        UILabel *label = [UILabel new];
        label.text = @"日期选择器：";
        [label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.alignSelf = YGAlignFlexStart;
            layout.marginBottom = YGPointValue(12);
            layout.marginTop = YGPointValue(20);
        }];
        [containerView addSubview:label];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"打开日期选择器" forState:UIControlStateNormal];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ZQDatePicker *picker = [ZQDatePicker new];
            picker.selectedRes = ^(NSString * _Nonnull dateStr) {
                [button setTitle:dateStr forState:UIControlStateNormal];
            };
            [picker show:self.view];
        }];
        [button configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
        }];
        [containerView addSubview:button];
        
    }
    
    {
        UILabel *label = [UILabel new];
        label.text = @"月份选择器：";
        [label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.alignSelf = YGAlignFlexStart;
            layout.marginBottom = YGPointValue(12);
            layout.marginTop = YGPointValue(20);
        }];
        [containerView addSubview:label];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"打开月份选择器" forState:UIControlStateNormal];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ZQMonthPicker *picker = [ZQMonthPicker new];
            picker.selectedRes = ^(NSString * _Nonnull dateStr) {
                [button setTitle:dateStr forState:UIControlStateNormal];
            };
            [picker show:self.view];
        }];
        [button configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
        }];
        [containerView addSubview:button];
        
    }
    
    {
        UILabel *label = [UILabel new];
        label.text = @"年份选择器：";
        [label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.alignSelf = YGAlignFlexStart;
            layout.marginBottom = YGPointValue(12);
            layout.marginTop = YGPointValue(20);
        }];
        [containerView addSubview:label];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"打开年份选择器" forState:UIControlStateNormal];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ZQYearPicker *picker = [ZQYearPicker new];
            picker.selectedRes = ^(NSString * _Nonnull dateStr) {
                [button setTitle:dateStr forState:UIControlStateNormal];
            };
            [picker show:self.view];
        }];
        [button configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
        }];
        [containerView addSubview:button];
        
    }
    
    
    {
        UILabel *label = [UILabel new];
        label.text = @"自定义选择器：";
        [label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.alignSelf = YGAlignFlexStart;
            layout.marginBottom = YGPointValue(12);
            layout.marginTop = YGPointValue(20);
        }];
        [containerView addSubview:label];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"打开自定义选择器" forState:UIControlStateNormal];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSArray *datasource = @[@"自定义1", @"自定义2", @"自定义3", ];
            ZQPickerView *picker = [ZQPickerView new];
            picker.defaultIndex = 1;
            picker.dataSource = datasource;
            picker.selectedRes = ^(NSInteger index) {
                [button setTitle:datasource[index] forState:UIControlStateNormal];
            };
            [picker show:self.view];
        }];
        [button configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
        }];
        [containerView addSubview:button];
        
    }
    
    
    [containerView.yoga applyLayoutPreservingOrigin: YES];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
