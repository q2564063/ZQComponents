//
//  ZQFormViewController.m
//  ZQComponents_Example
//
//  Created by zzq on 2020/4/17.
//  Copyright © 2020 zzq. All rights reserved.
//

#import "ZQFormViewController.h"
#import "ZQComponents.h"

@interface ZQFormViewController ()

@end

@implementation ZQFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    [containerView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
    }];
    [self.view addSubview:containerView];
    
    
    
    ZQFormView *formView = [[ZQFormView alloc] init];
    [formView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    formView.formComponentList = [self _createFormComponents];
    [containerView addSubview:formView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"获取数据" forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [formView validateAndGetData:^(NSDictionary * _Nonnull json) {
            NSLog(@"%@", json);
        }];
    }];
    [button configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    [containerView addSubview:button];
    
    
    [containerView.yoga applyLayoutPreservingOrigin:YES];
}

- (NSArray *)_createFormComponents{
    NSMutableArray *arr = [NSMutableArray array];
    {
        ZQFormDataModel *dataModel = [ZQFormDataModel new];
        dataModel.labelWidth = 100;
        dataModel.required = NO;
        dataModel.label = @"测试标题1";
        dataModel.key = @"one";
        dataModel.value = @"456";
        dataModel.suffixImageName = @"image";
        UIView *view1 = [[UIView alloc] init];
        [view1 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = layout.height = YGPointValue(30);
        }];
        view1.backgroundColor = [UIColor cyanColor];
        dataModel.suffixView = view1;
        
        ZQFormInput *input = [ZQFormInput new];
        input.formDataModel = dataModel;
        input.suffixImageTapBlock = ^(UITapGestureRecognizer * _Nonnull tap) {
            NSLog(@"123");
            dataModel.value = @"888";
        };
        
        [arr addObject:input];
    }
    
    {
        ZQFormDataModel *dataModel = [ZQFormDataModel new];
        dataModel.labelWidth = 100;
        dataModel.required = YES;
        dataModel.label = @"测试标题2";
        dataModel.key = @"two";
        dataModel.value = @"2222";
        dataModel.suffixImageName = @"image";
        
        ZQFormInput *input = [ZQFormInput new];
        input.formDataModel = dataModel;
        input.suffixImageTapBlock = ^(UITapGestureRecognizer * _Nonnull tap) {
            NSLog(@"123");
            dataModel.value = @"888";
        };
        
        [arr addObject:input];
    }
    
    return arr;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
