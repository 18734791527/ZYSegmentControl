//
//  CustomSegmentControl.h
//  CustomSegmentControl
//
//  Created by wxs on 2017/3/8.
//  Copyright © 2017年 DFIIA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomSegmentControl;

typedef NS_ENUM(NSUInteger, StyleType) {
    
    StyleTypeLine,
    StyleTypeRoundedCorners
};

@protocol CustomSegmentControlDelegate <NSObject>

@required
- (void)didClickSegmentedControl:(NSUInteger)selectedIndex;

@end

@interface CustomSegmentControl : UIView

@property (assign, nonatomic) id <CustomSegmentControlDelegate> delegate;

/**
 初始化

 @param frame 大小
 @param items 标签数组
 @param styleType 指示器类型
 @param arrayColor 颜色数组 titleColor selectTitleColor underlineColor指示器颜色
 @return CustomSegmentControl
 */
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *> *)items styleType:(StyleType)styleType arrayColor:(NSArray <UIColor *> *)arrayColor;

/**
 类方法

 @param frame 大小
 @param items 标签数组
 @param styleType 指示器类型
 @param arrayColor 颜色数组 titleColor selectTitleColor underlineColor指示器颜色
 @return CustomSegmentControl
 */
+ (instancetype)customSegmentControlWithFrame:(CGRect)frame items:(NSArray <NSString *> *)items styleType:(StyleType)styleType arrayColor:(NSArray <UIColor *> *)arrayColor;

/**
 选中的按钮
 */
@property (assign, nonatomic) NSUInteger selectedSegmentIndex;

@property (assign, nonatomic) CGFloat offsetX;

@end
