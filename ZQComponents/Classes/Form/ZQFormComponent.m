//
//  ZQFormComponent.m
//  ZQComponents_Example
//
//  Created by zzq on 2020/4/17.
//  Copyright © 2020 zzq. All rights reserved.
//

#import "ZQFormComponent.h"
#import "UIView+Yoga.h"

@implementation ZQFormComponent

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setFormDataModel:(ZQFormDataModel *)formDataModel{
    _formDataModel = formDataModel;
}

@end

@implementation ZQFormDataModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _formWidth = [UIScreen mainScreen].bounds.size.width;
        _labelWidth = 120;
        _label = @"输入内容";
        _placeholder = @"请输入";
        _fontSize = 16;
        _inputTextAlignment = NSTextAlignmentRight;
    }
    return self;
}

@end
