//
//  CustomSegmentControlBottomView.h
//  CloudDoctor
//
//  Created by wxs on 2017/4/10.
//  Copyright © 2017年 DFIIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSegmentControlBottomView : UIScrollView

@property (strong, nonatomic) NSArray <UIViewController *> *childViewController;

- (instancetype)initWithFrame:(CGRect)frame;

+ (CustomSegmentControlBottomView *)customSegmentControlBottomViewWithFrame:(CGRect)frame;

/**
 *  展示对应下标的对应子控制器的view
 *  @param index     子控制器的下标
 *  @param mainVC    主控制器
 */
- (void)showChildVCViewWithIndex:(NSInteger)index mainVC:(UIViewController *)mainVC;

@end
