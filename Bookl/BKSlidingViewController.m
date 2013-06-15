//
//  BKSlidingViewController.m
//  Bookl
//
//  Created by CA on 6/11/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKSlidingViewController.h"

#import "UIBarButtonItem+customInit.h"

@interface BKSlidingViewController ()
{
    UIBarButtonItem *_leftButton;
    UIBarButtonItem *_rightButton;
}

@end

@implementation BKSlidingViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [BKColors currentColors].mainCellBackground;
}

-(void)changeLeftBarButtonShow:(BOOL)shouldShow
{
    self.navigationItem.leftBarButtonItem = shouldShow ? [self leftMenuBarButtonItem] : nil;
}

-(void)changeRightBarButtonShow:(BOOL)shouldShow
{
    if (!self.underRightViewController) {
        shouldShow = NO;
    }
    self.navigationItem.rightBarButtonItem = shouldShow ? [self rightMenuBarButtonItem] : nil;
}

-(void)toggleLeftMenu
{
    if (!self.underLeftShowing || self.underRightShowing) {
        [super anchorTopViewTo:ECRight];
    } else {
        [super resetTopView];
    }
}

-(void)toggleRightMenu
{
    if (!self.underRightViewController) {
        return;
    }
    
    if (!self.underRightShowing || self.underLeftShowing) {
        [super anchorTopViewTo:ECLeft];
    } else {
        [super resetTopView];
    }
}

#pragma mark Interface Interaction
-(void)anchorTopViewTo:(ECSide)side
{
    [super anchorTopViewTo:side];
    
    [self changeRightBarButtonShow:!(side == ECLeft)];
    [self changeLeftBarButtonShow:!(side == ECRight)];
}

-(void)resetTopView
{
    [super resetTopView];
    [self changeRightBarButtonShow:YES];
    [self changeLeftBarButtonShow:YES];
}

#pragma mark Button Allocs
- (UIBarButtonItem *)leftMenuBarButtonItem {
    if (!_leftButton) {
        //_leftButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"menu-icon"] target:self action:@selector(toggleLeftMenu)];

        _leftButton = [UIBarButtonItem barItemWithTitle:@"Menu" target:self action:@selector(toggleLeftMenu)];
}
    return _leftButton;
}

- (UIBarButtonItem *)rightMenuBarButtonItem {
    if (!_rightButton) {
        _rightButton = [UIBarButtonItem barItemWithTitle:@"List" target:self action:@selector(toggleRightMenu)];

    }
    return _rightButton;}

@end
