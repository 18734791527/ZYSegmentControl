//
//  CustomSegmentControlBottomView.m
//  CloudDoctor
//
//  Created by wxs on 2017/4/10.
//  Copyright © 2017年 DFIIA. All rights reserved.
//

#import "CustomSegmentControlBottomView.h"

@implementation CustomSegmentControlBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

+ (CustomSegmentControlBottomView *)customSegmentControlBottomViewWithFrame:(CGRect)frame {
    
    return [[self alloc] initWithFrame:frame];
}

- (void)showChildVCViewWithIndex:(NSInteger)index mainVC:(UIViewController *)mainVC {
    
    CGFloat offsetX = index * CGRectGetWidth(self.frame);
    UIViewController *vc = mainVC.childViewControllers[index];
    if (vc.isViewLoaded) return;
    [self addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)setChildViewController:(NSArray <UIViewController *> *)childViewController {
    
    _childViewController = childViewController;
    self.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * childViewController.count, 0);
//    [childViewController enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        CGFloat offsetX = idx * CGRectGetWidth(self.frame);
//        if (obj.isViewLoaded) return;
//        [self addSubview:obj.view];
//        obj.view.frame = CGRectMake(offsetX, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
//    }];
}

@end
