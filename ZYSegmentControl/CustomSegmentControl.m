//
//  CustomSegmentControl.m
//  CustomSegmentControl
//
//  Created by wxs on 2017/3/8.
//  Copyright © 2017年 DFIIA. All rights reserved.
//

#import "CustomSegmentControl.h"

@interface CustomSegmentControl ()

/**
 存放所有按钮
 */
@property (strong, nonatomic) NSMutableArray <UIButton *> *storageAllBtn;

@property (strong, nonatomic) UIButton *tempBtn;

@property (assign, nonatomic) CGFloat widthBtn;    //按钮宽度

@property (strong, nonatomic) UIView *underline;

@property (assign, nonatomic) StyleType styleType;

/**
 按钮颜色
 */
@property (strong, nonatomic) UIColor *btnTitleColor;

/**
 选中颜色
 */
@property (strong, nonatomic) UIColor *btnSelectedColor;

@property (assign, nonatomic) BOOL isPerformAnimation;

@end

static const NSUInteger BtnTag = 1000;
static const NSUInteger BtnTitleFont = 15;
static const CGFloat AnimateDuration = 0.2;
//static const NSUInteger AddWidth = 5;  //下划线的宽

@implementation CustomSegmentControl

@synthesize selectedSegmentIndex = _selectedSegmentIndex, offsetX = _offsetX;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *> *)items styleType:(StyleType)styleType arrayColor:(NSArray <UIColor *> *)arrayColor {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.styleType = styleType;
        self.btnTitleColor = arrayColor[0];
        self.btnSelectedColor = arrayColor[1];
        NSUInteger number = items.count;
        _widthBtn = frame.size.width / number;
        CGFloat height = frame.size.height;
        for (NSUInteger i = 0; i < number; i++) {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * _widthBtn, 0, _widthBtn , height)];
            view.backgroundColor = [UIColor clearColor];
            [self addSubview:view];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            CGSize btnSize = [items[i] sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:BtnTitleFont]}];
//            bu.titleLabel.adjustsFontSizeToFitWidth = YES;//调整字体大小适应宽度
//            btn.frame = CGRectMake(i * _widthBtn, 0, _widthBtn , height);
            btn.tag = i + BtnTag;
            [btn setTitle:items[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:BtnTitleFont];
            btn.titleLabel.numberOfLines = 0;
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            CGRect rect = btn.titleLabel.frame;
            rect.size.width = _widthBtn;// * 9 / 10;
            btn.titleLabel.frame = rect;
            [btn setTitleColor:self.btnTitleColor forState:UIControlStateNormal];
            [btn setTitleColor:self.btnSelectedColor forState:UIControlStateSelected];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            //btn.intrinsicContentSize.width > _widthBtn ? _widthBtn : btn.intrinsicContentSize.width
            btn.frame = CGRectMake(0, 0, _widthBtn, btn.intrinsicContentSize.height);
            [self addSubview:btn];
            btn.center = view.center;
            [self.storageAllBtn addObject:btn];
        }
        if (styleType == StyleTypeLine) {
            
//            CGFloat underlineWidth = [items[0] boundingRectWithSize:CGSizeMake(MAXFLOAT, _widthBtn) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:BtnTitleFont]} context:nil].size.width + AddWidth;
//            _underline = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1, underlineWidth < _widthBtn ? underlineWidth : _widthBtn, 1)];
            _underline = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1, _widthBtn, 1)];
            [self addSubview:_underline];
            CGPoint point = _underline.center;
            point.x = _widthBtn/2;
            _underline.center = point;
        }
        else {
            
            _underline = [[UIView alloc] initWithFrame:CGRectMake(0, (height - height/3) / 2, _widthBtn, height * 3 / 4)];
            _underline.layer.cornerRadius = 5.f;
            [self addSubview:_underline];
            [self sendSubviewToBack:_underline];
            _underline.center = ((UIButton *)self.storageAllBtn[0]).center;
        }
        _underline.backgroundColor = arrayColor[2];
        self.selectedSegmentIndex = 0;
    }
    return self;
}

+ (instancetype)customSegmentControlWithFrame:(CGRect)frame items:(NSArray <NSString *> *)items styleType:(StyleType)styleType arrayColor:(NSArray <UIColor *> *)arrayColor {
    
    return [[self alloc] initWithFrame:frame items:items styleType:styleType arrayColor:arrayColor];
}

#pragma mark - btnAction
- (void)btnAction:(UIButton *)sender {
    
    NSUInteger index = sender.tag - BtnTag;
    if ([self.delegate respondsToSelector:@selector(didClickSegmentedControl:)]) {
        
        [self.delegate didClickSegmentedControl:index];
    }
    [self selectedBtn:sender];
}

/**
 选中按钮

 @param sender 按钮
 */
- (void)selectedBtn:(UIButton *)sender {
    
    if (_isPerformAnimation) {
        
        return;
    }
    _isPerformAnimation = YES;
    if (_tempBtn == nil) {
        
        sender.selected = YES;
        _tempBtn = sender;
    }
    else if (_tempBtn == sender) {  //_tempBtn != nil &&
        
        sender.selected = YES;
    }
    else {  // if (_tempBtn != nil && _tempBtn != sender)
        
        _tempBtn.selected = NO;
        sender.selected = YES;
        _tempBtn = sender;
    }
    
    CGFloat width;
    if (self.styleType == StyleTypeLine) {
        
//        width = [sender.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, sender.frame.size.width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:BtnTitleFont]} context:nil].size.width + AddWidth;
//        width = width < _widthBtn ? width : _widthBtn;
        width = _widthBtn;
    }
    else {
        
        width = CGRectGetWidth(_underline.frame);
    }
    [UIView animateWithDuration:AnimateDuration animations:^{
        
        CGRect rect = _underline.frame;
        rect.size.width = width;
        _underline.frame = rect;
        CGPoint point = _underline.center;
        point.x = sender.center.x;
        _underline.center = point;
    } completion:^(BOOL finished) {
        
        _isPerformAnimation = NO;
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)storageAllBtn {
    
    if (!_storageAllBtn) {
        
        _storageAllBtn = [NSMutableArray array];
    }
    return _storageAllBtn;
}

- (void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex {
    
    _selectedSegmentIndex = selectedSegmentIndex;
    [self selectedBtn:self.storageAllBtn[selectedSegmentIndex]];
}

- (NSUInteger)selectedSegmentIndex {
    
    return _selectedSegmentIndex;
}

- (void)setOffsetX:(CGFloat)offsetX {
    
    _offsetX = offsetX;
    CGFloat width;
    if (self.styleType == StyleTypeLine) {
        
        width = _widthBtn;
    }
    else {
        
        width = CGRectGetWidth(_underline.frame);
    }
    [UIView animateWithDuration:AnimateDuration animations:^{
        
        CGRect rect = _underline.frame;
        rect.size.width = width;
        _underline.frame = rect;
        
        CGRect underlineRect = _underline.frame;
        underlineRect.origin.x = offsetX/self.storageAllBtn.count;
        _underline.frame = underlineRect;
    }];
}

- (CGFloat)offsetX {
    
    return _offsetX;
}

@end
