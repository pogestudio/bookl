//
//  BKHomeVC.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKHomeView.h"
#import "BKSlidingViewController.h"

@implementation BKHomeView

+(id)fromStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    id homeVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
    return homeVC;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BKSlidingViewController sharedInstance] changeNavConTitle:@"News"];
}

@end
