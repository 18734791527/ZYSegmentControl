//
//  ViewController.m
//  ZYSegmentControl
//
//  Created by 赵言 on 2018/6/3.
//  Copyright © 2018年 赵言. All rights reserved.
//

#import "ViewController.h"

#import "CustomSegmentControl.h"
#import "CustomSegmentControlBottomView.h"

#import "FirstViewController.h"
#import "SecondViewController.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kColor(R,G,B,A) [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
#define kNavcBarTintColor [UIColor colorWithRed:37.0f/255.f green:107.0f/255.f blue:169.0f/255.f alpha:1.0f]
#define kColorHex(s) [UIColor colorWithRed:((s & 0xFF0000) >> 16)/255.f green:((s & 0xFF00) >> 8)/255.f blue:((s & 0xFF))/255.f alpha:1.0]

@interface ViewController () <UIScrollViewDelegate, CustomSegmentControlDelegate>

@property (strong, nonatomic) CustomSegmentControl *segmentC;
@property (strong, nonatomic) CustomSegmentControlBottomView *segmentCBV;

@property (strong, nonatomic) FirstViewController  *firstVC;
@property (strong, nonatomic) SecondViewController  *secondVC;

@end

@implementation ViewController
#pragma mark - CustomSegmentControlDelegate
- (void)didClickSegmentedControl:(NSUInteger)selectedIndex {

    CGFloat offsetX = selectedIndex * kScreenWidth;
    [self.segmentCBV setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    [self.segmentCBV showChildVCViewWithIndex:selectedIndex mainVC:self];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.segmentCBV) {
        
        CGFloat offsetX = scrollView.contentOffset.x;
        CGFloat width = scrollView.frame.size.width;
        self.segmentC.offsetX = offsetX;
        if (fmod(offsetX, width) == 0) {
            
            // 计算滚动到哪一页
            NSInteger index = offsetX / width;
            // 1.添加子控制器view
            [self.segmentCBV showChildVCViewWithIndex:index mainVC:self];
            // 2.把对应的标题选中
            self.segmentC.selectedSegmentIndex = index;
        }
    }
}

#pragma mark - 视图的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.segmentC];
    self.segmentCBV.childViewController = @[self.firstVC, self.secondVC];
    [self.segmentCBV addSubview:self.firstVC.view];
    [self.view addSubview:self.segmentCBV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
- (CustomSegmentControlBottomView *)segmentCBV {
    
    if (!_segmentCBV) {
        
        _segmentCBV = [[CustomSegmentControlBottomView alloc] initWithFrame:CGRectMake(0, 64.f+50.f, kScreenWidth, kScreenHeight - 64.f-50.f)];
        _segmentCBV.delegate = self;
        _segmentCBV.backgroundColor = [UIColor clearColor];
    }
    return _segmentCBV;
}

- (CustomSegmentControl *)segmentC {
    
    if (!_segmentC) {
        
        _segmentC = [[CustomSegmentControl alloc] initWithFrame:CGRectMake(0, 64.f, kScreenWidth, 50.f) items:@[@"first", @"second"] styleType:(StyleTypeLine) arrayColor:@[kColorHex(0x666666), kNavcBarTintColor, kNavcBarTintColor]];
        _segmentC.backgroundColor = [UIColor whiteColor];
        _segmentC.delegate = self;
    }
    return _segmentC;
}

-  (FirstViewController *)firstVC {
    
    if (!_firstVC) {
        
        _firstVC = [[FirstViewController alloc] init];
        [self addChildViewController:_firstVC];
        [_firstVC didMoveToParentViewController:self];
        _firstVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.segmentCBV.frame), CGRectGetHeight(self.segmentCBV.frame));
    }
    return _firstVC;
}

- (SecondViewController *)secondVC {
    
    if (!_secondVC) {
        
        _secondVC = [[SecondViewController alloc] init];
        [self addChildViewController:_secondVC];
        [_secondVC didMoveToParentViewController:self];
    }
    return _secondVC;
}

@end
