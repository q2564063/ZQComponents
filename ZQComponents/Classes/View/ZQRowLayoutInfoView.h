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

//nameLabel的后缀，可自定义view
@property (nonatomic, weak) UIView *nameSuffixView;
//infoLabel的后缀，可自定义view
@property (nonatomic, weak) UIView *infoSuffixView;

//imageView的高，imageView宽高总保持一致
@property (nonatomic, assign) CGFloat imageViewHeight;

@end

NS_ASSUME_NONNULL_END
