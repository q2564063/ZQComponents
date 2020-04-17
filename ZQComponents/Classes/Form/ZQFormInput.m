//
//  ZQFormInput.m
//  ZQComponents_Example
//
//  Created by zzq on 2020/4/17.
//  Copyright © 2020 zzq. All rights reserved.
//

#import "ZQFormInput.h"
#import "UIView+Yoga.h"
#import "ReactiveObjC.h"
#import "ZQDefines.h"

@implementation ZQFormInput

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)_layoutUI{
    __weak typeof(self) weakSelf = self;
    [self configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;

        layout.flexDirection = YGFlexDirectionRow;
        layout.alignItems = YGAlignStretch;
        layout.paddingHorizontal = YGPointValue(ZQ_FIT(12));
        layout.paddingVertical = YGPointValue(ZQ_FIT(8));
    }];
    
    
    UILabel *requiredLabel = [UILabel new];
    requiredLabel.text = self.formDataModel.required ? @"*" : @" ";
    requiredLabel.textColor = [UIColor redColor];
    requiredLabel.textAlignment = NSTextAlignmentCenter;
    [requiredLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginRight = YGPointValue(ZQ_FIT(4));
        layout.width = YGPointValue(ZQ_FIT(12));
    }];
    [self addSubview:requiredLabel];
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    [label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(weakSelf.formDataModel.labelWidth);
        layout.marginRight = YGPointValue(ZQ_FIT(8));
    }];
    [self addSubview:label];
    
    UITextField *textField = [UITextField new];
    textField.textAlignment = self.formDataModel.inputTextAlignment;
    [textField configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flex = 1;
        layout.alignSelf = YGAlignStretch;
    }];
    [self addSubview:textField];
    
    
    UIView *suffixView = [UIView new];
    suffixView.backgroundColor = [UIColor yellowColor];
    [suffixView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRowReverse;
        layout.justifyContent = YGJustifyFlexEnd;
        layout.alignItems = YGAlignCenter;
        layout.height = YGPercentValue(100);
        layout.marginLeft = YGPointValue(ZQ_FIT(8));
    }];
    [self addSubview:suffixView];
    
    UIImageView *suffixImageView = [UIImageView new];
    suffixImageView.backgroundColor = [UIColor redColor];
    suffixImageView.userInteractionEnabled = YES;
    [suffixImageView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = layout.height = YGPointValue(ZQ_FIT(20));
        layout.display = weakSelf.formDataModel.suffixImageName ? YGDisplayFlex : YGDisplayNone;
    }];
    [suffixView addSubview:suffixImageView];
    
    
    @weakify(self)
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    [suffixImageView addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        if (self.suffixImageTapBlock) {
            self.suffixImageTapBlock(x);
        }
    }];
    
    if (self.formDataModel.suffixView) {
        [suffixView addSubview:self.formDataModel.suffixView];
    }
    
    
    [RACObserve(self.formDataModel, required) subscribeNext:^(id  _Nullable x) {
        requiredLabel.text = [x integerValue] == 0 ? @" " : @"*";
    }];
    
    [RACObserve(self.formDataModel, fontSize) subscribeNext:^(id  _Nullable x) {
        label.font = [UIFont systemFontOfSize:[x doubleValue]];
        textField.font = [UIFont systemFontOfSize:[x doubleValue]];
    }];
    
    [RACObserve(self.formDataModel, labelWidth) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = YGPointValue([x doubleValue]);
        }];
        [self.yoga applyLayoutPreservingOrigin:YES];
    }];
    
    [RACObserve(self.formDataModel, label) subscribeNext:^(id  _Nullable x) {
        label.text = x;
    }];
    
    RAC(textField, text) = RACObserve(self.formDataModel, value);
    [textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self.formDataModel.value = x;
    }];
    
    [RACObserve(self.formDataModel, placeholder) subscribeNext:^(id  _Nullable x) {
        textField.placeholder = x;
    }];

}

- (void)setFormDataModel:(ZQFormDataModel *)formDataModel{
    [super setFormDataModel:formDataModel];
    
    [self _layoutUI];
    [self.yoga applyLayoutPreservingOrigin:YES];
}


@end
