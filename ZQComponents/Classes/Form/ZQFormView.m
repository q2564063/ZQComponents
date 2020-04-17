//
//  ZQFormView.m
//  ZQComponents_Example
//
//  Created by zzq on 2020/4/17.
//  Copyright © 2020 zzq. All rights reserved.
//

#import "ZQFormView.h"
#import "UIView+Yoga.h"
#import "ZQFormInput.h"

@implementation ZQFormView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        [self _layoutUI];
//    }
//    return self;
//}

- (void)_layoutUI{
    
    [self configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.alignItems = YGAlignStretch;
    }];
    
    UIView *contentView = [UIView new];
    [contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.alignItems = YGAlignStretch;
    }];
    [self addSubview:contentView];
    
    for (ZQFormComponent *component in _formComponentList) {
        [contentView addSubview:(UIView *)component];
    }
    
    [self.yoga applyLayoutPreservingOrigin:YES];
    
    self.contentSize = contentView.frame.size;
    
}

- (void)setFormComponentList:(NSArray<ZQFormComponent *> *)formComponentList{
    _formComponentList = formComponentList;
    
    [self _layoutUI];
}

- (void)validateAndGetData:(void (^)(NSDictionary * _Nonnull))dataCallback{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    for (ZQFormComponent *component in _formComponentList) {
        for (int i = 0; i < 4; i++) {
            NSString *k_key = i == 0 ? @"key" : [NSString stringWithFormat:@"key%d", i+1];
            NSString *k_value = [component.formDataModel valueForKeyPath: k_key];
            
            NSString *v_key = i == 0 ? @"value" : [NSString stringWithFormat:@"value%d", i+1];
            NSString *v_value = [component.formDataModel valueForKeyPath: v_key];
            
            if (k_value && v_value) {
                [data setObject:v_value forKey:k_value];
            }
        }
    }
    if (dataCallback) {
        dataCallback(data);
    }
}



@end
