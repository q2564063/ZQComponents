//
//  ZQPickerView.h
//  xinchejie
//
//  Created by ZZQ on 2020/1/10.
//  Copyright © 2020 DaChangAutoGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQPickerView : UIView

@property (nonatomic, strong) NSArray *dataSource;


@property (nonatomic, assign) NSInteger defaultIndex;


@property (nonatomic, copy) void(^selectedRes)(NSInteger index);

- (void)show:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
