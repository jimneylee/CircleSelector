//
//  CircleSelectorView.m
//  CircleSelector
//
//  Created by Ken_lu on 12/27/13.
//  Copyright (c) 2013 Ken. All rights reserved.
//

#import "CircleSelectorView.h"

@interface CircleSelectorView()

@property (nonatomic, strong) NSMutableArray* buttons;
@property (nonatomic) NSUInteger selectedIndex;

@end

@implementation CircleSelectorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _defaultIndex = NSNotFound;
        _selectedIndex = NSNotFound;
        _buttonFrame = CGRectMake(0, 0, 44, 44);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - interface -
- (void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage
{
    if (_normalBackgroundImage != normalBackgroundImage) {
        _normalBackgroundImage = normalBackgroundImage;
        [self setNeedsDisplay];
    }
}

- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage
{
    if (_selectedBackgroundImage != selectedBackgroundImage) {
        _selectedBackgroundImage = selectedBackgroundImage;
        [self setNeedsDisplay];
    }
}

- (void)setNormalTextColor:(UIColor *)normalTextColor
{
    if (_normalTextColor != normalTextColor) {
        _normalTextColor = normalTextColor;
        [self setNeedsDisplay];
    }
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
    if (_selectedTextColor != selectedTextColor) {
        _selectedTextColor = selectedTextColor;
        [self setNeedsDisplay];
    }
}

- (void)setDefaultIndex:(NSInteger)defaultIndex
{
    if (_defaultIndex != defaultIndex) {
        _defaultIndex = defaultIndex;
        [self setNeedsDisplay];
    }
}

- (void)setButtonFrame:(CGRect)buttonFrame
{
    if (!CGRectEqualToRect(_buttonFrame, buttonFrame)) {
        _buttonFrame = buttonFrame;
        [self setNeedsDisplay];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        [_delegate circleSelectorView:self selectedWithIndex:_selectedIndex];
    }
}
#pragma mark -
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!_items) {
        return;
    }
    
    CGRect rect = self.frame;
    
    float radius = rect.size.width < rect.size.height ? rect.size.width/2 : rect.size.height/2;
    
    float angle = -90;
    
    long increment = 360/_items.count;
    
    float cx = rect.size.width/2;
    float cy = rect.size.height/2;
    
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc] initWithCapacity:_items.count];
    }
    [_buttons removeAllObjects];
    
    for (int i = 0; i < _items.count; i++) {
        
        float x = cx + radius*cos(angle * M_PI / 180); //cos(angle)得出在x轴上的偏移
        float y = cy + radius*sin(angle * M_PI / 180); //sin(angle)得出在y轴上的偏移
        
        //x,y共同确定button的坐标
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = _buttonFrame;
        button.center = CGPointMake(x, y);
        [button setTitle:_items[i] forState:UIControlStateNormal];
        [button setTitleColor:_normalTextColor forState:UIControlStateNormal];
        [button setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        [button setBackgroundImage:_normalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:_selectedBackgroundImage forState:UIControlStateSelected];
        button.tag = i;
        
        if (_defaultIndex == i) {
            button.selected = YES;
        }
        
        [self addSubview:button];
        [_buttons addObject:button];
        angle = angle + increment;
    }
}

#pragma mark - UIButtonAction -
- (void)buttonClicked:(id)sender
{
    for (UIButton* button in _buttons) {
        button.selected = NO;
    }
    UIButton* selectedButton = (UIButton*)sender;
    selectedButton.selected = YES;
    self.selectedIndex = (int)selectedButton.tag;
}

@end
