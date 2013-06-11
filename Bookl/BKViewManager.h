//
//  BKViewManager.h
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "ECSlidingViewController.h"

typedef enum {
    TypeOfCurrentVCINVALID = 0,
    TypeOfCurrentVCHome,
    TypeOfCurrentVCSearchResult,
    TypeOfCurrentVCReadList,
} TypeOfCurrentVC;

@interface BKViewManager : ECSlidingViewController
{
@private
    UIView *_mainContainerView;
    UIViewController *_currentVC;
    TypeOfCurrentVC _currentVCType;
}

-(void)presentNewVCOfType:(TypeOfCurrentVC)typeOfVC; 


+(BKViewManager*)sharedViewManager;

#pragma mark Menus
-(void)showRightMenu:(UIViewController *)rightMenu;
-(void)reloadMiddleTable;
-(UIViewController*)middleTable;

@end
