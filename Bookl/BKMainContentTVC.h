//
//  BKMainContentTVC.h
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ECSlidingViewController.h"

@class BKViewManager;

@interface BKMainContentTVC : UITableViewController

@property (weak) BKViewManager *viewManager;

+(id)fromStoryboard;

//deliver search query with key "query"
//Read list with key "readlist"
-(void)setUpViewWithOptions:(NSDictionary*)options;


@end
