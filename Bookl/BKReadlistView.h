//
//  BKReadlistView.h
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKMainContentTVC.h"
#import "BKReadlistTVHeader.h"
#import "TTSharedBookCell.h"

@class ReadList;

@interface BKReadlistView : UITableViewController <ReadlistHeaderDelegate,SharedBookCellDelegate>
{
    @private
    UIPopoverController *_editReadlistPopOver;
}

@property (strong) ReadList *readlist;
@property (strong) BKReadlistTVHeader *tableHeader;

@end
