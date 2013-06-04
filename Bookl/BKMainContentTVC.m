//
//  BKMainContentTVC.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKMainContentTVC.h"

#import "BKLeftMenu.h"

@interface BKMainContentTVC ()

@end

@implementation BKMainContentTVC

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    if (![self.slidingViewController.underLeftViewController isKindOfClass:[BKLeftMenu class]]) {
//        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenu"];
//    }
//    
//    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
//    [self.slidingViewController setAnchorRightRevealAmount:280.0f];
//}

-(void)setUpViewWithOptions:(NSDictionary *)options
{
    
}

@end
