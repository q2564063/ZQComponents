//
//  ZQFormComponent.h
//  ZQComponents_Example
//
//  Created by zzq on 2020/4/17.
//  Copyright © 2020 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZQFormDataModel;
@interface ZQFormComponent : UIView


@property (nonatomic, strong) ZQFormDataModel *formDataModel;

@end


@interface ZQFormDataModel : NSObject

@property (nonatomic, assign) CGFloat formWidth;

@property (nonatomic, assign) CGFloat labelWidth;

@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, assign) BOOL required;

@property (nonatomic, strong) NSString *label;

@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, assign) BOOL validateError;

@property (nonatomic, strong) NSString *errorInfo;

@property (nonatomic, strong) NSString *suffixImageName;

@property (nonatomic, strong) UIView *suffixView;

@property (nonatomic, assign) NSTextAlignment inputTextAlignment;


@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) NSString *key1;
@property (nonatomic, strong) NSString *value1;

@property (nonatomic, strong) NSString *key2;
@property (nonatomic, strong) NSString *value2;

@property (nonatomic, strong) NSString *key3;
@property (nonatomic, strong) NSString *value3;

@property (nonatomic, strong) NSString *key4;
@property (nonatomic, strong) NSString *value4;

@end

NS_ASSUME_NONNULL_END
