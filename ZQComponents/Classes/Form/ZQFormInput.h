//
//  ZQFormInput.h
//  ZQComponents_Example
//
//  Created by zzq on 2020/4/17.
//  Copyright © 2020 zzq. All rights reserved.
//

#import "ZQFormComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZQFormInput : ZQFormComponent

@property (nonatomic, copy) void(^suffixImageTapBlock)(UITapGestureRecognizer *);

@end

NS_ASSUME_NONNULL_END
