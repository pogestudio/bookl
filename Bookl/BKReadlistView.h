//
//  BKReadlistView.h
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKMainContentTVC.h"

@class ReadList;

@interface BKReadlistView : UITableViewController
{
    @private
    UIPopoverController *_editReadlistPopOver;
}

@property (strong) ReadList *readlist;

@end
