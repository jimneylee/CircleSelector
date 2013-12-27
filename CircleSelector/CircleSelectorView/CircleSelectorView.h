//
//  CircleSelectorView.h
//  CircleSelector
//
//  Created by Ken_lu on 12/27/13.
//  Copyright (c) 2013 Ken. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CircleSelectorView;
@protocol CircleSelectorViewDelegate <NSObject>

@optional

- (void)circleSelectorView:(CircleSelectorView*)pCircleSelectorView selectedWithIndex:(NSUInteger)pIndex;

@end

@interface CircleSelectorView : UIView

@property (nonatomic, weak) id<CircleSelectorViewDelegate> delegate;
@property (nonatomic, strong) UIImage *normalBackgroundImage;
@property (nonatomic, strong) UIImage *selectedBackgroundImage;
@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic) CGRect buttonFrame;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic) NSInteger defaultIndex;

@end
