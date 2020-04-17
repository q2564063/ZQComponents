//
//  ZQFormView.h
//  ZQComponents_Example
//
//  Created by zzq on 2020/4/17.
//  Copyright © 2020 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZQFormComponent;

@interface ZQFormView : UIScrollView

@property (nonatomic, strong) NSArray<ZQFormComponent *> *formComponentList;

- (void)validateAndGetData:(void(^)(NSDictionary *))dataCallback;

@end

NS_ASSUME_NONNULL_END
