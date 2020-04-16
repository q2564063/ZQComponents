//
//  TestView.h
//  Pods-ZQComponents_Example
//
//  Created by zzq on 2020/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQRowLayoutInfoView : UIView


@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *infoLabel;

@property (nonatomic, weak) UIView *nameSuffixView;
@property (nonatomic, weak) UIView *infoSuffixView;

@end

NS_ASSUME_NONNULL_END
