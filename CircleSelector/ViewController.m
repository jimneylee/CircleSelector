//
//  ViewController.m
//  CircleSelector
//
//  Created by Ken_lu on 12/27/13.
//  Copyright (c) 2013 Ken. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel* label;
@property (nonatomic, strong) NSArray* items;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
     _items = @[@"1", @"2", @"3", @"4", @"5", @"6"];
    
    CircleSelectorView* circleSelectorView = [[CircleSelectorView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    circleSelectorView.center = self.view.center;
    circleSelectorView.normalBackgroundImage = [UIImage imageNamed:@""];
    circleSelectorView.selectedBackgroundImage = [UIImage imageNamed:@"bg_circle_button_blue"];
    circleSelectorView.normalTextColor = [UIColor darkGrayColor];
    circleSelectorView.selectedTextColor = [UIColor whiteColor];
    circleSelectorView.items = _items;
    circleSelectorView.defaultIndex = NSNotFound;
    circleSelectorView.delegate = self;
    [self.view addSubview:circleSelectorView];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    _label = label;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CircleSelectorViewDelegate -
- (void)circleSelectorView:(CircleSelectorView *)pCircleSelectorView selectedWithIndex:(NSUInteger)pIndex
{
    _label.text = [NSString stringWithFormat:@"You selected : %@",_items[pIndex]];
}
@end
