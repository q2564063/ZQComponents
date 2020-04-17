//
//  TestView.m
//  Pods-ZQComponents_Example
//
//  Created by zzq on 2020/4/14.
//

#import "ZQRowLayoutInfoView.h"
#import <YogaKit/UIView+Yoga.h>
#import "ZQDefines.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIFont+AdjustFont.h"

@interface ZQRowLayoutInfoView ()

@property (nonatomic, weak) UIView *nameRowView;
@property (nonatomic, weak) UIView *infoRowView;

@end

@implementation ZQRowLayoutInfoView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _layouUI];
        [self _addObserver];
    }
    return self;
}

- (void)_layouUI{
    [self configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.alignItems = YGAlignStretch;
    }];
    UIImageView *imageView = [UIImageView new];
    imageView.backgroundColor = [UIColor redColor];
    [imageView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.height = YGPointValue(ZQ_FIT(50));
        layout.width = YGPointValue(ZQ_FIT(50));
        layout.marginRight = YGPointValue(ZQ_FIT(8));
    }];
    [self addSubview: imageView];
    
    UIView *columnView = [UIView new];
    [columnView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.justifyContent = YGJustifySpaceAround;
    }];
    [self addSubview:columnView];
    
    UIView *nameRowView = [UIView new];
    [nameRowView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.alignItems = YGAlignCenter;
    }];
    [columnView addSubview:nameRowView];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"我是姓名";
    nameLabel.font = [UIFont adjustFontOfSize:16];
    [nameLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    [nameRowView addSubview:nameLabel];
    
    UIView *infoRowView = [UIView new];
    [infoRowView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.alignItems = YGAlignCenter;
    }];
    [columnView addSubview:infoRowView];
    
    UILabel *infoLabel = [UILabel new];
    infoLabel.text = @"我是信息432424234234234243223423";
    infoLabel.font = [UIFont adjustFontOfSize:12];
    infoLabel.textColor = [UIColor darkGrayColor];
    [infoLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.display = YGDisplayNone;
    }];
    [infoRowView addSubview:infoLabel];
    
    _imageView = imageView;
    _nameLabel = nameLabel;
    _nameRowView = nameRowView;
    _infoLabel = infoLabel;
    _infoRowView = infoRowView;
    
    [self.yoga applyLayoutPreservingOrigin:YES];
}

- (void)_addObserver{
    @weakify(self)
    [RACObserve(self.nameLabel, text) subscribeNext:^(id  _Nullable x) {
        [self.nameLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.display =  [x length] > 0 ? YGDisplayFlex : YGDisplayNone;
        }];
        [self.nameRowView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.display =  [x length] > 0 || self.nameSuffixView ? YGDisplayFlex : YGDisplayNone;
        }];
        [self.yoga applyLayoutPreservingOrigin:YES];
    }];
    
    [RACObserve(self.infoLabel, text) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.infoLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.display =  [x length] > 0 ? YGDisplayFlex : YGDisplayNone;
        }];
        [self.infoRowView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.display =  [x length] > 0 || self.infoSuffixView ? YGDisplayFlex : YGDisplayNone;
        }];
        [self.yoga applyLayoutPreservingOrigin:YES];
    }];
}

- (void)setNameSuffixView:(UIView *)nameSuffixView{
    _nameSuffixView = nameSuffixView;
    if (nameSuffixView) {
        [_nameRowView addSubview:nameSuffixView];
        [self.yoga applyLayoutPreservingOrigin:YES];
    }
}

- (void)setInfoSuffixView:(UIView *)infoSuffixView{
    _infoSuffixView = infoSuffixView;
    if (infoSuffixView) {
        [_infoRowView addSubview:infoSuffixView];
        [self.yoga applyLayoutPreservingOrigin:YES];
    }
}

- (void)setImageViewHeight:(CGFloat)imageViewHeight{
    _imageViewHeight = imageViewHeight;
    
    [self.imageView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = layout.height = YGPointValue(imageViewHeight);
    }];
}


@end
